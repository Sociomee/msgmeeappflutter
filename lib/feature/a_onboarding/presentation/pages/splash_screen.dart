import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/msgmee_screen.dart';

import '../../../../helper/local_data.dart';
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
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/splash.png'))),
              child: Center(
                child: FadeTransition(
                  opacity: _animation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/msgmee_logo.png',
                          height: 167.h, width: 175.w),
                      SizedBox(height: 24.h),
                      Text(
                        'MsgMee',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF083A3D),
                          fontSize: 44.87,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

void startTimer(BuildContext context) {
  Timer(const Duration(seconds: 3), () async {
    var token = await Localdata().readData('token');

    if (token != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MsgmeeScreen();
      }));
    } else if (token == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const OnboardingScreen();
      }));
    }
    //It will redirect  after 3 seconds
  });
}