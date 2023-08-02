import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../cubit/cubit/search_mode_cubit.dart';
import '../../calls_tab/call_tab_screen.dart';
import '../../social_tab/widget/social_chat_widget.dart';

class MessageSearchPage extends StatefulWidget {
  const MessageSearchPage({super.key});

  @override
  State<MessageSearchPage> createState() => _MessageSearchPageState();
}

class _MessageSearchPageState extends State<MessageSearchPage>
    with SingleTickerProviderStateMixin {
  late TextEditingController searchController;
  bool typing = false;
  late TabController _controller;

  @override
  void initState() {
    searchController = TextEditingController();
    _controller = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          context
                              .read<SearchModeCubit>()
                              .changeuserSearchMode();
                        },
                        child:
                            Icon(Icons.arrow_back_ios, color: AppColors.grey)),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            setState(() {
                              typing = true;
                            });
                          } else {
                            setState(() {
                              typing = false;
                            });
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          suffixIconColor: AppColors.black,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
                  SocialchatWidget(),
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
