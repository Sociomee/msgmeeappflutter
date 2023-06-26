// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:msgmee/theme/colors.dart';

import '../../../../../data/model/group_participants_model.dart';
import '../../../../../helper/navigator_function.dart';
import '../../../../../presentation/profile/profile_desc/media_tab/media_tab.dart';
import '../../../../../presentation/profile/profile_desc/widgets/options_button_widget.dart';
import '../media_doc_screen/media_and_doc_screen.dart';

class GroupChatPage extends StatefulWidget {
  const GroupChatPage({
    Key? key,
    required this.imageUrl,
    required this.name,
  }) : super(key: key);
  final String imageUrl;
  final String name;

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        titleSpacing: 5,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
        ),
        title: Text(
          'Group Info.',
          style: TextStyle(color: AppColors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert, color: AppColors.black))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: CircleAvatar(
                radius: 80,
                backgroundColor: AppColors.grey,
                backgroundImage: NetworkImage(widget.imageUrl)),
          ),
          SizedBox(height: 10),
          Center(child: Text(widget.name, style: TextStyle(fontSize: 18))),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'The office environment is now a day’s encouraging employees, not by incentives, but various other ways such as activity centres, kids area, motiva- tional quotes. These quotes on the wall of the cabins motivate the employees to work better.',
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 32),
          Center(child: OptionsButtomWidgets()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: AppColors.grey, thickness: 3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  'Media, Docs, Links',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    animatedScreenNavigator(
                        context,
                        MediaAndDocScreen(
                          profilename: widget.name,
                        ));
                  },
                  child: Text(
                    '248',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_outlined, size: 15)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
            child: Text('Recent media'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: SizedBox(
              height: 103,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 103,
                      width: 103,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: AppColors.grey, thickness: 3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pending Request',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '(3)',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: AppColors.grey, thickness: 3),
          ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('Invite Member via Link',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: AppColors.grey, thickness: 3),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20),
            child: Text('1 Member',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.grey,
                  backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600'),
                ),
                SizedBox(width: 10),
                Text('You',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Spacer(),
                Text('Group Admin', style: TextStyle(color: Colors.blue))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20),
            child: Text('Add participants',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dummyGroupParticipantsData.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.grey,
                            backgroundImage: NetworkImage(
                                dummyGroupParticipantsData[index].imageUrl)),
                        SizedBox(width: 10),
                        Text(dummyGroupParticipantsData[index].name,
                            style: TextStyle(fontSize: 16)),
                        Spacer(),
                        Text('invite', style: TextStyle(color: Colors.blue))
                      ],
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
