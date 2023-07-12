import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_profile/presentation/widgets/triangle_widget.dart';
import 'package:msgmee/helper/navigator_function.dart';

import '../../../../theme/colors.dart';
import 'group_list.dart';

class GroupsWidget extends StatefulWidget {
  const GroupsWidget({super.key});

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
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
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      'My Groups (3)',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),
                    ),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      child: Icon(
                        Icons.error_outline,
                        size: 18.sp,
                        color: AppColors.grey,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        animatedScreenNavigator(context, GroupList());
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                                onTap: () {},
                                child: SvgPicture.asset('assets/group.svg')),
                            SizedBox(width: 13.w),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    index == 1
                                        ? "Family Group"
                                        : index == 2
                                            ? 'Office Group'
                                            : 'College Group',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(height: 8),
                                Text('Members:33',
                                    style: TextStyle(
                                        fontSize: 13, color: AppColors.black)),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Admin',
                                    style: TextStyle(
                                        fontSize: 13, color: AppColors.black)),
                                Text('Since : 27 Dec, 2023',
                                    style: TextStyle(
                                        fontSize: 13, color: AppColors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
          show
              ? Positioned(
                  left: constraint.maxWidth * .32,
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
                          'All groups in which you have added are listed here',
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
                        padding: const EdgeInsets.only(left: 20),
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
