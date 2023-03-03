import 'package:flutter/material.dart';
import '../../../theme/custom_theme.dart';

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
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        // height: 380.h,
        decoration: BoxDecoration(
            color: CustomTheme.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 80,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: CustomTheme.lightgrey,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(height: 20),
            Text('Block User',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select All',
                    style: TextStyle(
                        color: CustomTheme.primaryColor, fontSize: 16),
                  ),
                  Text(
                    'Block Selected',
                    style: TextStyle(
                        color: CustomTheme.primaryColor, fontSize: 16),
                  ),
                ],
              ),
            ),
            Divider(color: CustomTheme.grey),
            ListView.builder(
                shrinkWrap: true,
                itemCount: blockedUserlist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      height: 44,
                      width: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? CustomTheme.darkgreen
                              : CustomTheme.blue,
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        blockedUserlist[index].username[0],
                        style:
                            TextStyle(color: CustomTheme.white, fontSize: 20),
                      ),
                    ),
                    title: Text(blockedUserlist[index].username),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          blockedUserlist[index].usertype,
                          style: TextStyle(color: CustomTheme.grey),
                        ),
                        Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            activeColor: CustomTheme.primaryColor,
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
