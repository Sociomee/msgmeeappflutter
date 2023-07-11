import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/selectedchat/selectedchat_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/showeditbtn/showeditbtn_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/social_tab_screen.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/widget/social_chat_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/widgets/popup_menu_button.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/feature/c_profile/presentation/pages/personal_profile_description.dart';
import 'package:msgmee/theme/colors.dart';
import 'package:stories_editor/stories_editor.dart';
import '../widgets/messenger_bottomsheet.dart';
import 'calls_tab/call_tab_screen.dart';
import '../widgets/profile_pic.dart';
import 'message_search/pages/message_search_page.dart';

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
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: context.watch<SelectedchatCubit>().state.selectedchat.isNotEmpty
            ? Scaffold(
                appBar: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      context.read<SelectedchatCubit>().remove();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.black,
                    ),
                  ),
                  titleSpacing: 0,
                  title: Text(
                    context
                        .watch<SelectedchatCubit>()
                        .state
                        .selectedchat
                        .length
                        .toString(),
                    style: TextStyle(
                      color: Color(0xFF4E4E4E),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        context.read<SelectedchatCubit>().starClicked();
                      },
                      child:
                          context.watch<SelectedchatCubit>().state.starClicked
                              ? SvgPicture.asset('assets/star_clicked.svg')
                              : Icon(
                                  Icons.star_outline,
                                  color: AppColors.black,
                                  size: 18,
                                ),
                    ),
                    SizedBox(width: 19),
                    Icon(
                      Icons.archive_outlined,
                      color: AppColors.black,
                      size: 18,
                    ),
                    SizedBox(width: 19),
                    GestureDetector(
                      onTap: () {
                        context.read<SelectedchatCubit>().pinClicked();
                      },
                      child: context.watch<SelectedchatCubit>().state.pinned
                          ? SvgPicture.asset('assets/pin.svg')
                          : Transform.rotate(
                              angle: pi / 4,
                              child: Icon(
                                Icons.push_pin_outlined,
                                color: AppColors.black,
                                size: 18,
                              ),
                            ),
                    ),
                    SizedBox(width: 19),
                    GestureDetector(
                      onTap: () {
                        context.read<SelectedchatCubit>().muteClicked();
                      },
                      child: Icon(
                        Icons.volume_mute_outlined,
                        color: AppColors.black,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 19),
                    Icon(
                      Icons.delete_outline,
                      color: AppColors.black,
                      size: 18,
                    ),
                    SizedBox(width: 19),
                    Icon(
                      Icons.more_vert,
                      color: AppColors.black,
                      size: 18,
                    ),
                    SizedBox(width: 13),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [SocialchatWidget()],
                  ),
                ),
              )
            : Scaffold(
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
                  ),
                  actions: [
                    IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: AppColors.black,
                        ),
                        onPressed: () {
                          animatedScreenNavigator(context, MessageSearchPage());
                        }),
                    GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return MessengerOptionsBottomSheet();
                              });
                        },
                        child: SvgPicture.asset('assets/msgmee_icon.svg')),
                    PopupMenuButtonWidget()
                  ],
                ),
                body: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.0),
                              border: const Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 0.8)),
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
                            child:
                                TabBarView(controller: _controller, children: [
                              SocialTabScreen(),
                              CallTabScreen(),
                            ]),
                          )
                        ],
                      ),
                      Positioned(
                        top: 10,
                        child: AnimatedContainer(
                          height: context.watch<ShoweditbtnCubit>().state.show
                              ? 130
                              : 0,
                          duration: Duration(milliseconds: 500),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow:
                                context.watch<ShoweditbtnCubit>().state.show
                                    ? [
                                        BoxShadow(
                                            color: AppColors.lightgrey,
                                            offset: Offset(0, 0.5),
                                            blurRadius: 10,
                                            spreadRadius: 5),
                                      ]
                                    : null,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const WhatsappStoryEditor()),
                                    // );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => StoriesEditor(
                                                  giphyKey:
                                                      'C4dMA7Q19nqEGdpfj82T8ssbOeZIylD4',
                                                  //fontFamilyList: const ['Shizuru', 'Aladin'],
                                                  galleryThumbnailQuality: 300,
                                                  //isCustomFontList: true,
                                                  onDone: (uri) {
                                                    debugPrint(uri);
                                                    // Share.shareFiles([uri]);
                                                  },
                                                )));
                                  },
                                  child: Container(
                                    height: 42,
                                    width: 42,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppColors.black),
                                    child: Image.asset('assets/camera1.png'),
                                  ),
                                ),
                                Container(
                                  height: 42,
                                  width: 42,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 19),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: AppColors.primaryColor),
                                  child: Image.asset('assets/edit1.png'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
