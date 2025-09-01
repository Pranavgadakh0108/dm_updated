import 'package:flutter/material.dart';

class JodiTable extends StatelessWidget {
  final String data;
  const JodiTable({super.key, required this.data});

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
              //padding: const EdgeInsets.all(8.0),
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
                              // padding: const EdgeInsets.all(8),
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                              width: double.infinity,
                              child: Text(
                                "${data.toUpperCase()} MATKA JODI RECORD 2025 - 2026",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              //padding: const EdgeInsets.all(6),
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.symmetric(
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
                            0: FixedColumnWidth(40),
                            1: FixedColumnWidth(8),
                            2: FixedColumnWidth(8),
                            3: FixedColumnWidth(8),
                            4: FixedColumnWidth(8),
                            5: FixedColumnWidth(8),
                            6: FixedColumnWidth(8),
                            7: FixedColumnWidth(8),
                          },
                          children: [
                            // Header Row
                            TableRow(
                              decoration: BoxDecoration(
                                color: Colors.yellow[700],
                              ),
                              children: const [
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      "Date",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      "Mon",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      "Tue",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      "Wed",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      "Thu",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      "Fri",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      "Sat",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      "Sun",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Sample Data Rows
                            _buildRow(
                              "01/01/2024\nto\n07/01/2024",
                              ["93", "82", "44", "69", "60", "29", "64"],
                              [2],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              ["75", "73", "88", "95", "01", "21", "76"],
                              [2],
                            ),
                            _buildRow(
                              "15/01/2024\nto\n21/01/2024",
                              ["12", "85", "16", "23", "42", "01", "38"],
                              [3],
                            ),
                            _buildRow(
                              "01/01/2024\nto\n07/01/2024",
                              ["93", "82", "44", "69", "60", "29", "64"],
                              [4],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              ["75", "73", "88", "95", "01", "21", "76"],
                              [2],
                            ),
                            _buildRow(
                              "15/01/2024\nto\n21/01/2024",
                              ["12", "85", "16", "23", "42", "01", "38"],
                              [2],
                            ),
                            _buildRow(
                              "01/01/2024\nto\n07/01/2024",
                              ["93", "82", "44", "69", "60", "29", "64"],
                              [1],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              ["75", "73", "88", "95", "01", "21", "76"],
                              [2],
                            ),
                            _buildRow(
                              "15/01/2024\nto\n21/01/2024",
                              ["12", "85", "16", "23", "42", "01", "38"],
                              [3],
                            ),
                            _buildRow(
                              "01/01/2024\nto\n07/01/2024",
                              ["93", "82", "44", "69", "60", "29", "64"],
                              [2],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              ["75", "73", "88", "95", "01", "21", "76"],
                              [4],
                            ),
                            _buildRow(
                              "15/01/2024\nto\n21/01/2024",
                              ["12", "85", "16", "23", "42", "01", "38"],
                              [5],
                            ),
                            _buildRow(
                              "01/01/2024\nto\n07/01/2024",
                              ["93", "82", "44", "69", "60", "29", "64"],
                              [4],
                            ),
                            _buildRow(
                              "08/01/2024\nto\n14/01/2024",
                              ["75", "73", "88", "95", "01", "21", "76"],
                              [6],
                            ),
                            _buildRow(
                              "15/01/2024\nto\n21/01/2024",
                              ["12", "85", "16", "23", "42", "01", "38"],
                              [4],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
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
    // Sum of all column widths
    return 140 + (39 * 7); // Date column + 7 day columns
  }

  static TableRow _buildRow(
    String date,
    List<String> values,
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
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        for (int i = 0; i < values.length; i++)
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Center(
                child: Text(
                  values[i],
                  style: TextStyle(
                    fontSize: 11,
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
