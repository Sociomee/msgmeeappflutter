import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/theme/custom_theme.dart';

import 'calls_tab/call_tab_screen.dart';
import 'social_tab/social_tab_screen.dart';
import 'widget/profile_pic.dart';

class MsgmeeScreen extends StatelessWidget {
  const MsgmeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: CustomTheme.white,
        elevation: 0,
        leadingWidth: 0,
        title: Row(
          children: const [
            Padding(
                padding: EdgeInsets.only(right: 14.0),
                child: ProfilePicWidget()),
            Text(
              "MsgMee",
              style: TextStyle(color: CustomTheme.black, fontSize: 22),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search, color: CustomTheme.black),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.more_vert, color: CustomTheme.black),
              onPressed: () {}),
        ],
      ),
      backgroundColor: CustomTheme.white,
      body: DefaultTabController(
        length: 2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                  border: const Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.8)),
                ),
                child: const TabBar(
                  indicatorWeight: 3,
                  indicatorColor: CustomTheme.primaryColor,
                  labelColor: CustomTheme.primaryColor,
                  unselectedLabelColor: CustomTheme.grey,
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
                child: const TabBarView(children: [
                  SocialTabScreen(),
                  CallTabScreen(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
