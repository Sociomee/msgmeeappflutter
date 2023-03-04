import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/presentation/msgmee_screen/widget/chat_profile_widget.dart';
import 'package:msgmee/presentation/msgmee_screen/widget/small_profile_widget.dart';
import 'package:msgmee/theme/custom_theme.dart';

import '../msgmee_screen/calls_tab/widget/delete_calls_bottomsheet.dart';

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

class AddParticipantsScreen extends StatefulWidget {
  const AddParticipantsScreen({super.key});

  @override
  State<AddParticipantsScreen> createState() => _AddParticipantsScreenState();
}

class _AddParticipantsScreenState extends State<AddParticipantsScreen> {
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
                color: CustomTheme.black,
              )),
          title: Text(
            'Add Participants',
            style: TextStyle(color: CustomTheme.black),
          ),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'DONE',
                  style: TextStyle(color: CustomTheme.primaryColor),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 5),
                // height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: CustomTheme.grey,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75))
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomTheme.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomTheme.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomTheme.white),
                          ),
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search....',
                          hintStyle:
                              TextStyle(color: CustomTheme.grey, fontSize: 17),
                          focusColor: CustomTheme.primaryColor,
                          suffixIcon: IconButton(
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
                                    return DeleteCallBottomSheet();
                                  });
                            },
                            icon: Icon(
                              Icons.tune_outlined,
                              color: CustomTheme.black,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: blockedUserlist.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: ChatProfileWidget(
                            imageUrl: blockedUserlist[index].imageUrl,
                            isOnline: true,
                            hasStory: false),
                        title: Text(blockedUserlist[index].username),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              blockedUserlist[index].usertype,
                              style: TextStyle(color: CustomTheme.grey),
                            ),
                            Checkbox(
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                      width: 1.0,
                                      color: CustomTheme.primaryColor),
                                ),
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
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}
