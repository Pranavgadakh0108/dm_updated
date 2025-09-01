// // ignore_for_file: non_constant_identifier_names

// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/ui/game/bulk_jodi.dart';
// import 'package:dmboss/ui/game/bulk_sp.dart';
// import 'package:dmboss/ui/game/double_patti.dart';
// import 'package:dmboss/ui/game/full_sangam.dart';
// import 'package:dmboss/ui/game/bulk_dp.dart';
// import 'package:dmboss/ui/game/group_jodi.dart';
// import 'package:dmboss/ui/game/half_sangam.dart';
// import 'package:dmboss/ui/game/jodi.dart';
// import 'package:dmboss/ui/game/panel_group.dart';
// import 'package:dmboss/ui/game/single_ank.dart';
// import 'package:dmboss/ui/game/single_patti.dart';
// import 'package:dmboss/ui/game/tripple_patti.dart';
// import 'package:dmboss/widgets/game_list_card.dart';
// import 'package:flutter/material.dart';

// class GameListScreen extends StatelessWidget {
//   final String title, openTime, closeTime;
//   const GameListScreen({
//     super.key,
//     required this.title,
//     required this.openTime,
//     required this.closeTime,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text(
//           title,
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//         ),
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 10),
//             child: Center(
//               child: Text(
//                 "$openTime - $closeTime ",
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//               ),
//             ),
//           ),
//         ],
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3, // 3 items in a row
//             crossAxisSpacing: 15,
//             mainAxisSpacing: 15,
//             childAspectRatio: 0.9,
//           ),
//           itemCount: gameList.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 if (gameList[index]['title'] == "Full Sangam") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => FullSangam(
//                         title: gameList[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (gameList[index]['title'] == "Bulk DP") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           BulkDp(title: gameList[index]['title']),
//                     ),
//                   );
//                 } else if (gameList[index]['title'] == "Single Ank") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SingleAnk(
//                         title: gameList[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (gameList[index]['title'] == "Jodi") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Jodi(
//                         title: gameList[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (gameList[index]['title'] == "Single Patti") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SinglePatti(
//                         title: gameList[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (gameList[index]['title'] == "Double Patti") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DoublePatti(
//                         title: gameList[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (gameList[index]['title'] == "Tripple Patti") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TripplePatti(
//                         title: gameList[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (gameList[index]['title'] == "Group Jodi") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => GroupJodi(
//                         title: gameList[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (gameList[index]['title'] == "Panel Group") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PanelGroup(
//                         title: gameList[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (gameList[index]['title'] == "Half Sangam") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => HalfSangam(
//                         title: gameList[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (gameList[index]['title'] == "Bulk Jodi") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           BulkJodi(title: gameList[index]['title']),
//                     ),
//                   );
//                 } else if (gameList[index]['title'] == "Bulk SP") {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           BulkSp(title: gameList[index]['title']),
//                     ),
//                   );
//                 }
//               },
//               child: GameListCard(
//                 title: gameList[index]["title"],
//                 icon: gameList[index]["icon"],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: non_constant_identifier_names

// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/ui/game/bulk_jodi.dart';
// import 'package:dmboss/ui/game/bulk_sp.dart';
// import 'package:dmboss/ui/game/double_patti.dart';
// import 'package:dmboss/ui/game/full_sangam.dart';
// import 'package:dmboss/ui/game/bulk_dp.dart';
// import 'package:dmboss/ui/game/group_jodi.dart';
// import 'package:dmboss/ui/game/half_sangam.dart';
// import 'package:dmboss/ui/game/jodi.dart';
// import 'package:dmboss/ui/game/panel_group.dart';
// import 'package:dmboss/ui/game/single_ank.dart';
// import 'package:dmboss/ui/game/single_patti.dart';
// import 'package:dmboss/ui/game/tripple_patti.dart';
// import 'package:dmboss/util/get_current_time.dart';
// import 'package:dmboss/widgets/game_list_card.dart';
// import 'package:flutter/material.dart';

// class GameListScreen extends StatelessWidget {
//   final String title, openTime, closeTime;
//   const GameListScreen({
//     super.key,
//     required this.title,
//     required this.openTime,
//     required this.closeTime,
//   });

//   // Function to check if current time is before open time
//   bool _isBeforeOpenTime() {
//     final currentTime = getCurrentTimeFormatted();
//     return _compareTimes(currentTime, openTime) > 0;
//   }

//   // Helper function to compare two time strings
//   int _compareTimes(String time1, String time2) {
//     try {
//       final dateTime1 = _parseTimeString(time1);
//       final dateTime2 = _parseTimeString(time2);
//       return dateTime1.compareTo(dateTime2);
//     } catch (e) {
//       // If parsing fails, fallback to showing all games
//       return 0; // Treat as equal, will show all games
//     }
//   }

//   // Helper function to parse time string in various formats
//   DateTime _parseTimeString(String timeString) {
//     final now = DateTime.now();

