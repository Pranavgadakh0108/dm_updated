// // ignore_for_file: use_build_context_synchronously

// import 'package:dio/dio.dart';
// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/model/games_model.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class GameMarketService {
//   Future<Dio> _getDioInstance() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     final token = sharedPreferences.getString('auth_token');

//     return Dio(
//       BaseOptions(
//         baseUrl: baseUrl,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       ),
//     );
//   }

//   Future<GetMarketModel?> getMarketService(BuildContext context) async {
//     try {
//       final dio = await _getDioInstance();

//       final result = await dio.get("/markets/list");

//       if (result.statusCode == 200) {
//         return GetMarketModel.fromJson(result.data);
//       } else {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("Failed to Fetch Markets")));
//       }
//     } catch (e) {
//       String errorMessage = "Something went wrong";

//       if (e is DioException) {
//         if (e.response != null && e.response?.data != null) {
//           errorMessage = e.response?.data['message'] ?? errorMessage;
//         } else {
//           errorMessage = e.message ?? "";
//         }
//       } else {
//         errorMessage = e.toString();
//       }

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Error: $errorMessage")));

//       return null;
//     }
//     return null;
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:dmboss/data/appdata.dart';
import 'package:dmboss/model/games_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameMarketService {
  Future<Dio> _getDioInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('auth_token');

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<List<GamesModel>?> getGamesService(BuildContext context) async {
    try {
      final dio = await _getDioInstance();

      final result = await dio.get("/games/games"); // Adjust endpoint as needed

      if (result.statusCode == 200) {
        // Parse the response as a list of GamesModel
        List<dynamic> data = result.data;
        return data.map((json) => GamesModel.fromJson(json)).toList();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to Fetch Games")));
      }
    } catch (e) {
      String errorMessage = "Something went wrong";

      if (e is DioException) {
        if (e.response != null && e.response?.data != null) {
          errorMessage = e.response?.data['message'] ?? errorMessage;
        } else {
          errorMessage = e.message ?? "";
        }
      } else {
        errorMessage = e.toString();
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $errorMessage")));

      return null;
    }
    return null;
  }
}