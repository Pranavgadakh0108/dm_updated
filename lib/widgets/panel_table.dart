// // ignore_for_file: camel_case_types

// import 'package:dmboss/provider/get_games_chart_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../model/get_charts_data_model.dart';

// class PanelTable extends StatefulWidget {
//   final String data;
//   final String marketName;
//   const PanelTable({super.key, required this.data, required this.marketName});

//   @override
//   State<PanelTable> createState() => _PanelTableState();

//   static TableRow _buildRow(
//     String date,
//     List<List<String>> values,
//     List<int> redIndexes,
//   ) {
//     return TableRow(
//       decoration: BoxDecoration(
//         color: Colors.grey[50], // Light background for better readability
//       ),
//       children: [
//         TableCell(
//           child: Container(
//             padding: const EdgeInsets.all(6),
//             color: Colors
//                 .grey[100], // Slightly different background for date column
//             child: Center(
//               child: Text(
//                 date,
//                 style: const TextStyle(
//                   fontSize: 10,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ),
//         for (int i = 0; i < values.length; i++)
//           TableCell(
//             child: Container(
//               padding: const EdgeInsets.all(6),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Left column
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         values[i][0].isEmpty ? '-' : values[i][0],
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600,
//                           color: redIndexes.contains(i)
//                               ? Colors.red
//                               : Colors.black,
//                         ),
//                       ),
//                       Text(
//                         values[i][1].isEmpty ? '-' : values[i][1],
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600,
//                           color: redIndexes.contains(i)
//                               ? Colors.red
//                               : Colors.black,
//                         ),
//                       ),
//                       Text(
//                         values[i][2].isEmpty ? '-' : values[i][2],
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600,
//                           color: redIndexes.contains(i)
//                               ? Colors.red
//                               : Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Middle big number
//                   Column(
//                     children: [
//                       Center(
//                         child: Text(
//                           values[i][3].isEmpty ? '-' : values[i][3],
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                             color: redIndexes.contains(i)
//                                 ? Colors.red
//                                 : Colors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Right column
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         values[i][4].isEmpty ? '-' : values[i][4],
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600,
//                           color: redIndexes.contains(i)
//                               ? Colors.red
//                               : Colors.black,
//                         ),
//                       ),
//                       Text(
//                         values[i][5].isEmpty ? '-' : values[i][5],
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600,
//                           color: redIndexes.contains(i)
//                               ? Colors.red
//                               : Colors.black,
//                         ),
//                       ),
//                       Text(
//                         values[i][6].isEmpty ? '-' : values[i][6],
//                         style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600,
//                           color: redIndexes.contains(i)
//                               ? Colors.red
//                               : Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// class _PanelTableState extends State<PanelTable> {
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadChartData();
//     });
//   }

//   Future<void> _loadChartData() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final provider = Provider.of<GetGamesChartProvider>(
//         context,
//         listen: false,
//       );

//       provider.resetData();
//       await provider.getChartDataProvider(context, widget.data);
//     } catch (error) {
//       setState(() {
//         _errorMessage = 'Failed to load Chart. Please try again.';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _retryLoading() {
//     _loadChartData();
//   }

//   // Helper method to parse date from "dd/MM/yyyy" format
//   DateTime? _parseDate(String dateString) {
//     try {
//       // Handle different date formats
//       if (dateString.contains('/')) {
//         // Format: "dd/MM/yyyy"
//         List<String> parts = dateString.split('/');
//         if (parts.length == 3) {
//           int day = int.parse(parts[0]);
//           int month = int.parse(parts[1]);
//           int year = int.parse(parts[2]);
//           return DateTime(year, month, day);
//         }
//       } else if (dateString.contains('-')) {
//         // Format: "yyyy-MM-dd" (ISO format)
//         return DateTime.parse(dateString);
//       }

//       // If format is not recognized, try parsing directly
//       return DateTime.parse(dateString);
//     } catch (e) {
//       print('Error parsing date: $dateString - $e');
//       return null;
//     }
//   }

//   // Helper method to group data by week and ensure correct day matching
//   List<Map<String, dynamic>> _groupDataByWeek(List<Datum> data) {
//     if (data.isEmpty) return [];

