import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/ui/game/bulk_jodi.dart';
import 'package:dmboss/ui/game/bulk_sp.dart';
import 'package:dmboss/ui/game/double_patti.dart';
import 'package:dmboss/ui/game/full_sangam.dart';
import 'package:dmboss/ui/game/bulk_dp.dart';
import 'package:dmboss/ui/game/group_jodi.dart';
import 'package:dmboss/ui/game/half_sangam.dart';
import 'package:dmboss/ui/game/jodi.dart';
import 'package:dmboss/ui/game/panel_group.dart';
import 'package:dmboss/ui/game/single_ank.dart';
import 'package:dmboss/ui/game/single_patti.dart';
import 'package:dmboss/ui/game/tripple_patti.dart';
import 'package:dmboss/util/get_current_time.dart';
import 'package:dmboss/util/get_time_in_12_hours.dart';
import 'package:dmboss/widgets/game_list_card.dart';
import 'package:flutter/material.dart';

class GameListScreen extends StatelessWidget {
  final String title, openTime, closeTime, marketId, resultStatus;
  const GameListScreen({
    super.key,
    required this.title,
    required this.openTime,
    required this.closeTime,
    required this.marketId,
    required this.resultStatus,
  });

  bool _isBeforeOpenTime() {
    final currentTime = getCurrentTimeFormatted();
    return _compareTimes(currentTime, openTime) > 0;
  }

  int _compareTimes(String time1, String time2) {
    try {
      final dateTime1 = _parseTimeString(time1);
      final dateTime2 = _parseTimeString(time2);
      return dateTime1.compareTo(dateTime2);
    } catch (e) {
      return 0;
    }
  }

  DateTime _parseTimeString(String timeString) {
    final now = DateTime.now();

    String cleanedTime = timeString
        .trim()
        .replaceAll(' ', '')
        .replaceAll('.', ':');

    if (cleanedTime.contains(RegExp(r'^\d{1,2}:\d{2}$'))) {
      final parts = cleanedTime.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      if (hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59) {
        return DateTime(now.year, now.month, now.day, hour, minute);
      }
    }

    return now;
  }

  bool _isAfterCloseTime() {
    final currentTime = getCurrentTimeFormatted();
    return _compareTimes(currentTime, closeTime) > 0;
  }

  bool isVenueOpen() {
    return !_isBeforeOpenTime() && !_isAfterCloseTime();
  }

  List<Map<String, dynamic>> _getFilteredGames() {
    try {
      if (_isBeforeOpenTime()) {
        final limitedGames = [
          'Single Ank',
          'Single Patti',
          'Double Patti',
          'Tripple Patti',
          'Panel Group',
          'Bulk SP',
          'Bulk DP',
        ];

        return gameList
            .where((game) => limitedGames.contains(game['title']))
            .toList();
      } else {
        return gameList;
      }
    } catch (e) {
      return gameList;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredGames = _getFilteredGames();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Center(
              child: Text(
                "${convertTimeStringTo12HourFormat(openTime)} - ${convertTimeStringTo12HourFormat(closeTime)}",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 30,
            childAspectRatio: 0.9,
          ),
          itemCount: filteredGames.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (filteredGames[index]['id'] == 7) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullSangam(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        marketId: marketId,
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 12) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Bulk_Dp(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        openTime: openTime,
                        marketId: marketId,
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleAnk(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        marketId: marketId,
                        openTime: openTime,
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Jodi(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        marketId: marketId,
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SinglePatti(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        marketId: marketId,
                        openTime: openTime,
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoublePatti(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        marketId: marketId,
                        openTime: openTime,
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 5) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TripplePatti(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        marketId: marketId,
                        openTime: openTime,
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 8) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupJodi(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        marketId: marketId,
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 9) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PanelGroup(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        marketId: marketId,
                        openTime: openTime,
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 6) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HalfSangam(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        marketId: marketId,
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 10) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BulkJodii(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        marketId: marketId,
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 11) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BulkSP(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        openTime: openTime,
                        marketId: marketId,
                      ),
                    ),
                  );
                }
              },
              child: GameListCard(
                title: filteredGames[index]["title"],
                icon: filteredGames[index]["icon"],
              ),
            );
          },
        ),
      ),
    );
  }
}
