// // ignore_for_file: deprecated_member_use

// import 'package:dmboss/app/myapp.dart';
// import 'package:dmboss/firebase_options.dart';
// import 'package:dmboss/provider/add_bank_details_provider.dart';
// import 'package:dmboss/provider/add_deposite_manual_provider.dart';
// import 'package:dmboss/provider/game_market_provider.dart';
// import 'package:dmboss/provider/game_rate_provider.dart';
// import 'package:dmboss/provider/games_provider/bulk_dp_provider.dart';
// import 'package:dmboss/provider/games_provider/bulk_jodi_provider.dart';
// import 'package:dmboss/provider/games_provider/bulk_sp_provider.dart';
// import 'package:dmboss/provider/games_provider/single_ank_provider.dart';
// import 'package:dmboss/provider/games_provider/single_patti_provider.dart';
// import 'package:dmboss/provider/games_settings_provider.dart';
// import 'package:dmboss/provider/get_bank_details_provider.dart';
// import 'package:dmboss/provider/get_bet_history_provider.dart';
// import 'package:dmboss/provider/get_daily_result_provider.dart';
// import 'package:dmboss/provider/get_fund_history_provider.dart';
// import 'package:dmboss/provider/get_games_chart_provider.dart';
// import 'package:dmboss/provider/get_image_sliders.dart';
// import 'package:dmboss/provider/get_notifications_provider.dart';
// import 'package:dmboss/provider/get_payment_mode_provider.dart';
// import 'package:dmboss/provider/get_pending_request_count.dart';
// import 'package:dmboss/provider/get_qr_code_provider.dart';
// import 'package:dmboss/provider/how_to_play_provider.dart';
// import 'package:dmboss/provider/login_user_provider.dart';
// import 'package:dmboss/provider/mobile_exist_provider.dart';
// import 'package:dmboss/provider/notification_admin_provider.dart';
// import 'package:dmboss/provider/payment_gateway_provider.dart';
// import 'package:dmboss/provider/payment_provider.dart';
// import 'package:dmboss/provider/payment_status_provider.dart';
// import 'package:dmboss/provider/pending_withdraw_count.dart';
// import 'package:dmboss/provider/register_user_provider.dart';
// import 'package:dmboss/provider/transaction_history_provider.dart';
// import 'package:dmboss/provider/update_user_provider.dart';
// import 'package:dmboss/provider/user_profile_provider.dart';
// import 'package:dmboss/provider/winning_history_provider.dart';
// import 'package:dmboss/provider/withdraw_coins_provider.dart';
// import 'package:dmboss/provider/withdraw_history_provider.dart';
// import 'package:dmboss/service/firebase_notification_service.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   // WidgetsFlutterBinding.ensureInitialized();

//   // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   // await SystemChrome.setPreferredOrientations([
//   //   DeviceOrientation.portraitUp,
//   //   DeviceOrientation.portraitDown,
//   // ]);

//   // // Initialize Workmanager with the callback dispatcher from NotificationPollingService
//   // Workmanager().initialize(
//   //   NotificationPollingService.callbackDispatcher,
//   //   isInDebugMode: true,
//   // );

//   // // Initialize notifications
//   // await NotificationService.initialize();
//   // await NotificationPollingService.initialize();

//   WidgetsFlutterBinding.ensureInitialized();