//     // Clean the time string - replace dots with colons if needed
//     String cleanedTime = timeString.replaceAll('.', ':');

//     // Check if it's in 24-hour format (e.g., "16:43")
//     if (cleanedTime.contains(RegExp(r'^\d{1,2}:\d{2}$'))) {
//       final parts = cleanedTime.split(':');
//       final hour = int.parse(parts[0]);
//       final minute = int.parse(parts[1]);
//       return DateTime(now.year, now.month, now.day, hour, minute);
//     }

//     // Check if it's in 12-hour format with AM/PM (e.g., "4:43 pm")
//     if (cleanedTime.contains(RegExp(r'^\d{1,2}:\d{2}\s*[ap]m$', caseSensitive: false))) {
//       final parts = cleanedTime.split(' ');
//       final timeParts = parts[0].split(':');

//       int hour = int.parse(timeParts[0]);
//       final minute = int.parse(timeParts[1]);
//       final period = parts.length > 1 ? parts[1].toLowerCase() : '';

//       // Convert to 24-hour format
//       if (period == 'pm' && hour != 12) {
//         hour += 12;
//       } else if (period == 'am' && hour == 12) {
//         hour = 0;
//       }

//       return DateTime(now.year, now.month, now.day, hour, minute);
//     }

//     // If format is not recognized, return current time (fallback)
//     return now;
//   }

//   // Filter games based on time condition
//   List<Map<String, dynamic>> _getFilteredGames() {
//     try {
//       if (_isBeforeOpenTime()) {
//         // Before open time - show only limited games
//         final limitedGames = [
//           'Single Ank',
//           'Single Patti',
//           'Double Patti',
//           'Tripple Patti',
//           'Panel Group',
//           'Bulk SP',
//           'Bulk DP'
//         ];

//         return gameList.where((game) => limitedGames.contains(game['title'])).toList();
//       } else {
//         // After open time - show all games
//         return gameList;
//       }
//     } catch (e) {
//       // If any error occurs in time comparison, show all games as fallback
//       return gameList;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredGames = _getFilteredGames();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text(
//           title,
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//         ),
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 10),
//             child: Center(
//               child: Text(
//                 "$openTime - $closeTime ",
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//               ),
//             ),
//           ),
//         ],
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3, // 3 items in a row
//             crossAxisSpacing: 15,
//             mainAxisSpacing: 15,
//             childAspectRatio: 0.9,
//           ),
//           itemCount: filteredGames.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 if (filteredGames[index]['id'] == 7) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => FullSangam(
//                         title: filteredGames[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (filteredGames[index]['id'] == 12) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           BulkDp(title: filteredGames[index]['title']),
//                     ),
//                   );
//                 } else if (filteredGames[index]['id'] == 1) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SingleAnk(
//                         title: filteredGames[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (filteredGames[index]['id'] == 2) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Jodi(
//                         title: filteredGames[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (filteredGames[index]['id'] == 3) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SinglePatti(
//                         title: filteredGames[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (filteredGames[index]['id'] == 4) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DoublePatti(
//                         title: filteredGames[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (filteredGames[index]['id'] == 5) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TripplePatti(
//                         title: filteredGames[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (filteredGames[index]['id'] == 8) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => GroupJodi(
//                         title: filteredGames[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (filteredGames[index]['id'] == 9) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PanelGroup(
//                         title: filteredGames[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (filteredGames[index]['id'] == 6) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => HalfSangam(
//                         title: filteredGames[index]['title'],
//                         gameName: title,
//                       ),
//                     ),
//                   );
//                 } else if (filteredGames[index]['id'] == 10) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           BulkJodi(title: filteredGames[index]['title']),
//                     ),
//                   );
//                 } else if (filteredGames[index]['id'] == 11) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           BulkSp(title: filteredGames[index]['title']),
//                     ),
//                   );
//                 }
//               },
//               child: GameListCard(
//                 title: filteredGames[index]["title"],
//                 icon: filteredGames[index]["icon"],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
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
import 'package:dmboss/widgets/game_list_card.dart';
import 'package:flutter/material.dart';

class GameListScreen extends StatelessWidget {
  final String title, openTime, closeTime, marketId;
  const GameListScreen({
    super.key,
    required this.title,
    required this.openTime,
    required this.closeTime,
    required this.marketId,
  });

  // // Function to check if current time is before open time
  // bool _isBeforeOpenTime() {
  //   final currentTime = getCurrentTimeFormatted();
  //   return _compareTimes(currentTime, openTime) > 0;
  // }

  // // Helper function to compare two time strings
  // int _compareTimes(String time1, String time2) {
  //   try {
  //     final dateTime1 = _parseTimeString(time1);
  //     final dateTime2 = _parseTimeString(time2);
  //     return dateTime1.compareTo(dateTime2);
  //   } catch (e) {
  //     // If parsing fails, fallback to showing all games
  //     return 0; // Treat as equal, will show all games
  //   }
  // }