//     // Sort data by date in ascending order
//     data.sort((a, b) {
//       DateTime? dateA = _parseDate(a.date);
//       DateTime? dateB = _parseDate(b.date);

//       if (dateA == null && dateB == null) return 0;
//       if (dateA == null) return -1;
//       if (dateB == null) return 1;

//       return dateA.compareTo(dateB);
//     });

//     List<Map<String, dynamic>> weeklyData = [];
//     Map<DateTime, List<Datum>> weekMap = {};

//     // Group data by week
//     for (var item in data) {
//       try {
//         DateTime? itemDate = _parseDate(item.date);
//         if (itemDate == null) continue;

//         // Get Monday of the week for this date
//         DateTime weekStart = _getMonday(itemDate);

//         if (!weekMap.containsKey(weekStart)) {
//           weekMap[weekStart] = [];
//         }
//         weekMap[weekStart]!.add(item);
//       } catch (e) {
//         print('Error processing date: ${item.date}');
//       }
//     }

//     // Convert to list and sort by week start date
//     weeklyData = weekMap.entries.map((entry) {
//       DateTime weekStart = entry.key;
//       DateTime weekEnd = weekStart.add(const Duration(days: 6));
//       return {'startDate': weekStart, 'endDate': weekEnd, 'data': entry.value};
//     }).toList();

//     // Sort by week start date
//     weeklyData.sort(
//       (a, b) =>
//           (a['startDate'] as DateTime).compareTo(b['startDate'] as DateTime),
//     );

//     return weeklyData;
//   }

//   // Get Monday of the week for a given date
//   DateTime _getMonday(DateTime date) {
//     return date.subtract(Duration(days: date.weekday - 1));
//   }

//   // Format date for display
//   String _formatDateRange(DateTime start, DateTime end) {
//     return '${start.day.toString().padLeft(2, '0')}/${start.month.toString().padLeft(2, '0')}/${start.year}\nto\n${end.day.toString().padLeft(2, '0')}/${end.month.toString().padLeft(2, '0')}/${end.year}';
//   }

//   // Convert Datum to table values
//   List<String> _datumToValues(Datum datum) {
//     return [
//       datum.openPanna.isNotEmpty
//           ? datum.openPanna[0]
//           : "*", // First digit of open panna
//       "*", // Middle star
//       datum.openPanna.length > 1
//           ? datum.openPanna[1]
//           : "*", // Second digit of open panna
//       datum.jodi, // Jodi (main number)
//       datum.closePanna.isNotEmpty
//           ? datum.closePanna[0]
//           : "*", // First digit of close panna
//       "*", // Middle star
//       datum.closePanna.length > 1
//           ? datum.closePanna[1]
//           : "*", // Second digit of close panna
//     ];
//   }

//   // Get panel values for a week, ordered by day of week (Monday to Sunday)
//   List<List<String>> _getWeeklyPanelValues(List<Datum> weekData) {
//     List<List<String>> panelValues = List.generate(
//       7,
//       (_) => ["*", "*", "*", "-", "*", "*", "*"],
//     ); // Monday to Sunday

//     for (var item in weekData) {
//       try {
//         DateTime? itemDate = _parseDate(item.date);
//         if (itemDate == null) continue;

//         int dayOfWeek = itemDate.weekday - 1; // Monday = 0, Sunday = 6

//         if (dayOfWeek >= 0 && dayOfWeek < 7) {
//           panelValues[dayOfWeek] = _datumToValues(item);
//         }
//       } catch (e) {
//         print('Error processing date: ${item.date}');
//       }
//     }

//     return panelValues;
//   }