//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   // Initialize Firebase
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   // Initialize Firebase Notifications (REPLACES WorkManager)
//   await FirebaseNotificationService.initialize();
//   // FirebaseMessaging.onBackgroundMessage();

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => MobileCheckProvider()),
//         ChangeNotifierProvider(create: (_) => RegisterUserProvider()),
//         ChangeNotifierProvider(create: (_) => LoginUserProvider()),
//         ChangeNotifierProvider(create: (_) => UserProfileProvider()),
//         ChangeNotifierProvider(create: (_) => GetGameRatesProvider()),
//         ChangeNotifierProvider(create: (_) => ProfileUpdateProvider()),
//         ChangeNotifierProvider(create: (_) => GameMarketProvider()),
//         ChangeNotifierProvider(create: (_) => HowToPlayProvider()),
//         ChangeNotifierProvider(create: (_) => SingleAnkBetProvider()),
//         ChangeNotifierProvider(create: (_) => SinglePattiProvider()),
//         ChangeNotifierProvider(create: (_) => AddBankDetailsProvider()),
//         ChangeNotifierProvider(create: (_) => GetBankDetailsProvider()),
//         ChangeNotifierProvider(
//           create: (_) => AddDepositePointsManualProvider(),
//         ),
//         ChangeNotifierProvider(create: (_) => GetFundHistoryProvider()),
//         ChangeNotifierProvider(create: (_) => WithdrawCoinsProvider()),
//         ChangeNotifierProvider(create: (_) => GetBetHistoryProvider()),
//         ChangeNotifierProvider(create: (_) => GetQrCodeProvider()),
//         ChangeNotifierProvider(create: (_) => GetWithdrawHistoryProvider()),
//         ChangeNotifierProvider(create: (_) => GameMarketProvider()),
//         ChangeNotifierProvider(create: (_) => SingleAnkBetProvider()),
//         ChangeNotifierProvider(create: (_) => SinglePattiProvider()),
//         ChangeNotifierProvider(create: (_) => BulkJodiBetProvider()),
//         ChangeNotifierProvider(create: (_) => BulkSpBetProvider()),
//         ChangeNotifierProvider(create: (_) => BulkDpBetProvider()),
//         ChangeNotifierProvider(create: (_) => GetDailyResultProvider()),
//         ChangeNotifierProvider(
//           create: (_) => GetPendingWithdrawCountProvider(),
//         ),
//         ChangeNotifierProvider(create: (_) => GetTransactionHistoryProvider()),
//         ChangeNotifierProvider(create: (_) => GamesSettingsProvider()),
//         ChangeNotifierProvider(create: (_) => WinningHistoryProvider()),
//         ChangeNotifierProvider(create: (_) => PaymentGatewayProvider()),
//         ChangeNotifierProvider(
//           create: (_) => GetPendingDepositeCountProvider(),
//         ),
//         ChangeNotifierProvider(create: (_) => GetImageSlidersProvider()),
//         ChangeNotifierProvider(create: (_) => GetPaymentModeProvider()),
//         ChangeNotifierProvider(create: (_) => GetNotificationsProvider()),
//         ChangeNotifierProvider(create: (_) => GetGamesChartProvider()),
//         ChangeNotifierProvider(create: (_) => GetNotificationsAdminProvider()),
//         ChangeNotifierProvider(create: (_) => PaymentProvider()),
//         ChangeNotifierProvider(create: (_) => PaymentStatusProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

