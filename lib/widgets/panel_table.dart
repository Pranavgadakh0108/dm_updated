// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class PanelTable extends StatelessWidget {
  final String data;
  const PanelTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 3,
        title: const Text(
          "Charts",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              // padding: const EdgeInsets.all(8),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header section
                      SizedBox(
                        width: _calculateTableWidth(),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.blue[900],
                              //padding: const EdgeInsets.all(8),
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                              width: double.infinity,
                              child: Text(
                                "${data.toUpperCase()} MATKA PANEL RECORD 2025 - 2026",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              // padding: const EdgeInsets.all(6),
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: const Border.symmetric(
                                  vertical: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  data.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Table
                      SizedBox(
                        width: _calculateTableWidth(),
                        child: Table(
                          border: TableBorder.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: const {
                            0: FixedColumnWidth(50),
                            1: FixedColumnWidth(40),
                            2: FixedColumnWidth(40),
                            3: FixedColumnWidth(40),
                            4: FixedColumnWidth(40),
                            5: FixedColumnWidth(40),
                            6: FixedColumnWidth(40),
                            7: FixedColumnWidth(40),
                          },
                          children: [
                            // Header Row
                            TableRow(
                              decoration: BoxDecoration(
                                color: Colors.yellow[700],
                              ),
                              children: const [
                                _headerCell("Date"),
                                _headerCell("Mon"),
                                _headerCell("Tue"),
                                _headerCell("Wed"),
                                _headerCell("Thu"),
                                _headerCell("Fri"),
                                _headerCell("Sat"),
                                _headerCell("Sun"),
                              ],
                            ),
                            // Sample Data Rows
                            _buildRow(
                              "01/01/2024\nto\n07/01/2024",
                              [
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [2],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [1],
                            ),
                            _buildRow(
                              "01/01/2024\nto\n07/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [4],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [3],
                            ),
                            _buildRow(
                              "01/01/2024\nto\n07/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [2],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [1],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [1],
                            ),
                            _buildRow(
                              "01/01/2024\nto\n07/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [4],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [3],
                            ),
                            _buildRow(
                              "01/01/2024\nto\n07/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [2],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [1],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [1],
                            ),
                            _buildRow(
                              "01/01/2024\nto\n07/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [2],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [4],
                            ),
                            _buildRow(
                              "01/01/2024\nto\n07/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [3],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              [
                                ["5", "*", "1", "93", "7", "3", "8"],
                                ["2", "*", "1", "82", "7", "3", "3"],
                                ["1", "*", "1", "44", "7", "3", "0"],
                                ["*", "*", "*", "69", "*", "*", "*"],
                                ["4", "*", "1", "60", "7", "3", "5"],
                                ["1", "*", "1", "29", "7", "3", "9"],
                                ["2", "*", "1", "64", "7", "3", "0"],
                              ],
                              [1],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  double _calculateTableWidth() {
    // Date column + 7 day columns
    return 80 + (60 * 7);
  }

  static TableRow _buildRow(
    String date,
    List<List<String>> values,
    List<int> redIndexes,
  ) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Center(
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        for (int i = 0; i < values.length; i++)
          TableCell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //left column
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        values[i][0],
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Text(
                        values[i][1],
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Text(
                        values[i][2],
                        style: TextStyle(
                          fontSize: 8,
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
                          values[i][3],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: redIndexes.contains(i)
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // right column
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        values[i][4],
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Text(
                        values[i][5],
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: redIndexes.contains(i)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      Text(
                        values[i][6],
                        style: TextStyle(
                          fontSize: 8,
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

class _headerCell extends StatelessWidget {
  final String text;
  const _headerCell(this.text);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