  // // Helper function to parse time string in various formats
  // DateTime _parseTimeString(String timeString) {
  //   final now = DateTime.now();

  //   // Clean the time string - replace dots with colons if needed
  //   String cleanedTime = timeString.replaceAll('.', ':');

  //   // Check if it's in 24-hour format (e.g., "16:43")
  //   if (cleanedTime.contains(RegExp(r'^\d{1,2}:\d{2}$'))) {
  //     final parts = cleanedTime.split(':');
  //     final hour = int.parse(parts[0]);
  //     final minute = int.parse(parts[1]);
  //     return DateTime(now.year, now.month, now.day, hour, minute);
  //   }

  //   // Check if it's in 12-hour format with AM/PM (e.g., "4:43 pm")
  //   if (cleanedTime.contains(RegExp(r'^\d{1,2}:\d{2}\s*[ap]m$', caseSensitive: false))) {
  //     final parts = cleanedTime.split(' ');
  //     final timeParts = parts[0].split(':');

  //     int hour = int.parse(timeParts[0]);
  //     final minute = int.parse(timeParts[1]);
  //     final period = parts.length > 1 ? parts[1].toLowerCase() : '';

  //     // Convert to 24-hour format
  //     if (period == 'pm' && hour != 12) {
  //       hour += 12;
  //     } else if (period == 'am' && hour == 12) {
  //       hour = 0;
  //     }

  //     return DateTime(now.year, now.month, now.day, hour, minute);
  //   }

  //   // If format is not recognized, return current time (fallback)
  //   return now;
  // }

  // Function to check if current time is before open time
  bool _isBeforeOpenTime() {
    final currentTime = getCurrentTimeFormatted();
    return _compareTimes(currentTime, openTime) < 0; // Changed to < 0
  }

  // Helper function to compare two time strings
  int _compareTimes(String time1, String time2) {
    try {
      final dateTime1 = _parseTimeString(time1);
      final dateTime2 = _parseTimeString(time2);
      return dateTime1.compareTo(dateTime2);
    } catch (e) {
      // If parsing fails, fallback to showing all games
      return 0; // Treat as equal, will show all games
    }
  }

  // Helper function to parse time string in 24-hour format
  DateTime _parseTimeString(String timeString) {
    final now = DateTime.now();

    // Clean the time string - remove any spaces and ensure proper format
    String cleanedTime = timeString
        .trim()
        .replaceAll(' ', '')
        .replaceAll('.', ':');

    // Handle 24-hour format (e.g., "10:00", "22:00", "21:00")
    if (cleanedTime.contains(RegExp(r'^\d{1,2}:\d{2}$'))) {
      final parts = cleanedTime.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      // Validate hour and minute ranges
      if (hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59) {
        return DateTime(now.year, now.month, now.day, hour, minute);
      }
    }

    // If format is not recognized or invalid, return current time (fallback)
    return now;
  }

  // Function to check if current time is after close time
  bool _isAfterCloseTime() {
    final currentTime = getCurrentTimeFormatted();
    return _compareTimes(currentTime, closeTime) > 0;
  }

  // Function to check if venue is currently open
  bool isVenueOpen() {
    return !_isBeforeOpenTime() && !_isAfterCloseTime();
  }

  // Filter games based on time condition
  List<Map<String, dynamic>> _getFilteredGames() {
    try {
      if (_isBeforeOpenTime()) {
        // Before open time - show only limited games
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
        // After open time - show all games
        return gameList;
      }
    } catch (e) {
      // If any error occurs in time comparison, show all games as fallback
      return gameList;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredGames = _getFilteredGames();

    // You can now use marketId for API calls or other operations
    print("Market ID in GameListScreen: $marketId");

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
                "$openTime - $closeTime ",
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
            crossAxisCount: 3, // 3 items in a row
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.9,
          ),
          itemCount: filteredGames.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Pass the marketId to all game screens
                if (filteredGames[index]['id'] == 7) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullSangam(
                        title: filteredGames[index]['title'],
                        gameName: title,
                        //  marketId: marketId, // Pass marketId
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 12) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BulkDp(
                        title: filteredGames[index]['title'],
                        //  marketId: marketId, // Pass marketId
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
                        marketId: marketId, // Pass marketId
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
                        marketId: marketId, // Pass marketId
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
                        marketId: marketId, // Pass marketId
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
                        marketId: marketId, // Pass marketId
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
                        marketId: marketId, // Pass marketId
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
                        marketId: marketId, // Pass marketId
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
                        marketId: marketId, // Pass marketId
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
                        marketId: marketId, // Pass marketId
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 10) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BulkJodi(
                        title: filteredGames[index]['title'],
                        //   marketId: marketId, // Pass marketId
                      ),
                    ),
                  );
                } else if (filteredGames[index]['id'] == 11) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BulkSp(
                        title: filteredGames[index]['title'],
                        // marketId: marketId, // Pass marketId
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
