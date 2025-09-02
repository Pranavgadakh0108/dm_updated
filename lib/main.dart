import 'package:dmboss/app/myapp.dart';
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
import 'package:dmboss/provider/get_qr_code_provider.dart';
import 'package:dmboss/provider/how_to_play_provider.dart';
import 'package:dmboss/provider/login_user_provider.dart';
import 'package:dmboss/provider/mobile_exist_provider.dart';
import 'package:dmboss/provider/pending_withdraw_count.dart';
import 'package:dmboss/provider/register_user_provider.dart';
import 'package:dmboss/provider/transaction_history_provider.dart';
import 'package:dmboss/provider/update_user_provider.dart';
import 'package:dmboss/provider/user_profile_provider.dart';
import 'package:dmboss/provider/winning_history_provider.dart';
import 'package:dmboss/provider/withdraw_coins_provider.dart';
import 'package:dmboss/provider/withdraw_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MobileCheckProvider()),
        ChangeNotifierProvider(create: (_) => RegisterUserProvider()),
        ChangeNotifierProvider(create: (_) => LoginUserProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => GameRateProvider()),
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
        ChangeNotifierProvider(create: (_) => GameMarketProvider()),
        ChangeNotifierProvider(create: (_) => SingleAnkBetProvider()),
        ChangeNotifierProvider(create: (_) => SinglePattiProvider()),
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
      ],
      child: const MyApp(),
    ),
  );
}
