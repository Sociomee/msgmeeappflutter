import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:msgmee/helper/navigator_function.dart';

import '../../../../theme/colors.dart';
import 'broadcast_list.dart';

class BroadCastsWidget extends StatefulWidget {
  const BroadCastsWidget({super.key});

  @override
  State<BroadCastsWidget> createState() => _BroadCastsWidgetState();
}

class _BroadCastsWidgetState extends State<BroadCastsWidget> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

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
                      thickness: 6)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'My Broadcasts (3)',
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                        onTap: () {
                          Widget toast = Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: AppColors.iconColor),
                            child: Text(
                              "All your's created broadcast were listed here.",
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
                        animatedScreenNavigator(context, BroadCastList());
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 7),
                            child: Column(children: [
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                        onTap: () {},
                                        child: SvgPicture.asset(
                                            'assets/broadcast.svg',
                                            height: 45.h,
                                            fit: BoxFit.cover)),
                                    SizedBox(width: 10.w),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 195.w,
                                                child: Text(
                                                    index == 1
                                                        ? "Eid Broadcast"
                                                        : index == 2
                                                            ? 'Diwali Broadcast'
                                                            : 'Christmas Broadcast',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                              SizedBox(height: 8),
                                              SizedBox(
                                                  child: Text(
                                                      'Alam, Saurabh, Taha Jamal, Anshuman...',
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          color:
                                                              AppColors.grey)))
                                            ])),
                                    Spacer(),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('2w ago',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: AppColors.grey)))
                                  ]),
                              index == 2
                                  ? Container()
                                  : Divider(
                                      color:
                                          AppColors.lightgrey.withOpacity(.6),
                                      thickness: 1)
                            ])));
                  })
            ],
          ),
          // Positioned(
          //   left: constraint.maxWidth * .27,
          //   top: 8,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       show
          //           ? Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 Container(
          //                     padding: EdgeInsets.symmetric(
          //                         horizontal: 10, vertical: 7),
          //                     decoration: BoxDecoration(
          //                         color: Color.fromARGB(255, 117, 117, 117),
          //                         borderRadius: BorderRadius.circular(20)),
          //                     child: Text(
          //                         'All your’s created broadcast were listed here.',
          //                         textAlign: TextAlign.center,
          //                         style: TextStyle(
          //                             color: Colors.white,
          //                             fontSize: 10,
          //                             fontFamily: 'Poppins',
          //                             fontWeight: FontWeight.w400))),
          //                 Padding(
          //                     padding: const EdgeInsets.only(left: 70),
          //                     child: Transform.rotate(
          //                         angle: pi, child: const Triangle())),
          //               ],
          //             )
          //           : Container(),
          //     ],
          //   ),
          // ),
        ],
      );
    });
  }
}
