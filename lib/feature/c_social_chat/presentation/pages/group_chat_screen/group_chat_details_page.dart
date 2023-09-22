// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/exit_alert_dialog.dart';

import 'package:msgmee/theme/colors.dart';

import '../../../../../common_widgets/dx_appbar.dart';
import '../../../../../data/model/group_participants_model.dart';
import '../../../../../helper/navigator_function.dart';
import '../../../../c_profile/presentation/pages/media_tab.dart';
import '../../../../c_profile/presentation/widgets/options_button_widget.dart';
import '../media_doc_screen/media_and_doc_screen.dart';
import 'group_invite_page.dart';

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
      appBar: DAppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
              size: 16,
            ),
          ),
        ),
        title: Text(
          'Group Info.',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: 1, child: Text('Edit Group')),
                PopupMenuItem(value: 2, child: Text('Delete Group')),
                PopupMenuItem(value: 3, child: Text('Report Group')),
              ];
            },
            onSelected: (value) {
              if (value == 1) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ExitAlertDialog();
                    });
              } else if (value == 2) {
              } else if (value == 3) {}
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20),
          Center(
            child: Hero(
              tag: widget.imageUrl,
              child: Container(
                height: 120,
                width: 120,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: AppColors.lightgrey)
                  ],
                  border: Border.all(color: AppColors.white, width: 5),
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(widget.imageUrl)),
                ),
              ),
            ),
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
            child: Divider(
                color: AppColors.lightgrey.withOpacity(.5), thickness: 5),
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
            child: Divider(
                color: AppColors.lightgrey.withOpacity(.5), thickness: 5),
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
            child: Divider(
                color: AppColors.lightgrey.withOpacity(.5), thickness: 5),
          ),
          Padding(
            padding: EdgeInsets.only(left: 13.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mute Notification',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Checkbox(
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
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              animatedScreenNavigator(context, GroupInvitePage());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Invite Member via Link',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(
                color: AppColors.lightgrey.withOpacity(.5), thickness: 5),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20),
            child: Text('1 Member',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                )),
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
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    )),
                Spacer(),
                Text('Group Admin',
                    style: TextStyle(
                      color: Color(0xFF2F80ED),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20),
            child: Text('Add more participants',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                )),
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
                        Container(
                          height: 40.w,
                          width: 40.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.black.withOpacity(.2),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.6),
                                      BlendMode.dstATop),
                                  image: NetworkImage(
                                      dummyGroupParticipantsData[index]
                                          .imageUrl))),
                        ),
                        SizedBox(width: 10),
                        Text(dummyGroupParticipantsData[index].name,
                            style: TextStyle(
                              color: Color(0xFF151624),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            )),
                        Spacer(),
                        Text('Invite',
                            style: TextStyle(
                              color: Color(0xFF2F80ED),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ))
                      ],
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(
                color: AppColors.lightgrey.withOpacity(.5), thickness: 5),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, bottom: 60.h),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/delete_forever.svg'),
                  SizedBox(width: 10),
                  Text("Delete 'College Group'",
                      style: TextStyle(
                          color: Color(0xCCFF1F1F),
                          fontSize: 16,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w500))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