//   // Find red indexes (empty or problematic values)
//   List<int> _findRedIndexes(List<List<String>> values) {
//     List<int> redIndexes = [];
//     for (int i = 0; i < values.length; i++) {
//       if (values[i][3] == "00" || values[i][3] == "0") {
//         redIndexes.add(i);
//       }
//     }
//     return redIndexes;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         elevation: 3,
//         title: const Text(
//           "Charts",
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Consumer<GetGamesChartProvider>(
//         builder: (context, chartProvider, child) {
//           if (_isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (_errorMessage != null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(_errorMessage!),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _retryLoading,
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (chartProvider.getChartDataModel == null) {
//             return const Center(child: Text('No chart data available'));
//           }

//           final chartData = chartProvider.getChartDataModel;
//           final weeklyData = _groupDataByWeek(chartData?.data ?? []);

//           return SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Header section
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.blue[900],
//                     ),
//                     padding: const EdgeInsets.all(16),
//                     child: Text(
//                       "${widget.marketName.toUpperCase()} MATKA PANEL RECORD",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   chartProvider.getChartDataModel?.data.isEmpty ?? true
//                       ? Text("No Data Available for this Market")
//                       : Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.grey[300]!),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             widget.marketName.toUpperCase(),
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                   const SizedBox(height: 16),

//                   // Table with full width
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Container(
//                       width: screenWidth * 1.2, // Slightly wider for panel data
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey[400]!),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Table(
//                         border: TableBorder.all(
//                           color: Colors.grey[400]!,
//                           width: 1,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         defaultVerticalAlignment:
//                             TableCellVerticalAlignment.middle,
//                         columnWidths: {
//                           0: FixedColumnWidth(
//                             screenWidth * 0.20,
//                           ), // Date column - 20% of screen
//                           1: FixedColumnWidth(
//                             screenWidth * 0.14,
//                           ), // Mon - ~14% each (wider for panel data)
//                           2: FixedColumnWidth(screenWidth * 0.14), // Tue
//                           3: FixedColumnWidth(screenWidth * 0.14), // Wed
//                           4: FixedColumnWidth(screenWidth * 0.14), // Thu
//                           5: FixedColumnWidth(screenWidth * 0.14), // Fri
//                           6: FixedColumnWidth(screenWidth * 0.14), // Sat
//                           7: FixedColumnWidth(screenWidth * 0.14), // Sun
//                         },
//                         children: [
//                           // Header Row
//                           TableRow(
//                             decoration: BoxDecoration(
//                               color: Colors.yellow[700],
//                             ),
//                             children: const [
//                               TableCell(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8),
//                                   child: Center(
//                                     child: Text(
//                                       "DATE RANGE",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               TableCell(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8),
//                                   child: Center(
//                                     child: Text(
//                                       "MON",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               TableCell(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8),
//                                   child: Center(
//                                     child: Text(
//                                       "TUE",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               TableCell(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8),
//                                   child: Center(
//                                     child: Text(
//                                       "WED",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               TableCell(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8),
//                                   child: Center(
//                                     child: Text(
//                                       "THU",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               TableCell(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8),
//                                   child: Center(
//                                     child: Text(
//                                       "FRI",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               TableCell(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8),
//                                   child: Center(
//                                     child: Text(
//                                       "SAT",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               TableCell(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8),
//                                   child: Center(
//                                     child: Text(
//                                       "SUN",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // Data Rows
//                           if (weeklyData.isEmpty)
//                             TableRow(
//                               children: [
//                                 const TableCell(
//                                   child: Padding(
//                                     padding: EdgeInsets.all(16),
//                                     child: Center(
//                                       child: Text(
//                                         "No data available",
//                                         style: TextStyle(
//                                           fontStyle: FontStyle.italic,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 for (int i = 0; i < 7; i++)
//                                   const TableCell(child: SizedBox.shrink()),
//                               ],
//                             )
//                           else
//                             for (var week in weeklyData)
//                               PanelTable._buildRow(
//                                 _formatDateRange(
//                                   week['startDate'] as DateTime,
//                                   week['endDate'] as DateTime,
//                                 ),
//                                 _getWeeklyPanelValues(
//                                   week['data'] as List<Datum>,
//                                 ),
//                                 _findRedIndexes(
//                                   _getWeeklyPanelValues(
//                                     week['data'] as List<Datum>,
//                                   ),
//                                 ),
//                               ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// ignore_for_file: camel_case_types

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
      decoration: BoxDecoration(
        color: Colors.grey[50],
      ),
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
                  // Left column
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        values[i][0].isEmpty ? '-' : values[i][0],
                        style: TextStyle(
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Text(
                        values[i][1].isEmpty ? '-' : values[i][1],
                        style: TextStyle(
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Text(
                        values[i][2].isEmpty ? '-' : values[i][2],
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
                  // Middle big number
                  Column(
                    children: [
                      Center(
                        child: Text(
                          values[i][3].isEmpty ? '-' : values[i][3],
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
                  // Right column
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        values[i][4].isEmpty ? '-' : values[i][4],
                        style: TextStyle(
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Text(
                        values[i][5].isEmpty ? '-' : values[i][5],
                        style: TextStyle(
                          fontSize: isSmallScreen ? 8 : 10,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Text(
                        values[i][6].isEmpty ? '-' : values[i][6],
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

  // Helper method to parse date from "dd/MM/yyyy" format
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

  // Helper method to group data by week and ensure correct day matching
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

  // Get Monday of the week for a given date
  DateTime _getMonday(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  // Format date for display
  String _formatDateRange(DateTime start, DateTime end) {
    return '${start.day}/${start.month}/${start.year}\nto\n${end.day}/${end.month}/${end.year}';
  }

  // Convert Datum to table values
  List<String> _datumToValues(Datum datum) {
    return [
      datum.openPanna.isNotEmpty ? datum.openPanna[0] : "*",
      "*",
      datum.openPanna.length > 1 ? datum.openPanna[1] : "*",
      datum.jodi,
      datum.closePanna.isNotEmpty ? datum.closePanna[0] : "*",
      "*",
      datum.closePanna.length > 1 ? datum.closePanna[1] : "*",
    ];
  }

  // Get panel values for a week, ordered by day of week (Monday to Sunday)
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

  // Find red indexes (empty or problematic values)
  List<int> _findRedIndexes(List<List<String>> values) {
    List<int> redIndexes = [];
    for (int i = 0; i < values.length; i++) {
      if (values[i][3] == "00" || values[i][3] == "0") {
        redIndexes.add(i);
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
          icon: Icon(
            Icons.arrow_back_ios,
            size: isSmallScreen ? 18 : 24,
          ),
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

                  // Responsive table
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
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      columnWidths: {
                        0: FixedColumnWidth(isVerySmallScreen ? 50 : isSmallScreen ? 55 : 60),
                        1: FixedColumnWidth(isVerySmallScreen ? 36 : isSmallScreen ? 38 : 42),
                        2: FixedColumnWidth(isVerySmallScreen ? 36 : isSmallScreen ? 38 : 42),
                        3: FixedColumnWidth(isVerySmallScreen ? 36 : isSmallScreen ? 38 : 42),
                        4: FixedColumnWidth(isVerySmallScreen ? 36 : isSmallScreen ? 38 : 42),
                        5: FixedColumnWidth(isVerySmallScreen ? 36 : isSmallScreen ? 38 : 42),
                        6: FixedColumnWidth(isVerySmallScreen ? 36 : isSmallScreen ? 38 : 42),
                        7: FixedColumnWidth(isVerySmallScreen ? 36 : isSmallScreen ? 38 : 42),
                      },
                      children: [
                        // Header Row
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.yellow[700],
                          ),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(isSmallScreen ? 3 : 4),
                                child: Center(
                                  child: Text(
                                    "DATE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isVerySmallScreen ? 7 : isSmallScreen ? 8 : 9,
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
                                      fontSize: isVerySmallScreen ? 7 : isSmallScreen ? 8 : 9,
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
                                      fontSize: isVerySmallScreen ? 7 : isSmallScreen ? 8 : 9,
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
                                      fontSize: isVerySmallScreen ? 7 : isSmallScreen ? 8 : 9,
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
                                      fontSize: isVerySmallScreen ? 7 : isSmallScreen ? 8 : 9,
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
                                      fontSize: isVerySmallScreen ? 7 : isSmallScreen ? 8 : 9,
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
                                      fontSize: isVerySmallScreen ? 7 : isSmallScreen ? 8 : 9,
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
                                      fontSize: isVerySmallScreen ? 7 : isSmallScreen ? 8 : 9,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Data Rows
                        if (weeklyData.isEmpty)
                          TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
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
