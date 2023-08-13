import 'package:flutter/material.dart';
import '../../../../../theme/colors.dart';

class BlockedUser {
  final String username;
  final String usertype;
  bool isSelected;
  BlockedUser({
    required this.username,
    required this.usertype,
    required this.isSelected,
  });
}

List<BlockedUser> blockedUserlist = [
  BlockedUser(username: 'Guy Hawkins', usertype: 'SocioMee', isSelected: false),
  BlockedUser(
      username: 'Ralph Edwards', usertype: 'SocioMee', isSelected: false),
  BlockedUser(
      username: 'Cameron Williamson', usertype: 'Group', isSelected: false),
  BlockedUser(
      username: 'Annette Black', usertype: 'SocioMee', isSelected: false),
  BlockedUser(username: 'Eleanor Pena', usertype: 'MsgMee', isSelected: false),
  BlockedUser(
      username: 'Eleanor Pena', usertype: 'SocioMee', isSelected: false),
  BlockedUser(
      username: 'Albert Flores', usertype: 'SocioMee', isSelected: false),
  BlockedUser(username: 'Arlene McCoy', usertype: 'Group', isSelected: false),
  BlockedUser(
      username: 'Jenny Wilson', usertype: 'SocioMee', isSelected: false),
  BlockedUser(
      username: 'Kathryn Murphy', usertype: 'MsgMee', isSelected: false),
  BlockedUser(username: 'Guy Hawkins', usertype: 'MsgMee', isSelected: false),
];

class BlockedBottomSheet extends StatefulWidget {
  const BlockedBottomSheet({super.key});

  @override
  State<BlockedBottomSheet> createState() => _BlockedBottomSheetState();
}

class _BlockedBottomSheetState extends State<BlockedBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 80,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: AppColors.lightgrey,
                  borderRadius: BorderRadius.circular(10)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text('Block User',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                    if (blockedUserlist
                              .where((e) => e.isSelected == true)
                              .toList()
                              .length !=
                          blockedUserlist.length) {
                        setState(() {
                          for (var i = 0; i < blockedUserlist.length; i++) {
                            blockedUserlist[i].isSelected = true;
                          }
                        });
                      } else {
                        setState(() {
                          for (var i = 0; i < blockedUserlist.length; i++) {
                            blockedUserlist[i].isSelected = false;
                          }
                        });
                      }
                    },  
                    child: Text(
                      blockedUserlist
                                  .where((e) => e.isSelected == true)
                                  .toList()
                                  .length ==
                              blockedUserlist.length
                          ? 'Unselect All'
                          : 'Select All',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Block Selected',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: AppColors.grey),
            ListView.builder(
                shrinkWrap: true,
                itemCount: blockedUserlist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        blockedUserlist[index].isSelected =
                            !blockedUserlist[index].isSelected;
                      });
                    },
                    leading: Container(
                      height: 44,
                      width: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? AppColors.darkgreen
                              : AppColors.blue,
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        blockedUserlist[index].username[0],
                        style: TextStyle(color: AppColors.white, fontSize: 20),
                      ),
                    ),
                    title: Text(blockedUserlist[index].username),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          blockedUserlist[index].usertype,
                          style: TextStyle(
                            color: Color(0xFFC4C4C4),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            activeColor: AppColors.primaryColor,
                            value: blockedUserlist[index].isSelected,
                            onChanged: (w) {
                              setState(() {
                                blockedUserlist[index].isSelected =
                                    !blockedUserlist[index].isSelected;
                              });
                            })
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
