import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/theme/colors.dart';

import 'delete_dialog.dart';

class BroadCastList extends StatefulWidget {
  const BroadCastList({super.key});

  @override
  State<BroadCastList> createState() => _BroadCastListState();
}

class _BroadCastListState extends State<BroadCastList> {
  List<int> selectedindex = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            ),
          ),
        ),
        leadingWidth: 40.w,
        titleSpacing: 10.w,
        title: selectedindex.isNotEmpty
            ? Text(
                '${selectedindex.length} Selected',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              )
            : Text(
                'My Broadcasts',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
        actions: [
          selectedindex.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteDialogWidget();
                        });
                  },
                  child: Icon(Icons.delete, color: AppColors.black, size: 24.h))
              : Container(),
          PopupMenuButton<int>(
              icon: Icon(Icons.more_vert, color: Colors.black, size: 24.h),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      selectedindex.length != 9 ? 'Select all' : 'Deselect all',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ];
              },
              offset: Offset(0, 100),
              color: Colors.white,
              elevation: 2,
              onSelected: (value) {
                if (selectedindex.length != 9) {
                  setState(() {
                    selectedindex.clear();
                  });
                  selectedindex.addAll([0, 1, 2, 3, 4, 5, 6, 7, 8]);
                } else {
                  setState(() {
                    selectedindex.clear();
                  });
                }
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (selectedindex.contains(index)) {
                        setState(() {
                          selectedindex.remove(index);
                        });
                      }
                    },
                    onLongPress: () {
                      if (selectedindex.length < 9 &&
                          !selectedindex.contains(index)) {
                        setState(() {
                          selectedindex.add(index);
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: selectedindex.contains(index)
                          ? AppColors.primaryColor.withOpacity(.1)
                          : selectedindex.contains(index)
                              ? AppColors.primaryColor.withOpacity(.1)
                              : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            selectedindex.contains(index)
                                ? Container(
                                    height: 60.w,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppColors.black),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.check,
                                        color: AppColors.white, size: 30))
                                : SvgPicture.asset(
                                    'assets/broadcast.svg',
                                    width: 60.w,
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      index == 1
                                          ? "Eid Broadcast"
                                          : index == 2
                                              ? 'Diwali Broadcast'
                                              : 'Christmas Broadcast',
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(height: 8),
                                  Text('Alam, Saurabh, Taha Jamal, Anshuman...',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.grey)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text('2w ago',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12.sp,
                                    fontFamily: 'Niramit',
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
