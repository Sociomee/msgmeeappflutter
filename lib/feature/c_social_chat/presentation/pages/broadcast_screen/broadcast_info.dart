import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../../../../../data/model/participants_model.dart';
import '../../../../../theme/colors.dart';
import '../../widgets/chat_profile_widget.dart';
import 'broadcast_chat_screen.dart';
import 'widget/text_field_widget.dart';

// class Participants {
//   final String username;
//   final String usertype;
//   final String imageUrl;
//   bool isSelected;

//   Participants({
//     required this.username,
//     required this.usertype,
//     required this.isSelected,
//     required this.imageUrl,
//   });
// }

// List<Participants> blockedUserlist = [
//   Participants(
//       username: 'Guy Hawkins',
//       usertype: 'SocioMee',
//       isSelected: true,
//       imageUrl:
//           'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1600'),
//   Participants(
//       username: 'Ralph Edwards',
//       usertype: 'SocioMee',
//       isSelected: false,
//       imageUrl:
//           'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1600'),
//   Participants(
//       username: 'Cameron Williamson',
//       usertype: 'Group',
//       isSelected: false,
//       imageUrl:
//           'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1600'),
//   Participants(
//       username: 'Annette Black',
//       usertype: 'SocioMee',
//       isSelected: false,
//       imageUrl:
//           'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1600'),
//   Participants(
//       username: 'Eleanor Pena',
//       usertype: 'MsgMee',
//       isSelected: false,
//       imageUrl:
//           'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600'),
//   Participants(
//       username: 'Eleanor Pena',
//       usertype: 'SocioMee',
//       isSelected: false,
//       imageUrl:
//           'https://images.pexels.com/photos/1559486/pexels-photo-1559486.jpeg?auto=compress&cs=tinysrgb&w=1600'),
//   Participants(
//       username: 'Albert Flores',
//       usertype: 'SocioMee',
//       isSelected: false,
//       imageUrl:
//           'https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&w=1600'),
//   Participants(
//       username: 'Arlene McCoy',
//       usertype: 'Group',
//       isSelected: false,
//       imageUrl:
//           'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1600'),
//   Participants(
//       username: 'Jenny Wilson',
//       usertype: 'SocioMee',
//       isSelected: false,
//       imageUrl:
//           'https://images.pexels.com/photos/2773977/pexels-photo-2773977.jpeg?auto=compress&cs=tinysrgb&w=1600'),
//   Participants(
//       username: 'Kathryn Murphy',
//       usertype: 'MsgMee',
//       isSelected: false,
//       imageUrl:
//           'https://images.pexels.com/photos/3764119/pexels-photo-3764119.jpeg?auto=compress&cs=tinysrgb&w=1600'),
//   Participants(
//       username: 'Guy Hawkins',
//       usertype: 'MsgMee',
//       isSelected: false,
//       imageUrl:
//           'https://images.pexels.com/photos/2918513/pexels-photo-2918513.jpeg?auto=compress&cs=tinysrgb&w=1600'),
// ];

class BroadcastInfo extends StatefulWidget {
  const BroadcastInfo({super.key, required this.editscreen});
  final bool editscreen;
  @override
  State<BroadcastInfo> createState() => _BroadcastInfoState();
}

class _BroadcastInfoState extends State<BroadcastInfo> {
  late TextEditingController nameController;
  late TextEditingController summaryController;
  int remainchar = 25;
  int remainchar1 = 180;
  bool isSelected = false;
  @override
  void initState() {
    nameController = TextEditingController();
    summaryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
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
            'Broadcast Info',
            style: TextStyle(color: AppColors.black),
          ),
          actions: [
            widget.editscreen
                ? TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(color: AppColors.primaryColor),
                    ))
                : TextButton(
                    onPressed: () {
                      animatedScreenReplaceNavigator(
                          context, BroadCastChatScreen());
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(color: AppColors.primaryColor),
                    ))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: 26),
                  BroadcastTextFieldWidget(
                    title: 'Name*',
                    hintText: 'Broadcast Name',
                    controller: nameController,
                    onChanged: (e) {
                      setState(() {
                        remainchar = 25 - nameController.text.length;
                      });
                    },
                    remainChar: remainchar.toString(),
                  ),
                  BroadcastTextFieldWidget(
                    title: 'Summary',
                    hintText: 'Brief description',
                    controller: summaryController,
                    onChanged: (e) {
                      setState(() {
                        remainchar1 = 180 - summaryController.text.length;
                      });
                    },
                    remainChar: remainchar1.toString(),
                  ),
                ],
              ),
            ),
            Divider(color: AppColors.lightgrey, thickness: 2),
            ListTile(
              leading: Text('Mute Notification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              trailing: Checkbox(
                  side: MaterialStateBorderSide.resolveWith(
                    (states) =>
                        BorderSide(width: 1.0, color: AppColors.primaryColor),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  activeColor: AppColors.primaryColor,
                  value: isSelected,
                  onChanged: (w) {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  }),
            ),
            Divider(color: AppColors.lightgrey, thickness: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Text('Add more participants',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColors.borderColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColors.borderColor)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColors.primaryColor)),
                        hintText: 'Search Participants...',
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.grey,
                        )),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [Spacer(), Text('12 Participant')],
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: blockedUserlist.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: ChatProfileWidget(
                                imageUrl: blockedUserlist[index].imageUrl,
                                isOnline: false,
                                hasStory: false),
                            title: Text(blockedUserlist[index].username),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                blockedUserlist[index].isSelected
                                    ? Text('You',
                                        style: TextStyle(color: AppColors.blue))
                                    : Container(),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
