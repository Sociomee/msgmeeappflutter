import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/data/model/dummy_chat_model.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../../../helper/navigator_function.dart';
import '../../../cubit/cubit/search_mode_cubit.dart';
import '../../../widgets/chat_profile_widget.dart';
import '../../../widgets/profile_image_view_dialog.dart';
import '../../calls_tab/call_tab_screen.dart';
import '../../chat_screen/chat_screen.dart';
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
  List<ChatModel> filtedUserList = [];
  @override
  void initState() {
    searchController = TextEditingController();
    _controller = TabController(length: 2, vsync: this);
    filtedUserList = List.from(dummyData);
    searchController.addListener(() {
      searchController.text.isNotEmpty
          ? changetypingState()
          : changetypingStatetofalse();
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  changetypingState() {
    setState(() {
      typing = true;
    });
  }

  changetypingStatetofalse() {
    setState(() {
      typing = false;
    });
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
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              filtedUserList = List.from(dummyData);
                            } else {
                              filtedUserList = dummyData
                                  .where((model) => model.name
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            }
                          });
                        },
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
              AnimatedOpacity(
                duration: Duration(milliseconds: 1500),
                opacity: typing ? 1 : 0,
                child: typing
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filtedUserList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  screenNavigator(
                                      context,
                                      ChatScreen(
                                        name: filtedUserList[index].name,
                                        imageUrl:
                                            filtedUserList[index].imageUrl,
                                        isOnline:
                                            filtedUserList[index].isOnline,
                                        hasStory:
                                            filtedUserList[index].hasStory,
                                      ));
                                },
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: AppColors.white),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 7),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ProfileViewDialog(
                                                    profilename:
                                                        filtedUserList[index]
                                                            .name,
                                                    imageUrl:
                                                        filtedUserList[index]
                                                            .imageUrl,
                                                  ));
                                        },
                                        child: ChatProfileWidget(
                                            imageUrl:
                                                filtedUserList[index].imageUrl,
                                            isOnline:
                                                filtedUserList[index].isOnline,
                                            hasStory:
                                                filtedUserList[index].hasStory),
                                      ),
                                      SizedBox(width: 13),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(filtedUserList[index].name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(height: 8),
                                          Text(filtedUserList[index].message,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors.grey)),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(filtedUserList[index].time,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors.grey)),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              SizedBox(width: 5),
                                              filtedUserList[index]
                                                          .unseenMessage !=
                                                      0
                                                  ? Container(
                                                      height: 20,
                                                      // width: 20,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 3,
                                                              horizontal: 6),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100)),
                                                      child: Text(
                                                          filtedUserList[index]
                                                              .unseenMessage
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    )
                                                  : Container(),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                  height: 0,
                                  thickness: 1,
                                  color: Color(0xFFE4E4E4).withOpacity(.5)),
                            ],
                          );
                        })
                    : Container(),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 1500),
                opacity: typing ? 0 : 1,
                child: typing
                    ? Container()
                    : Column(
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
                              SocialchatWidget(),
                              CallTabScreen(),
                            ]),
                          )
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
