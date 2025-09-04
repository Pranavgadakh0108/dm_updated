// import 'package:dio/dio.dart';
// import 'package:dmboss/data/appdata.dart';
// import 'package:dmboss/model/notification_model.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class GetNotificationsService {
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

//   Future<NotificationModel?> getNotifications([BuildContext? context]) async {
//     try {
//       final dio = await _getDioInstance();
//       final result = await dio.get("/users/notifications");

//       if (result.statusCode == 200) {
//         return NotificationModel.fromJson(result.data);
//       } else {
//         if (context != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Failed to Fetch Notifications")),
//           );
//         }
//       }
//     } catch (e) {
//       String errorMessage = "Something went wrong";

//       if (e is DioException) {
//         if (e.response != null && e.response?.data != null) {
//           errorMessage = e.response?.data['msg'] ?? errorMessage;
//         } else {
//           errorMessage = e.message ?? "";
//         }
//       } else {
//         errorMessage = e.toString();
//       }

//       if (context != null) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("Error: $errorMessage")));
//       }

//       return null;
//     }
//     return null;
//   }
// }
