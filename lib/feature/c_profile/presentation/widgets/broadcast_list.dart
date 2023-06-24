import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/theme/colors.dart';

import 'delete_dialog.dart';

class BroadCastList extends StatefulWidget {
  const BroadCastList({super.key});

  @override
  State<BroadCastList> createState() => _BroadCastListState();
}

class _BroadCastListState extends State<BroadCastList> {
  bool selectall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
        ),
        title: selectall
            ? Text(
                '9 Selected',
                style: TextStyle(color: AppColors.black),
              )
            : Text(
                'My Broadcasts',
                style: TextStyle(color: AppColors.black),
              ),
        actions: [
          selectall
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteDialogWidget();
                        });
                  },
                  child: Icon(Icons.delete, color: AppColors.black))
              : Container(),
          PopupMenuButton<int>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      selectall ? "Deselect all" : 'Select all',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ];
              },
              offset: Offset(0, 100),
              color: Colors.white,
              elevation: 2,
              onSelected: (value) {
                setState(() {
                  selectall = !selectall;
                });
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
                  return InkWell(
                    onTap: () {},
                    splashColor: AppColors.seconderyColor,
                    child: Container(
                      color: selectall
                          ? AppColors.primaryColor.withOpacity(.1)
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {},
                                child: selectall
                                    ? Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: AppColors.black),
                                        alignment: Alignment.center,
                                        child: Icon(Icons.check,
                                            color: AppColors.white, size: 30))
                                    : SvgPicture.asset('assets/broadcast.svg')),
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(height: 8),
                                  Text('Alam, Saurabh, Taha Jamal, Anshuman...',
                                      style: TextStyle(
                                          fontSize: 13, color: AppColors.grey)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text('2w ago',
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.grey)),
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
