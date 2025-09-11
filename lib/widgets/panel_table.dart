import 'package:dmboss/provider/get_games_chart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/get_charts_data_model.dart';

class PanelTable extends StatefulWidget {
  final String data;
  final String marketName;
  const PanelTable({super.key, required this.data, required this.marketName});

  @override
  State<PanelTable> createState() => _PanelTableState();

  static TableRow _buildRow(
    String date,
    List<List<String>> values,
    List<int> redIndexes,
    bool isSmallScreen,
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
                  fontSize: isSmallScreen ? 7 : 9,
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
              padding: EdgeInsets.all(isSmallScreen ? 2 : 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        values[i][0],
                        style: TextStyle(
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Text(
                        values[i][1],
                        style: TextStyle(
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Text(
                        values[i][2],
                        style: TextStyle(
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Center(
                        child: Text(
                          values[i][3],
                          style: TextStyle(
                            fontSize: isSmallScreen ? 10 : 12,
                            fontWeight: FontWeight.bold,
                            color: redIndexes.contains(i)
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        values[i][4],
                        style: TextStyle(
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Text(
                        values[i][5],
                        style: TextStyle(
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Text(
                        values[i][6],
                        style: TextStyle(
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _PanelTableState extends State<PanelTable> {
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

  List<String> _datumToValues(Datum datum) {
    List<String> openPannaParts = [];
    if (datum.openPanna.isNotEmpty && datum.openPanna != "-") {
      openPannaParts = datum.openPanna.split('');
    }

    while (openPannaParts.length < 3) {
      openPannaParts.add("*");
    }

    List<String> closePannaParts = [];
    if (datum.closePanna.isNotEmpty && datum.closePanna != "-") {
      closePannaParts = datum.closePanna.split('');
    }

    while (closePannaParts.length < 3) {
      closePannaParts.add("*");
    }

    String jodiValue = "-";
    if (datum.jodi.isNotEmpty && datum.jodi != "-") {
      jodiValue = datum.jodi;
    } else if (datum.open.isNotEmpty && datum.close.isNotEmpty) {
      jodiValue = "${datum.open}${datum.close}";
    } else if (datum.open.isNotEmpty) {
      jodiValue = datum.open;
    } else if (datum.close.isNotEmpty) {
      jodiValue = datum.close;
    }

    return [
      openPannaParts[0],
      openPannaParts.length > 1 ? openPannaParts[1] : "*",
      openPannaParts.length > 2 ? openPannaParts[2] : "*",
      jodiValue,
      closePannaParts[0],
      closePannaParts.length > 1 ? closePannaParts[1] : "*",
      closePannaParts.length > 2 ? closePannaParts[2] : "*",
    ];
  }

  List<List<String>> _getWeeklyPanelValues(List<Datum> weekData) {
    List<List<String>> panelValues = List.generate(
      7,
      (_) => ["*", "*", "*", "-", "*", "*", "*"],
    );

    for (var item in weekData) {
      try {
        DateTime? itemDate = _parseDate(item.date);
        if (itemDate == null) continue;

        int dayOfWeek = itemDate.weekday - 1;
        if (dayOfWeek >= 0 && dayOfWeek < 7) {
          panelValues[dayOfWeek] = _datumToValues(item);
        }
      } catch (e) {
        print('Error processing date: ${item.date}');
      }
    }

    return panelValues;
  }

  List<int> _findRedIndexes(List<List<String>> values, List<Datum> weekData) {
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

        if (datum.open.isNotEmpty &&
            datum.close.isNotEmpty &&
            datum.open != "-" &&
            datum.close != "-") {
          try {
            int openValue = int.parse(datum.open);
            int closeValue = int.parse(datum.close);
            int difference = (openValue - closeValue).abs();

            if (difference == 0 || difference == 5) {
              redIndexes.add(i);
            }
          } catch (e) {
            print('Error parsing open/close values: ${e.toString()}');
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
                      "${widget.marketName.toUpperCase()} MATKA PANEL RECORD",
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
                              ? 36
                              : isSmallScreen
                              ? 38
                              : 42,
                        ),
                        2: FixedColumnWidth(
                          isVerySmallScreen
                              ? 36
                              : isSmallScreen
                              ? 38
                              : 42,
                        ),
                        3: FixedColumnWidth(
                          isVerySmallScreen
                              ? 36
                              : isSmallScreen
                              ? 38
                              : 42,
                        ),
                        4: FixedColumnWidth(
                          isVerySmallScreen
                              ? 36
                              : isSmallScreen
                              ? 38
                              : 42,
                        ),
                        5: FixedColumnWidth(
                          isVerySmallScreen
                              ? 36
                              : isSmallScreen
                              ? 38
                              : 42,
                        ),
                        6: FixedColumnWidth(
                          isVerySmallScreen
                              ? 36
                              : isSmallScreen
                              ? 38
                              : 42,
                        ),
                        7: FixedColumnWidth(
                          isVerySmallScreen
                              ? 36
                              : isSmallScreen
                              ? 38
                              : 42,
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
                            PanelTable._buildRow(
                              _formatDateRange(
                                week['startDate'] as DateTime,
                                week['endDate'] as DateTime,
                              ),
                              _getWeeklyPanelValues(
                                week['data'] as List<Datum>,
                              ),
                              _findRedIndexes(
                                _getWeeklyPanelValues(
                                  week['data'] as List<Datum>,
                                ),
                                week['data'] as List<Datum>,
                              ),
                              isSmallScreen,
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
