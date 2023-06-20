import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:msgmee/theme/colors.dart';

class SyncLoadingWidget extends StatefulWidget {
  const SyncLoadingWidget({super.key});

  @override
  State<SyncLoadingWidget> createState() => _SyncLoadingWidgetState();
}

class _SyncLoadingWidgetState extends State<SyncLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _linearAnimation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double height = 60.h;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _linearAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    Timer(Duration(seconds: 5), () {
      setState(() {
        height = 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.seconderyColor1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 3,
                  ),
                ),
                SizedBox(width: 10),
                Text('Connection syncing is in process'),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        height = 0;
                      });
                    },
                    child: Icon(Icons.close))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AnimatedBuilder(
                animation: _linearAnimation,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 300,
                        child: LinearProgressIndicator(
                            backgroundColor: AppColors.grey,
                            value: _linearAnimation.value,
                            color: AppColors.primaryColor),
                      ),
                      Text(
                        '${(_linearAnimation.value * 100).toStringAsFixed(0)}/100',
                        style: TextStyle(color: AppColors.primaryColor),
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
