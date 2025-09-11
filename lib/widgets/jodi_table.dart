import 'package:dmboss/provider/get_games_chart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/get_charts_data_model.dart';

class JodiTable extends StatefulWidget {
  final String data;
  final String marketName;
  const JodiTable({super.key, required this.data, required this.marketName});

  @override
  State<JodiTable> createState() => _JodiTableState();

  static TableRow _buildRow(
    String date,
    List<String> values,
    List<int> redIndexes,
    bool isSmallScreen,
    bool isVerySmallScreen,
  ) {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[50]),
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(isSmallScreen ? 4 : 6),
            color: Colors.grey[100],
            child: Center(
              child: Text(
                date,
                style: TextStyle(
                  fontSize: isVerySmallScreen
                      ? 8
                      : isSmallScreen
                      ? 8
                      : 9,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        for (int i = 0; i < values.length; i++)
          TableCell(
            child: Container(
              padding: EdgeInsets.all(isSmallScreen ? 4 : 6),
              child: Center(
                child: Text(
                  values[i].isEmpty ? '-' : values[i],
                  style: TextStyle(
                    fontSize: isVerySmallScreen
                        ? 10
                        : isSmallScreen
                        ? 11
                        : 12,
                    color: redIndexes.contains(i) ? Colors.red : Colors.black,
                    fontWeight: redIndexes.contains(i)
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _JodiTableState extends State<JodiTable> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadChartData();
    });
  }

  Future<void> _loadChartData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final provider = Provider.of<GetGamesChartProvider>(
        context,
        listen: false,
      );

      provider.resetData();
      await provider.getChartDataProvider(context, widget.data);
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load Chart. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _retryLoading() {
    _loadChartData();
  }

  DateTime? _parseDate(String dateString) {
    try {
      if (dateString.contains('/')) {
        List<String> parts = dateString.split('/');
        if (parts.length == 3) {
          int day = int.parse(parts[0]);
          int month = int.parse(parts[1]);
          int year = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
      } else if (dateString.contains('-')) {
        return DateTime.parse(dateString);
      }
      return DateTime.parse(dateString);
    } catch (e) {
      print('Error parsing date: $dateString - $e');
      return null;
    }
  }

  List<Map<String, dynamic>> _groupDataByWeek(List<Datum> data) {
    if (data.isEmpty) return [];

    data.sort((a, b) {
      DateTime? dateA = _parseDate(a.date);
      DateTime? dateB = _parseDate(b.date);

      if (dateA == null && dateB == null) return 0;
      if (dateA == null) return -1;
      if (dateB == null) return 1;

      return dateA.compareTo(dateB);
    });

    List<Map<String, dynamic>> weeklyData = [];
    Map<DateTime, List<Datum>> weekMap = {};

    for (var item in data) {
      try {
        DateTime? itemDate = _parseDate(item.date);
        if (itemDate == null) continue;

        DateTime weekStart = _getMonday(itemDate);

        if (!weekMap.containsKey(weekStart)) {
          weekMap[weekStart] = [];
        }
        weekMap[weekStart]!.add(item);
      } catch (e) {
        print('Error processing date: ${item.date}');
      }
    }

    weeklyData = weekMap.entries.map((entry) {
      DateTime weekStart = entry.key;
      DateTime weekEnd = weekStart.add(const Duration(days: 6));
      return {'startDate': weekStart, 'endDate': weekEnd, 'data': entry.value};
    }).toList();

    weeklyData.sort(
      (a, b) =>
          (a['startDate'] as DateTime).compareTo(b['startDate'] as DateTime),
    );

    return weeklyData;
  }

  DateTime _getMonday(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  String _formatDateRange(DateTime start, DateTime end) {
    return '${start.day}/${start.month}/${start.year}\nto\n${end.day}/${end.month}/${end.year}';
  }

  List<String> _getWeeklyJodiValues(List<Datum> weekData) {
    List<String> jodiValues = List.filled(7, '');

    for (var item in weekData) {
      try {
        DateTime? itemDate = _parseDate(item.date);
        if (itemDate == null) continue;

        int dayOfWeek = itemDate.weekday - 1;
        if (dayOfWeek >= 0 && dayOfWeek < 7) {
          jodiValues[dayOfWeek] = item.jodi;
        }
      } catch (e) {
        print('Error processing date: ${item.date}');
      }
    }

    return jodiValues;
  }

  List<int> _findRedIndexes(List<String> values, List<Datum> weekData) {
    List<int> redIndexes = [];

    Map<int, Datum> dayToDatum = {};
    for (var item in weekData) {
      try {
        DateTime? itemDate = _parseDate(item.date);
        if (itemDate == null) continue;

        int dayOfWeek = itemDate.weekday - 1;
        if (dayOfWeek >= 0 && dayOfWeek < 7) {
          dayToDatum[dayOfWeek] = item;
        }
      } catch (e) {
        print('Error processing date: ${item.date}');
      }
    }

    for (int i = 0; i < values.length; i++) {
      if (dayToDatum.containsKey(i)) {
        Datum datum = dayToDatum[i]!;
        String jodiValue = datum.jodi;

        if (jodiValue.isNotEmpty && jodiValue != "-" && jodiValue.length == 2) {
          try {
            int firstDigit = int.parse(jodiValue[0]);
            int secondDigit = int.parse(jodiValue[1]);
            int difference = (firstDigit - secondDigit).abs();

            if (difference == 0 || difference == 5) {
              redIndexes.add(i);
            }
          } catch (e) {
            print('Error parsing jodi digits: ${e.toString()}');
          }
        }
      }
    }

    return redIndexes;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 380;
    final isVerySmallScreen = screenWidth < 340;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 3,
        title: Text(
          "Charts",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isSmallScreen ? 16 : 18,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: isSmallScreen ? 18 : 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<GetGamesChartProvider>(
        builder: (context, chartProvider, child) {
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _errorMessage!,
                    style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _retryLoading,
                    child: Text(
                      'Retry',
                      style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                    ),
                  ),
                ],
              ),
            );
          }

          if (chartProvider.getChartDataModel == null) {
            return Center(
              child: Text(
                'No chart data available',
                style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
              ),
            );
          }

          final chartData = chartProvider.getChartDataModel;
          final weeklyData = _groupDataByWeek(chartData?.data ?? []);

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.blue[900],
                    ),
                    padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
                    child: Text(
                      "${widget.marketName.toUpperCase()} MATKA JODI RECORD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: isSmallScreen ? 12 : 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 6),
                  chartProvider.getChartDataModel?.data.isEmpty ?? true
                      ? Text(
                          "No Data Available for this Market",
                          style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                        )
                      : Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            widget.marketName.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: isSmallScreen ? 11 : 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isSmallScreen ? 4 : 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Table(
                      border: TableBorder.all(
                        color: Colors.grey[400]!,
                        width: 1,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: {
                        0: FixedColumnWidth(
                          isVerySmallScreen
                              ? 50
                              : isSmallScreen
                              ? 55
                              : 60,
                        ),
                        1: FixedColumnWidth(
                          isVerySmallScreen
                              ? 30
                              : isSmallScreen
                              ? 32
                              : 35,
                        ),
                        2: FixedColumnWidth(
                          isVerySmallScreen
                              ? 30
                              : isSmallScreen
                              ? 32
                              : 35,
                        ),
                        3: FixedColumnWidth(
                          isVerySmallScreen
                              ? 30
                              : isSmallScreen
                              ? 32
                              : 35,
                        ),
                        4: FixedColumnWidth(
                          isVerySmallScreen
                              ? 30
                              : isSmallScreen
                              ? 32
                              : 35,
                        ),
                        5: FixedColumnWidth(
                          isVerySmallScreen
                              ? 30
                              : isSmallScreen
                              ? 32
                              : 35,
                        ),
                        6: FixedColumnWidth(
                          isVerySmallScreen
                              ? 30
                              : isSmallScreen
                              ? 32
                              : 35,
                        ),
                        7: FixedColumnWidth(
                          isVerySmallScreen
                              ? 30
                              : isSmallScreen
                              ? 32
                              : 35,
                        ),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.yellow[700]),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(isSmallScreen ? 3 : 4),
                                child: Center(
                                  child: Text(
                                    "DATE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isVerySmallScreen
                                          ? 7
                                          : isSmallScreen
                                          ? 8
                                          : 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(isSmallScreen ? 3 : 4),
                                child: Center(
                                  child: Text(
                                    "MON",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isVerySmallScreen
                                          ? 7
                                          : isSmallScreen
                                          ? 8
                                          : 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(isSmallScreen ? 3 : 4),
                                child: Center(
                                  child: Text(
                                    "TUE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isVerySmallScreen
                                          ? 7
                                          : isSmallScreen
                                          ? 8
                                          : 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(isSmallScreen ? 3 : 4),
                                child: Center(
                                  child: Text(
                                    "WED",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isVerySmallScreen
                                          ? 7
                                          : isSmallScreen
                                          ? 8
                                          : 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(isSmallScreen ? 3 : 4),
                                child: Center(
                                  child: Text(
                                    "THU",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isVerySmallScreen
                                          ? 7
                                          : isSmallScreen
                                          ? 8
                                          : 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(isSmallScreen ? 3 : 4),
                                child: Center(
                                  child: Text(
                                    "FRI",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isVerySmallScreen
                                          ? 7
                                          : isSmallScreen
                                          ? 8
                                          : 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(isSmallScreen ? 3 : 4),
                                child: Center(
                                  child: Text(
                                    "SAT",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isVerySmallScreen
                                          ? 7
                                          : isSmallScreen
                                          ? 8
                                          : 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(isSmallScreen ? 3 : 4),
                                child: Center(
                                  child: Text(
                                    "SUN",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isVerySmallScreen
                                          ? 7
                                          : isSmallScreen
                                          ? 8
                                          : 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        if (weeklyData.isEmpty)
                          TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    isSmallScreen ? 8 : 12,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "No data",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey,
                                        fontSize: isSmallScreen ? 10 : 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              for (int i = 0; i < 7; i++)
                                const TableCell(child: SizedBox.shrink()),
                            ],
                          )
                        else
                          for (var week in weeklyData)
                            JodiTable._buildRow(
                              _formatDateRange(
                                week['startDate'] as DateTime,
                                week['endDate'] as DateTime,
                              ),
                              _getWeeklyJodiValues(week['data'] as List<Datum>),
                              _findRedIndexes(
                                _getWeeklyJodiValues(
                                  week['data'] as List<Datum>,
                                ),
                                week['data'] as List<Datum>,
                              ),
                              isSmallScreen,
                              isVerySmallScreen,
                            ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
