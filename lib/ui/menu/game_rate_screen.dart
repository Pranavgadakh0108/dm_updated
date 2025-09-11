// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dmboss/provider/game_rate_provider.dart';

class GameRateScreen extends StatefulWidget {
  const GameRateScreen({super.key});

  @override
  State<GameRateScreen> createState() => _GameRateScreenState();
}

class _GameRateScreenState extends State<GameRateScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() {
        final gameRateProvider = Provider.of<GetGameRatesProvider>(
          context,
          listen: false,
        );

        gameRateProvider.getGameRates(context);
      });
    });
  }

  String _formatRateValue(String rateValue) {
    return rateValue.replaceAll('/', ' Ka ');
  }

  String _formatGameTitle(String key) {
    return key
        .split('_')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 3,
        title: const Text(
          "Game Rate",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<GetGameRatesProvider>(
        builder: (context, gameRateProvider, child) {
          if (gameRateProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (gameRateProvider.gameRatesModel?.list.isEmpty ?? true) {
            return Center(
              child: Text(
                'No Game Rate Available',
                style: TextStyle(color: Colors.grey[600]),
              ),
            );
          }

          if (gameRateProvider.errorMessage != null) {
            return Center(
              child: Text(
                'Error: ${gameRateProvider.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.width * 0.075,
              right: MediaQuery.of(context).size.width * 0.075,
              bottom: MediaQuery.of(context).size.height * 0.075,
            ),
            itemCount: gameRateProvider.gameRatesModel?.list.length,
            itemBuilder: (context, index) {
              final entry = gameRateProvider.gameRatesModel?.list[index];
              final gameTitle = _formatGameTitle(entry?.key ?? "");
              final formattedRate = _formatRateValue(
                entry?.value.toString() ?? "0",
              );

              return Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      '$gameTitle - $formattedRate',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
