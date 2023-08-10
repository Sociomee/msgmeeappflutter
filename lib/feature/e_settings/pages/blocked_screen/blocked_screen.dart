import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/e_settings/pages/blocked_screen/widgets/blocked_bottom_sheet.dart';
import 'package:msgmee/feature/e_settings/pages/blocked_screen/widgets/unblock_dialog.dart';
import 'package:msgmee/feature/e_settings/pages/blocked_screen/widgets/unblock_one_user_dialog.dart';
import '../../../../theme/colors.dart';
import '../../models/blockcontacts_model.dart';

class BlockedPeopleScreen extends StatefulWidget {
  const BlockedPeopleScreen({super.key});

  @override
  State<BlockedPeopleScreen> createState() => _BlockedPeopleScreenState();
}

class _BlockedPeopleScreenState extends State<BlockedPeopleScreen> {
  late TextEditingController controller;
  List<BlockContact> filteredlist = [];
  @override
  void initState() {
    controller = TextEditingController();
    filteredlist = List.from(blockedList);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 3,
          shadowColor: AppColors.lightgrey1,
          leading: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size: 20,
                )),
          ),
          leadingWidth: 45,
          titleSpacing: 5,
          title: Text('Blocked People',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              )),
          actions: [
            Center(
                child: TextButton(
              child: Text('Unblock All',
                  style: TextStyle(color: AppColors.primaryColor)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return UnblockUserDialog();
                    });
              },
            )),
          ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: AppColors.white),
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                context: context,
                builder: (context) {
                  return BlockedBottomSheet();
                });
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: SizedBox(
                height: 45,
                child: TextFormField(
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        filteredlist = List.from(blockedList);
                      } else {
                        filteredlist = blockedList
                            .where((model) => model.title
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      }
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(),
                      hintText: 'Search...',
                      suffixIcon: Icon(Icons.search)),
                ),
              ),
            ),
            SizedBox(height: 25),
            ListView.builder(
                shrinkWrap: true,
                itemCount: filteredlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.grey,
                          backgroundImage:
                              NetworkImage(filteredlist[index].imageUrl),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(filteredlist[index].title),
                            SizedBox(height: 1),
                            Text(filteredlist[index].subtitle)
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return UnblockOneUserDialog(
                                    title: blockedList[index].title,
                                  );
                                });
                          },
                          child: Container(
                            height: 25,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Unblock',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            SizedBox(height: 16),
            Center(
                child: Text(
              'Blocked  people cannot see any activity by you ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF9D9D9D),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
