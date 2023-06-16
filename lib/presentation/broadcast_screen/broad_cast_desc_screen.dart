import 'package:flutter/material.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/presentation/broadcast_screen/broadcast_info.dart';
import '../../theme/colors.dart';
import '../msgmee_screen/widget/chat_profile_widget.dart';

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
      isSelected: true,
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
      isSelected: true,
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
      isSelected: true,
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

class BroadCastDescriptionScreen extends StatefulWidget {
  const BroadCastDescriptionScreen({super.key});

  @override
  State<BroadCastDescriptionScreen> createState() =>
      _BroadCastDescriptionScreenState();
}

class _BroadCastDescriptionScreenState
    extends State<BroadCastDescriptionScreen> {
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
            TextButton(
                onPressed: () {
                  animatedScreenReplaceNavigator(
                      context,
                      BroadcastInfo(
                        editscreen: true,
                      ));
                },
                child: Text(
                  'Edit',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'College Friends',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. In ultricies eget adipiscing leo mattis egestas feugiat. A nibh blandit pharetra sed odio ut euismod diam. Ut aliquam donec mauris volutpat condimentum. Cursus dui.',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ]),
            ),
            Divider(color: AppColors.lightgrey, thickness: 2, height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        'Add more participants',
                        style: TextStyle(color: AppColors.primaryColor),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 12),
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
                        hintStyle: TextStyle(fontSize: 12),
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.grey,
                        )),
                  ),
                  SizedBox(height: 10),
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
                                isOnline: blockedUserlist[index].isSelected,
                                hasStory: false),
                            title: Text(blockedUserlist[index].username),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(blockedUserlist[index].usertype,
                                    style: TextStyle(color: AppColors.grey))
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
            Container(
              height: 62,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 20),
              color: AppColors.lightgrey1,
              alignment: Alignment.center,
              child: Text(
                'Delete Broadcast',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        )),
      ),
    );
  }
}
