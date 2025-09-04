import 'package:dmboss/provider/game_market_provider.dart';
import 'package:dmboss/widgets/jodi_table.dart';
import 'package:dmboss/widgets/panel_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

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
      body: Consumer<GameMarketProvider>(
        builder: (context, market, _) {
          return ListView.builder(
            // padding: EdgeInsets.all(8),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            itemCount: market.gamesList?.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.symmetric(vertical: 6),
                child: Padding(
                  //padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01,
                    vertical: MediaQuery.of(context).size.height * 0.012,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          market.gamesList?[index].bazar ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JodiTable(
                                    data: market.gamesList?[index].id ?? "",
                                    marketName:
                                        market.gamesList?[index].bazar ?? "",
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "JODI",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PanelTable(
                                    data: market.gamesList?[index].id ?? "",
                                    marketName:
                                        market.gamesList?[index].bazar ?? "",
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "PANEL",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
