import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/social_tab_screen.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/presentation/profile/profile_desc/personal_profile_description.dart';
import 'package:msgmee/theme/colors.dart';
import '../../../../presentation/broadcast_screen/add_participant_screen.dart';
import '../../../../presentation/connect_webpanel/linked_devices_screen.dart';
import '../../../../presentation/new_message/new_message_screen.dart';
import '../../../../presentation/settings/settings_screen.dart';
import 'calls_tab/call_tab_screen.dart';
import '../widgets/profile_pic.dart';
import '../widgets/social_bottom_model_sheet.dart';
import 'create_group_page.dart';

class MsgmeeScreen extends StatefulWidget {
  const MsgmeeScreen({super.key});

  @override
  State<MsgmeeScreen> createState() => _MsgmeeScreenState();
}

class _MsgmeeScreenState extends State<MsgmeeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ChatOptionsModel> options = [
      ChatOptionsModel(id: 1, option: 'New Message'),
      ChatOptionsModel(id: 2, option: 'My Notes'),
      ChatOptionsModel(id: 3, option: 'Create New Group'),
      ChatOptionsModel(id: 4, option: 'Create a Broadcast'),
      ChatOptionsModel(id: 5, option: 'Archived Chats'),
      ChatOptionsModel(id: 6, option: 'Sync your Sociomate'),
      ChatOptionsModel(id: 7, option: 'Settings'),
    ];
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            leadingWidth: 0,
            title: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 14.0),
                    child: GestureDetector(
                        onTap: () {
                          animatedScreenNavigator(
                              context, PersonalPeofileDesc());
                        },
                        child: ProfilePicWidget())),
                _selectedIndex == 0
                    ? Text(
                        "MsgMee",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 22,
                        ),
                      )
                    : Text(
                        "Social Calls",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 22,
                        ),
                      ),
              ],
            ), // showModalBottomSheet(
            //     isScrollControlled: true,
            //     shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.vertical(
            //         top: Radius.circular(25.0),
            //       ),
            //     ),
            //     context: context,
            //     builder: (context) {
            //       return _selectedIndex == 0
            //           ? SocialBottomModelSheet()
            //           : CallBottomModelSheet();
            //     });
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: AppColors.black,
                  ),
                  onPressed: () {}),
              SvgPicture.asset('assets/msgmee_icon.svg'),
              PopupMenuButton<int>(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                itemBuilder: (context) {
                  return options
                      .map(
                        (e) => PopupMenuItem(
                            value: e.id,
                            // onTap: e.clickAction,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.option),
                                  e.id == 6
                                      ? Text(
                                          'No syncing processed yet',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.grey),
                                        )
                                      : Container(),
                                  SizedBox(height: 10),
                                  e.id == 7
                                      ? Container()
                                      : Divider(
                                          height: 0,
                                          color: AppColors.grey,
                                        )
                                ],
                              ),
                            )),
                      )
                      .toList();
                },
                offset: Offset(0, 100),
                color: Colors.white,
                elevation: 2,
                onSelected: (value) {
                  if (value == 1) {
                    screenNavigator(context, NewMessageScreen());
                  } else if (value == 2) {
                  } else if (value == 3) {
                    animatedScreenNavigator(context, CreateGroupPage());
                  } else if (value == 4) {
                    animatedScreenNavigator(context, AddParticipantsScreen());
                  } else if (value == 5) {
                    screenNavigator(context, LinkedDevicesScreen());
                  } else if (value == 6) {
                  } else if (value == 7) {
                    screenNavigator(context, SettingScreen());
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.0),
                    border: const Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.8)),
                  ),
                  child: TabBar(
                    indicatorWeight: 3,
                    indicatorColor: AppColors.primaryColor,
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: AppColors.grey,
                    controller: _controller,
                    tabs: [
                      Tab(
                        icon: Text(
                          'Social',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Tab(
                        icon: Text(
                          'Calls',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 570.h,
                  child: TabBarView(controller: _controller, children: [
                    SocialTabScreen(),
                    CallTabScreen(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
