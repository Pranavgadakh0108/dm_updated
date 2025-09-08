// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class BlinkingTextContainer extends StatefulWidget {
  const BlinkingTextContainer({super.key});

  @override
  _BlinkingTextContainerState createState() => _BlinkingTextContainerState();
}

class _BlinkingTextContainerState extends State<BlinkingTextContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                -MediaQuery.of(context).size.width +
                    (_animation.value *
                        (MediaQuery.of(context).size.width + 400)),

                0,
              ),
              child: const Text(
                "100% Trusted Application",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red,
                ),
                overflow: TextOverflow.visible,
                softWrap: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
