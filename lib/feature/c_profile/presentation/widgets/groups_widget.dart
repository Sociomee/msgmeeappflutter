import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:msgmee/helper/navigator_function.dart';

import '../../../../theme/colors.dart';
import 'group_list.dart';

class GroupsWidget extends StatefulWidget {
  const GroupsWidget({super.key});

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  // bool show = false;
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
                    thickness: 6),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      'My Groups (3)',
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),
                    ),
                    GestureDetector(
                        onTap: () {
                          Widget toast = Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: AppColors.iconColor),
                            child: Text(
                              'All groups in which you have added are listed here',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                          fToast.showToast(
                              child: toast,
                              gravity: ToastGravity.BOTTOM,
                              toastDuration: Duration(seconds: 2));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(Icons.error_outline,
                              size: 18.sp, color: AppColors.grey),
                        )),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        animatedScreenNavigator(context, GroupList());
                      },
                      child: Text('See More',
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.blue)),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 12.w, vertical: 7),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                    onTap: () {},
                                    child: index == 1
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.network(
                                                'https://media.istockphoto.com/id/1082467846/photo/smiling-parents-with-two-children.jpg?s=612x612&w=0&k=20&c=U73LbULmJ7Gqt6jPtuZRL_--xw4lWSh24GIqCDSTkGI=',
                                                height: 42.h,
                                                width: 42.h,
                                                fit: BoxFit.cover),
                                          )
                                        : index == 2
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.network(
                                                    'https://images.unsplash.com/photo-1568992687947-868a62a9f521?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8b2ZmaWNlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
                                                    height: 42.h,
                                                    width: 42.h,
                                                    fit: BoxFit.cover),
                                              )
                                            : SvgPicture.asset(
                                                'assets/group.svg',
                                                height: 42.h,
                                                fit: BoxFit.cover)),
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
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: 8),
                                    Text('Members:33',
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: AppColors.black)),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Admin',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.black)),
                                    Text('Since : 27 Dec, 2023',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.grey)),
                                  ],
                                ),
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
          // show
          //     ? Positioned(
          //         left: constraint.maxWidth * .32,
          //         top: 8,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             Container(
          //               padding:
          //                   EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          //               decoration: BoxDecoration(
          //                   color: Color.fromARGB(255, 117, 117, 117),
          //                   borderRadius: BorderRadius.circular(20)),
          //               child: Text(
          //                 'All groups in which you have added are listed here',
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 10,
          //                   fontFamily: 'Poppins',
          //                   fontWeight: FontWeight.w400,
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(left: 20),
          //               child: Transform.rotate(
          //                   angle: pi, child: const Triangle()),
          //             ),
          //           ],
          //         ),
          //       )
          //     : Container(),
          // Positioned(
          //   left: constraint.maxWidth * .4,
          //   top: 40,
          //   child: GestureDetector(
          //       onTap: () {
          //         setState(() {
          //           show = !show;
          //         });
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.only(left: 4),
          //         child: Icon(Icons.error_outline,
          //             size: 18.sp, color: AppColors.grey),
          //       )),
          // ),
        ],
      );
    });
  }
}
