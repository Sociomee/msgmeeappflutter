import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:msgmee/data/api_data_source/repository/socket/msgmee_socket.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/chat_selection_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/audio_record.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/selectedchat/selectedchat_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/showeditbtn/showeditbtn_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/social_tab_screen.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/widget/social_chat_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/widgets/popup_menu_button.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/feature/c_profile/presentation/pages/personal_profile_description.dart';
import 'package:msgmee/theme/colors.dart';
import 'package:stories_editor/stories_editor.dart';
import '../../../../data/model/dummy_chat_model.dart';
import '../../../../helper/connectivity_mixin.dart';
import '../../../c_profile/presentation/cubit/get_user_details/get_userdetails_cubit.dart';
import '../cubit/chatrooms/chatrooms_cubit.dart';
import '../cubit/get_contact/get_contact_cubit.dart';
import '../cubit/msgmee_user_list/msgmee_user_list_cubit.dart';
import '../cubit/search_mode/search_mode_cubit.dart';
import '../cubit/sync_sociomee/sync_sociomee_cubit.dart';
import '../widgets/chat_profile_widget.dart';
import '../widgets/messenger_bottomsheet.dart';
import '../widgets/profile_image_view_dialog.dart';
import '../widgets/social_bottom_model_sheet.dart';
import 'biz_page/biz_page.dart';
import 'calls_tab/call_tab_screen.dart';
import '../widgets/profile_pic.dart';
import 'chat_screen/chat_screen.dart';
import 'market/market_page.dart';


class MsgmeeScreen extends StatefulWidget {
  const MsgmeeScreen({super.key});

  @override
  State<MsgmeeScreen> createState() => _MsgmeeScreenState();
}

