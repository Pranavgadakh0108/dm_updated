// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';

class BlinkingTextContainer extends StatefulWidget {
  const BlinkingTextContainer({super.key});

  @override
  _BlinkingTextContainerState createState() => _BlinkingTextContainerState();
}

class _BlinkingTextContainerState extends State<BlinkingTextContainer> {
  bool _visible = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _visible = !_visible;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: const Text(
          "100% Trusted Application",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
