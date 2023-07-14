import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_profile/presentation/widgets/triangle_widget.dart';
import 'package:msgmee/helper/navigator_function.dart';

import '../../../../theme/colors.dart';
import 'broadcast_list.dart';

class BroadCastsWidget extends StatefulWidget {
  const BroadCastsWidget({super.key});

  @override
  State<BroadCastsWidget> createState() => _BroadCastsWidgetState();
}

class _BroadCastsWidgetState extends State<BroadCastsWidget> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  color: AppColors.grey.withOpacity(.4),
                  height: 0,
                  thickness: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'My Broadcasts (3)',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            show = !show;
                          });
                        },
                        child: Icon(Icons.error_outline,
                            size: 18.sp, color: AppColors.grey)),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        animatedScreenNavigator(context, BroadCastList());
                      },
                      child: Text('See More',
                          style: TextStyle(fontSize: 16, color: Colors.blue)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      splashColor: AppColors.seconderyColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                    onTap: () {},
                                    child: SvgPicture.asset(
                                        'assets/broadcast.svg')),
                                SizedBox(width: 10.w),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        index == 1
                                            ? "Eid Broadcast"
                                            : index == 2
                                                ? 'Diwali Broadcast'
                                                : 'Christmas Broadcast',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: 8),
                                    Text(
                                        'Alam, Saurabh, Taha Jamal, Anshuman...',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.grey)),
                                  ],
                                ),
                                Spacer(),
                                Text('2w ago',
                                    style: TextStyle(
                                        fontSize: 13, color: AppColors.grey)),
                              ],
                            ),
                            index == 2
                                ? Container()
                                : Divider(
                                    color: AppColors.lightgrey.withOpacity(.6),
                                    thickness: 1)
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
          show
              ? Positioned(
                  left: constraint.maxWidth * .27,
                  top: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 117, 117, 117),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'All your’s created broadcast were listed here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: Transform.rotate(
                            angle: pi, child: const Triangle()),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      );
    });
  }
}
