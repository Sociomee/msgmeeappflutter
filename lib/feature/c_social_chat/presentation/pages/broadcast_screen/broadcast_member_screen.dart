import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';
import '../../widgets/chat_profile_widget.dart';

class Participants {
  final String username;
  final String usertype;
  final String imageUrl;
  bool isSelected;
  Participants({
    required this.username,
    required this.usertype,
    required this.isSelected,
    required this.imageUrl,
  });
}

List<Participants> blockedUserlist = [
  Participants(
      username: 'Guy Hawkins',
      usertype: 'SocioMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Participants(
      username: 'Ralph Edwards',
      usertype: 'SocioMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Participants(
      username: 'Cameron Williamson',
      usertype: 'Group',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Participants(
      username: 'Annette Black',
      usertype: 'SocioMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Participants(
      username: 'Eleanor Pena',
      usertype: 'MsgMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Participants(
      username: 'Eleanor Pena',
      usertype: 'SocioMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/1559486/pexels-photo-1559486.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Participants(
      username: 'Albert Flores',
      usertype: 'SocioMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Participants(
      username: 'Arlene McCoy',
      usertype: 'Group',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Participants(
      username: 'Jenny Wilson',
      usertype: 'SocioMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/2773977/pexels-photo-2773977.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Participants(
      username: 'Kathryn Murphy',
      usertype: 'MsgMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/3764119/pexels-photo-3764119.jpeg?auto=compress&cs=tinysrgb&w=1600'),
  Participants(
      username: 'Guy Hawkins',
      usertype: 'MsgMee',
      isSelected: false,
      imageUrl:
          'https://images.pexels.com/photos/2918513/pexels-photo-2918513.jpeg?auto=compress&cs=tinysrgb&w=1600'),
];

class BroadcastMemberScreen extends StatefulWidget {
  const BroadcastMemberScreen({super.key});

  @override
  State<BroadcastMemberScreen> createState() => _BroadcastMemberScreenState();
}

class _BroadcastMemberScreenState extends State<BroadcastMemberScreen> {
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
            'Broadcast Member List',
            style: TextStyle(color: AppColors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Column(
              children: [
                SizedBox(height: 24),
                Row(
                  children: [
                    Text('12 Participant'),
                    Spacer(),
                    Text(
                      'Add Participants',
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 16),
                    )
                  ],
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
                          trailing: TextButton(
                            onPressed: () {
                              setState(() {
                                blockedUserlist[index].isSelected =
                                    !blockedUserlist[index].isSelected;
                              });
                            },
                            child: blockedUserlist[index].isSelected
                                ? Text(
                                    'Add',
                                    style: TextStyle(
                                        color: AppColors.primaryColor),
                                  )
                                : Text(
                                    'Remove',
                                    style: TextStyle(color: Colors.red),
                                  ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
