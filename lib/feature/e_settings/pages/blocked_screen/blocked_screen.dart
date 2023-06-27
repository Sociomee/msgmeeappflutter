import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';
import '../../models/blockcontacts_model.dart';
import 'widgets/blocked_bottom_sheet.dart';

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
            'Blocked People (03)',
            style: TextStyle(color: AppColors.black),
          ),
          actions: [
            TextButton(
              child: Text('Add more people',
                  style: TextStyle(color: AppColors.primaryColor)),
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
              },
            )
          ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: AppColors.white),
          backgroundColor: AppColors.primaryColor,
          onPressed: () {}),
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Unclocked "${blockedList[index].title}"'),
                              Text(
                                'Undo',
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                        ));
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
            Center(
                child: TextButton(
              child: Text('Unblock All',
                  style: TextStyle(color: AppColors.primaryColor)),
              onPressed: () {},
            ))
          ],
        ),
      ),
    );
  }
}
