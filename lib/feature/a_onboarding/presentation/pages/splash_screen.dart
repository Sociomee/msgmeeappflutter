import 'dart:async';

import 'package:flutter/material.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationcontroller;
  late Animation<double> _animation;

  @override
  void initState() {
    startTimer(context);
    _animationcontroller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationcontroller);
    _animationcontroller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationcontroller,
        builder: (context, child) {
          return Scaffold(
            body: Center(
              child: FadeTransition(
                opacity: _animation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/msgmee_logo.png',
                        height: 114, width: 114)
                  ],
                ),
              ),
            ),
          );
        });
  }
}

void startTimer(BuildContext context) {
  Timer(const Duration(seconds: 3), () async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const OnboardingScreen();
    }));
    //It will redirect  after 3 seconds
  });
}
