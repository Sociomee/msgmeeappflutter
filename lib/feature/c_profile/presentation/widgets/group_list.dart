import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/theme/colors.dart';

import 'delete_dialog.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  bool selectMode = false;
  List<int> selectedindex = [];
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
        title: selectedindex.isNotEmpty
            ? Text(
                '${selectedindex.length} Selected',
                style: TextStyle(color: AppColors.black),
              )
            : Text(
                'My Groups',
                style: TextStyle(color: AppColors.black),
              ),
        actions: [
          selectedindex.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteDialogWidget(
                            selected: selectedindex.length.toString(),
                          );
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
                      selectedindex.length != 9 ? 'Select all' : 'Deselect all',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
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
                      } else if (selectMode) {
                        setState(() {
                          selectedindex.add(index);
                        });
                      }
                    },
                    onLongPress: () {
                      if (selectedindex.length < 9 &&
                          !selectedindex.contains(index))
                        setState(() {
                          selectMode = !selectMode;
                          selectedindex.add(index);
                        });
                    },
                    child: Container(
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
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            selectedindex.contains(index)
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
                                : SvgPicture.asset('assets/group.svg'),
                            SizedBox(width: 10),
                            Column(
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
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
