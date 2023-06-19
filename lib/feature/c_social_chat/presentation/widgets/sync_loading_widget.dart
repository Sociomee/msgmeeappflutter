import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/sync_msg/sync_msg_cubit.dart';
import 'package:msgmee/theme/colors.dart';

class SyncLoadingWidget extends StatefulWidget {
  const SyncLoadingWidget({super.key});

  @override
  State<SyncLoadingWidget> createState() => _SyncLoadingWidgetState();
}

class _SyncLoadingWidgetState extends State<SyncLoadingWidget> {
  double height = 60.h;
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  height: 3,
                  duration: Duration(seconds: 2),
                  decoration: BoxDecoration(color: AppColors.primaryColor),
                  width: context.read<SyncMsgCubit>().state ? 300 : 0,
                ),
                Text(
                  '200/500',
                  style: TextStyle(color: AppColors.primaryColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
