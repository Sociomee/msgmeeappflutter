import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/theme/custom_theme.dart';

import 'calls_tab/call_tab_screen.dart';
import 'calls_tab/widget/call_bottom_model_sheet.dart';
import 'social_tab/social_tab_screen.dart';
import 'widget/profile_pic.dart';
import 'widget/social_bottom_model_sheet.dart';

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
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          leadingWidth: 0,
          title: Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 14.0),
                  child: ProfilePicWidget()),
              _selectedIndex == 0
                  ? Text(
                      "MsgMee",
                      style: TextStyle(
                        color: CustomTheme.black,
                        fontSize: 22,
                      ),
                    )
                  : Text(
                      "Social Calls",
                      style: TextStyle(
                        color: CustomTheme.black,
                        fontSize: 22,
                      ),
                    ),
            ],
          ),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.search,
                  color: CustomTheme.black,
                ),
                onPressed: () {}),
            IconButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: CustomTheme.black,
                ),
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
                        return _selectedIndex == 0
                            ? SocialBottomModelSheet()
                            : CallBottomModelSheet();
                      });
                }),
          ],
        ),
        // backgroundColor: CustomTheme.white,
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
                  indicatorColor: CustomTheme.primaryColor,
                  labelColor: CustomTheme.primaryColor,
                  unselectedLabelColor: CustomTheme.grey,
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
    );
  }
}