class _MsgmeeScreenState extends State<MsgmeeScreen>
    with TickerProviderStateMixin {



// Access the socket like this
  late TabController _controller;
  late TabController tabsComtroller;
  int _selectedIndex = 0;
  File? image;
  late FToast fToast;
  double width = 0;
  double height = 0;
  bool typing = false;
  MsgmeeSocket msgmeeSocket = MsgmeeSocket();
  late TextEditingController searchController;
  List<ChatModel> filtedUserList = [];
  List<ChatOptionsModel> options = [
    ChatOptionsModel(id: 1, option: 'Mark as unread'),
    ChatOptionsModel(id: 2, option: 'Block user'),
    ChatOptionsModel(id: 3, option: 'Clear chats'),
    ChatOptionsModel(id: 4, option: 'Select all'),
  ];
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  @override
  void initState() {
    super.initState();
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      log('source $_source');
      // 1.
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string =
              _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
          break;
        case ConnectivityResult.wifi:
          string =
              _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
      }
      // 2.
      // setState(() {});
      // 3.
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //       string,
      //       style: TextStyle(fontSize: 15),
      //     ),
      //   ),
      // );
    });
    context.read<ChatRoomsCubit>().getLocalChatRoomData();
    context
        .read<ContactCubit>()
        .fetchContacts(context.read<MsgmeeUserListCubit>());
    context.read<SyncSociomeeCubit>().checkSocimeeCubit();
    context.read<GetUserdetailsCubit>().getUserDetailsCubit();
    msgmeeSocket.connectSocket();
    msgmeeSocket.getOnlineUsers(context.read<ChatRoomsCubit>());
    msgmeeSocket.receivedMessage(context.read<ChatRoomsCubit>());
    context.read<ChatRoomsCubit>().getPhoneAndUserid();
    context.read<ChatRoomsCubit>().getchatroomsList();
    _controller = TabController(length: 2, vsync: this);
    tabsComtroller = TabController(length: 4, vsync: this);
    tabsComtroller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    fToast = FToast();
    fToast.init(context);
    filtedUserList = List.from(dummyData);
    searchController = TextEditingController();
    searchController.addListener(() {
      searchController.text.isNotEmpty
          ? changetypingState()
          : changetypingStatetofalse();
    });
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
    log('string------->$string');
    return DefaultTabController(
      length:
          context.watch<SyncSociomeeCubit>().state.isSocimeeAcSynced ? 4 : 2,
      initialIndex: 0,
      child: WillPopScope(
        onWillPop: () async {
          if (context.watch<SelectionCubit>().state.isNotEmpty) {
            context.read<SelectionCubit>().clearSelection();
            return false;
          }
          return true;
        },
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: context.watch<SelectionCubit>().state.isNotEmpty
              ? Scaffold(
                  appBar: AppBar(
                    leading: GestureDetector(
                      onTap: () {
                        context.read<SelectionCubit>().clearSelection();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.black,
                        size: 20,
                      ),
                    ),
                    titleSpacing: 0,
                    title: Text(
                      context.watch<SelectionCubit>().state.length.toString(),
                      style: TextStyle(
                          color: Color(0xFF4E4E4E),
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          context.read<SelectedchatCubit>().starClicked();
                        },
                        child:
                            context.watch<SelectedchatCubit>().state.starClicked
                                ? SvgPicture.asset(
                                    'assets/star_clicked.svg',
                                    height: 14,
                                    fit: BoxFit.contain,
                                  )
                                : SvgPicture.asset(
                                    'assets/star.svg',
                                    height: 14,
                                    fit: BoxFit.contain,
                                  ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Widget toast = Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 12.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: AppColors.iconColor),
                            child: Text(
                              "Chat moved to archive",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                          fToast.showToast(
                            child: toast,
                            gravity: ToastGravity.BOTTOM,
                            toastDuration: Duration(seconds: 2),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SvgPicture.asset(
                            'assets/archive.svg',
                            height: 14,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            context.read<SelectedchatCubit>().pinClicked();
                          },
                          child: context.watch<SelectedchatCubit>().state.pinned
                              ? SvgPicture.asset('assets/pin.svg',
                                  height: 14, fit: BoxFit.contain)
                              : SvgPicture.asset('assets/pin1.svg',
                                  height: 14, fit: BoxFit.contain)),
                      GestureDetector(
                          onTap: () {
                            context.read<SelectedchatCubit>().muteClicked();
                          },
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: SvgPicture.asset('assets/volume_off.svg',
                                  height: 14, fit: BoxFit.contain))),
                      SvgPicture.asset('assets/delete.svg',
                          height: 14, fit: BoxFit.contain),
                      PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                          size: 18,
                        ),
                        itemBuilder: (context) {
                          return options
                              .map((e) => PopupMenuItem(
                                  value: e.id,
                                  child: Text(
                                    e.option,
                                    style: TextStyle(
                                      color: Color(0xFF4E4E4E),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )))
                              .toList();
                        },
                        onSelected: (value) {
                          if (value == 1) {
                          } else if (value == 2) {
                          } else if (value == 3) {
                          } else if (value == 4) {}
                        },
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [SocialchatWidget()],
                    ),
                  ),
                )
              : Scaffold(
                  appBar: context
                          .watch<SearchModeCubit>()
                          .state
                          .chatuserSearchMode
                      ? AppBar(
                          toolbarHeight: 70,
                          elevation: 0,
                          titleSpacing: 0,
                          leading: GestureDetector(
                              onTap: () {
                                context
                                    .read<SearchModeCubit>()
                                    .changeuserSearchMode();
                              },
                              child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 1700),
                                  opacity: width == 0 ? 0 : 1,
                                  child: Icon(Icons.arrow_back_ios,
                                      color: AppColors.grey))),
                          title: AnimatedContainer(
                            duration: Duration(milliseconds: 1500),
                            margin: EdgeInsets.only(right: 20),
                            width: width,
                            height: height,
                            child: TextFormField(
                              controller: searchController,
                              autofocus: true,
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
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        )
                      : AppBar(
                          toolbarHeight: 70,
                          elevation: 0,
                          leadingWidth: 0,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(right: 14.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      animatedScreenNavigator(
                                          context, PersonalPeofileDesc());
                                    },
                                    child: ProfilePicWidget(),
                                  )),
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

                                     ElevatedButton(onPressed: (){
                                      print("clicked");
                                     }, child: Text("Start")),
                            ],
                          ),
                          actions: [
                            IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  color: AppColors.black,
                                ),
                                onPressed: () {
                                  context
                                      .read<SearchModeCubit>()
                                      .changeuserSearchMode();
                                  setState(() {
                                    width = 330.w;
                                    height = 48;
                                  });
                                }),
                            SizedBox(width: 15),
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
                                child:
                                    SvgPicture.asset('assets/msgmee_icon.svg')),
                            SizedBox(width: 15),
                            PopupMenuButtonWidget()
                          ],
                        ),
                  body: filtedUserList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Container(
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF1F8EC),
                                    shape: OvalBorder(),
                                  ),
                                  width: 273,
                                  padding: EdgeInsets.symmetric(vertical: 36),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    'assets/empty_msg.svg',
                                    height: 97,
                                    width: 97,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'No Messages',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF81C14B),
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          color: AppColors.primaryColor,
                          onRefresh: () async {
                            context
                                .read<ChatRoomsCubit>()
                                .getLocalChatRoomData();
                          },
                          child: SingleChildScrollView(
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
                                                    name: filtedUserList[index]
                                                        .name,
                                                    imageUrl:
                                                        filtedUserList[index]
                                                            .imageUrl,
                                                    senderId:
                                                        filtedUserList[index]
                                                            .isOnline
                                                            .toString(),
                                                    hasStory:
                                                        filtedUserList[index]
                                                            .hasStory,
                                                    lastOnline: '',
                                                  ));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.white),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 7),
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
                                                                    filtedUserList[
                                                                            index]
                                                                        .name,
                                                                imageUrl:
                                                                    filtedUserList[
                                                                            index]
                                                                        .imageUrl,
                                                              ));
                                                    },
                                                    child: ChatProfileWidget(
                                                      imageUrl:
                                                          filtedUserList[index]
                                                              .imageUrl,
                                                      isOnline:
                                                          filtedUserList[index]
                                                              .isOnline
                                                              .toString(),
                                                      hasStory:
                                                          filtedUserList[index]
                                                              .hasStory,
                                                    ),
                                                  ),
                                                  SizedBox(width: 13),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          filtedUserList[index]
                                                              .name,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      SizedBox(height: 8),
                                                      Text(
                                                          filtedUserList[index]
                                                              .message,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: AppColors
                                                                  .grey)),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          filtedUserList[index]
                                                              .time,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: AppColors
                                                                  .grey)),
                                                      SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 5),
                                                          filtedUserList[index]
                                                                      .unseenMessage !=
                                                                  0
                                                              ? Container(
                                                                  height: 20,
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              3,
                                                                          horizontal:
                                                                              6),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      color: AppColors
                                                                          .primaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100)),
                                                                  child: Text(
                                                                      filtedUserList[
                                                                              index]
                                                                          .unseenMessage
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .white,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
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
                                              color: Color(0xFFE4E4E4)
                                                  .withOpacity(.5)),
                                                 
                                        ],
                                      );
                                    })
                                : Stack(
                                    children: [
                                      
                                      Column(
                                        children: [
                                          context
                                                  .watch<SyncSociomeeCubit>()
                                                  .state
                                                  .isSocimeeAcSynced
                                              ? DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.0),
                                                    border: const Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey,
                                                            width: 0.8)),
                                                  ),
                                                  child: TabBar(
                                                    indicatorWeight: 3,
                                                    indicatorColor:
                                                        AppColors.primaryColor,
                                                    labelColor:
                                                        AppColors.primaryColor,
                                                    unselectedLabelColor:
                                                        AppColors.grey,
                                                    controller: tabsComtroller,
                                                    tabs: [
                                                      Tab(
                                                        icon: Text(
                                                          'Social',
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                      Tab(
                                                        icon: Text(
                                                          'Biz Page',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      Tab(
                                                        icon: Text(
                                                          'Market',
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                      Tab(
                                                        icon: Text(
                                                          'Calls',
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.0),
                                                    border: const Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey,
                                                            width: 0.8)),
                                                  ),
                                                  child: TabBar(
                                                    indicatorWeight: 3,
                                                    indicatorColor:
                                                        AppColors.primaryColor,
                                                    labelColor:
                                                        AppColors.primaryColor,
                                                    unselectedLabelColor:
                                                        AppColors.grey,
                                                    controller: _controller,
                                                    tabs: [
                                                      Tab(
                                                        icon: Text(
                                                          'Social',
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                      Tab(
                                                        icon: Text(
                                                          'Calls',
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          context
                                                  .watch<SyncSociomeeCubit>()
                                                  .state
                                                  .isSocimeeAcSynced
                                              ? SizedBox(
                                                  height: 570.h,
                                                  child: TabBarView(
                                                      controller: context
                                                              .watch<
                                                                  SyncSociomeeCubit>()
                                                              .state
                                                              .isSocimeeAcSynced
                                                          ? tabsComtroller
                                                          : _controller,
                                                      children: [
                                                        SocialTabScreen(),
                                                        BizPageTab(),
                                                        MarketPageTab(),
                                                        CallTabScreen(),
                                                      ]),
                                                )
                                              : SizedBox(
                                                  height: 570.h,
                                                  child: TabBarView(
                                                      controller: context
                                                              .watch<
                                                                  SyncSociomeeCubit>()
                                                              .state
                                                              .isSocimeeAcSynced
                                                          ? tabsComtroller
                                                          : _controller,
                                                      children: [
                                                        SocialTabScreen(),
                                                        CallTabScreen(),
                                                      ]),
                                                )
                                        ],
                                      ),
                                      Positioned(
                                        top: 10,
                                        child: AnimatedContainer(
                                          height: context
                                              .watch<ShoweditbtnCubit>()
                                              .state
                                              .height,
                                          // ? 130
                                          // : 0,
                                          duration: Duration(milliseconds: 500),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: context
                                                    .watch<ShoweditbtnCubit>()
                                                    .state
                                                    .show
                                                ? [
                                                    BoxShadow(
                                                        color:
                                                            AppColors.lightgrey,
                                                        offset: Offset(0, 0.5),
                                                        blurRadius: 10,
                                                        spreadRadius: 5),
                                                  ]
                                                : null,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                //*story creating button
                                                GestureDetector(
                                                  onTap: () async {
                                                    try {
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              StoriesEditor(
                                                            giphyKey:
                                                                'C4dMA7Q19nqEGdpfj82T8ssbOeZIylD4',
                                                            galleryThumbnailQuality:
                                                                300,
                                                            onDone: (uri) {
                                                              debugPrint(uri);
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    } catch (e) {
                                                      log('error $e');
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 42,
                                                    width: 42,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: AppColors.black),
                                                    child: Image.asset(
                                                      'assets/camera1.png',
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    animatedScreenNavigator(
                                                        context, AudioRecord());
                                                  },
                                                  child: Container(
                                                    height: 42,
                                                    width: 42,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 19),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: AppColors
                                                            .primaryColor),
                                                    child: Image.asset(
                                                      'assets/edit1.png',
                                                    ),
                                                  ),
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
        ),
      ),
    );
  }
}
