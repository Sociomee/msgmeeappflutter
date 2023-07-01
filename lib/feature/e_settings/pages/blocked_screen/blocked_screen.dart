import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
              )),
          title: Text(
            'Blocked People',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
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
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search...',
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
            SizedBox(height: 25),
            ListView.builder(
                shrinkWrap: true,
                itemCount: blockedList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.grey,
                      backgroundImage:
                          NetworkImage(blockedList[index].imageUrl),
                    ),
                    title: Text(blockedList[index].title),
                    subtitle: Text(blockedList[index].subtitle),
                    trailing: InkWell(
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
                        width: 65,
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
                  );
                }),
            SizedBox(height: 16),
            Center(
              child: Text(
                'Blocked  people cannot see any activity by you',
                style: TextStyle(color: AppColors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}