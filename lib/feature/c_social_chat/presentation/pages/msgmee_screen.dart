import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/showeditbtn/showeditbtn_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/social_tab_screen.dart';
import 'package:msgmee/feature/c_social_chat/presentation/widgets/popup_menu_button.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/presentation/profile/profile_desc/personal_profile_description.dart';
import 'package:msgmee/theme/colors.dart';
import 'calls_tab/call_tab_screen.dart';
import '../widgets/profile_pic.dart';

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
            ),
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: AppColors.black,
                  ),
                  onPressed: () {}),
              SvgPicture.asset('assets/msgmee_icon.svg'),
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
                Positioned(
                  top: 10,
                  child: AnimatedContainer(
                    height:
                        context.watch<ShoweditbtnCubit>().state.show ? 130 : 0,
                    duration: Duration(milliseconds: 500),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: context.watch<ShoweditbtnCubit>().state.show
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
                          Container(
                            height: 42,
                            width: 42,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.black),
                            child: Image.asset('assets/camera1.png'),
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