import 'package:dmboss/app/myapp.dart';
import 'package:dmboss/firebase_options.dart';
import 'package:dmboss/provider/add_bank_details_provider.dart';
import 'package:dmboss/provider/add_deposite_manual_provider.dart';
import 'package:dmboss/provider/game_market_provider.dart';
import 'package:dmboss/provider/game_rate_provider.dart';
import 'package:dmboss/provider/games_provider/bulk_dp_provider.dart';
import 'package:dmboss/provider/games_provider/bulk_jodi_provider.dart';
import 'package:dmboss/provider/games_provider/bulk_sp_provider.dart';
import 'package:dmboss/provider/games_provider/single_ank_provider.dart';
import 'package:dmboss/provider/games_provider/single_patti_provider.dart';
import 'package:dmboss/provider/games_settings_provider.dart';
import 'package:dmboss/provider/get_bank_details_provider.dart';
import 'package:dmboss/provider/get_bet_history_provider.dart';
import 'package:dmboss/provider/get_daily_result_provider.dart';
import 'package:dmboss/provider/get_fund_history_provider.dart';
import 'package:dmboss/provider/get_games_chart_provider.dart';
import 'package:dmboss/provider/get_image_sliders.dart';
import 'package:dmboss/provider/get_notifications_provider.dart';
import 'package:dmboss/provider/get_payment_mode_provider.dart';
import 'package:dmboss/provider/get_pending_request_count.dart';
import 'package:dmboss/provider/get_qr_code_provider.dart';
import 'package:dmboss/provider/how_to_play_provider.dart';
import 'package:dmboss/provider/login_user_provider.dart';
import 'package:dmboss/provider/mobile_exist_provider.dart';
import 'package:dmboss/provider/notification_admin_provider.dart';
import 'package:dmboss/provider/payment_gateway_provider.dart';
import 'package:dmboss/provider/payment_provider.dart';
import 'package:dmboss/provider/payment_status_provider.dart';
import 'package:dmboss/provider/pending_withdraw_count.dart';
import 'package:dmboss/provider/register_user_provider.dart';
import 'package:dmboss/provider/transaction_history_provider.dart';
import 'package:dmboss/provider/update_user_provider.dart';
import 'package:dmboss/provider/user_profile_provider.dart';
import 'package:dmboss/provider/winning_history_provider.dart';
import 'package:dmboss/provider/withdraw_coins_provider.dart';
import 'package:dmboss/provider/withdraw_history_provider.dart';
import 'package:dmboss/service/firebase_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// ✅ Background handler (runs when app is terminated or in background)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseNotificationService.showNotificationFromMessage(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ✅ Register background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ✅ Initialize Firebase Notifications
  await FirebaseNotificationService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MobileCheckProvider()),
        ChangeNotifierProvider(create: (_) => RegisterUserProvider()),
        ChangeNotifierProvider(create: (_) => LoginUserProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => GetGameRatesProvider()),
        ChangeNotifierProvider(create: (_) => ProfileUpdateProvider()),
        ChangeNotifierProvider(create: (_) => GameMarketProvider()),
        ChangeNotifierProvider(create: (_) => HowToPlayProvider()),
        ChangeNotifierProvider(create: (_) => SingleAnkBetProvider()),
        ChangeNotifierProvider(create: (_) => SinglePattiProvider()),
        ChangeNotifierProvider(create: (_) => AddBankDetailsProvider()),
        ChangeNotifierProvider(create: (_) => GetBankDetailsProvider()),
        ChangeNotifierProvider(
          create: (_) => AddDepositePointsManualProvider(),
        ),
        ChangeNotifierProvider(create: (_) => GetFundHistoryProvider()),
        ChangeNotifierProvider(create: (_) => WithdrawCoinsProvider()),
        ChangeNotifierProvider(create: (_) => GetBetHistoryProvider()),
        ChangeNotifierProvider(create: (_) => GetQrCodeProvider()),
        ChangeNotifierProvider(create: (_) => GetWithdrawHistoryProvider()),
        ChangeNotifierProvider(create: (_) => BulkJodiBetProvider()),
        ChangeNotifierProvider(create: (_) => BulkSpBetProvider()),
        ChangeNotifierProvider(create: (_) => BulkDpBetProvider()),
        ChangeNotifierProvider(create: (_) => GetDailyResultProvider()),
        ChangeNotifierProvider(
          create: (_) => GetPendingWithdrawCountProvider(),
        ),
        ChangeNotifierProvider(create: (_) => GetTransactionHistoryProvider()),
        ChangeNotifierProvider(create: (_) => GamesSettingsProvider()),
        ChangeNotifierProvider(create: (_) => WinningHistoryProvider()),
        ChangeNotifierProvider(create: (_) => PaymentGatewayProvider()),
        ChangeNotifierProvider(
          create: (_) => GetPendingDepositeCountProvider(),
        ),
        ChangeNotifierProvider(create: (_) => GetImageSlidersProvider()),
        ChangeNotifierProvider(create: (_) => GetPaymentModeProvider()),
        ChangeNotifierProvider(create: (_) => GetNotificationsProvider()),
        ChangeNotifierProvider(create: (_) => GetGamesChartProvider()),
        ChangeNotifierProvider(create: (_) => GetNotificationsAdminProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => PaymentStatusProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
