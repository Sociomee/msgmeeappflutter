import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/data/model/user_model.dart';
import 'package:msgmee/data/newmodels/contact_model.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/chatrooms/chatrooms_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/msgmee_user_list/msgmee_user_list_cubit.dart';
import 'package:msgmee/helper/context_ext.dart';
import 'package:msgmee/helper/list_ext.dart';
import 'package:msgmee/helper/string_ext.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/model/phonebook_model.dart';
import '../../../../data/sqlite_data_source/sqlite_helper.dart';
import '../../../../helper/connectivity_service.dart';
import '../../../../helper/navigator_function.dart';
import '../../../../theme/colors.dart';
import '../cubit/get_contact/get_contact_cubit.dart';
import '../widgets/chat_profile_widget.dart';
import '../widgets/invite_friends_list.dart';
import '../widgets/social_bottom_model_sheet.dart';
import 'chat_screen/chat_screen.dart';

List<ChatOptionsModel> options = [
  ChatOptionsModel(id: 1, option: 'All Contacts'),
  ChatOptionsModel(id: 2, option: 'MsgMee Contacts'),
  ChatOptionsModel(id: 3, option: 'SocioMee Users'),
];

List<String> alphabats = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  late TextEditingController searchController;
  late ContactCubit _contact;
  List<MsgMeeContacts> filterdList = [];
  String? name;
  String? imageUrl;
  List<PhoneBookUserModel> filterdContactList = [];
  bool show = false;
  int currentindex = 0;
  double top = 17;
  bool navigate = false;
  @override
  void initState() {
    _contact = context.read<ContactCubit>();
    //print('contacts-->${_contact.state.phonebookUser}');
    context.read<MsgmeeUserListCubit>().getdataLoaclData();
    _contact.getDatabaseData();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MsgmeeUserListCubit, MsgmeeUserListState>(
      listener: (context, state) {
        if (state.status == MsgmeeUserListStatus.loaded) {
          filterdList = List.from(state.contactModel.msgMeeContacts!);
          filterdContactList = List.from(_contact.state.phonebookUser);
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: ()async {
              final SQLiteHelper sqlite = SQLiteHelper();
                       const rpPeopleSql = '''
                        SELECT * FROM allconnections''';
        print("Element id ");
        var newdata = await sqlite.database.rawQuery(rpPeopleSql);
                      print(
                          "====================================================================================>");
                   print(newdata);
                      print(
                          "<====================================================================================");
          }),
          appBar: AppBar(
            elevation: 1,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.black,
                    size: 20,
                  ),
                )),
            centerTitle: false,
            leadingWidth: 30.w,
            
            titleSpacing: 15.w,
            title: Text(
              'New message',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Scrollbar(
            thickness: 5,
            radius: Radius.circular(20),
            child: RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () async {
                context
                    .read<ContactCubit>()
                    .fetchContacts(context.read<MsgmeeUserListCubit>());
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 30, right: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 17.h,
                            width: 15.w,
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/Search.svg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: TextFormField(
                              controller: searchController,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    // context
                                    //     .read<ContactCubit>()
                                    //     .getOverRidedContacts(
                                    //         state.msgmeeUserList.users!);
                                    filterdList =
                                        List.from(state.contactModel.msgMeeContacts!);
                                    filterdContactList =
                                        List.from(_contact.state.phonebookUser);
                                  } else {
                                    filterdList = state.contactModel.msgMeeContacts!
                                        .where((model) {
                                      bool hasphone =
                                          model.phone!.toLowerCase().contains(
                                                value.toLowerCase(),
                                              );
                                      bool hasname = model.contactName!
                                          .toLowerCase()
                                          .contains(
                                            value.toLowerCase(),
                                          );
                                      return hasname || hasphone;
                                    }).toList();
                                    filterdContactList = context
                                        .read<ContactCubit>()
                                        .state
                                        .phonebookUser
                                        .where((e) {
                                      bool hasphone =
                                          e.phone.toLowerCase().contains(
                                                value.toLowerCase(),
                                              );
                                      bool hasname =
                                          e.name.toLowerCase().contains(
                                                value.toLowerCase(),
                                              );
                                      return hasname || hasphone;
                                    }).toList();
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: 'Search......',
                                  hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Niramit',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                            ),
                          ),
                          PopupMenuButton(
                            icon: SvgPicture.asset('assets/filter.svg'),
                            offset: Offset(-20, 35),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            color: Colors.white,
                            itemBuilder: (context) {
                              return options
                                  .map(
                                    (e) => PopupMenuItem(
                                        value: e.id,
                                        child: Text(
                                          e.option,
                                          style: TextStyle(
                                            color: Color(0xFF4E4E4E),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                  )
                                  .toList();
                            },
                            onSelected: (value) {
                              if (value == 1) {
                                setState(() {
                                  filterdList =
                                      List.from(state.contactModel.msgMeeContacts!);
                                });
                              } else if (value == 2) {
                                setState(() {
                                  filterdList = state.contactModel.msgMeeContacts!
                                      .where((model) => model.linkedTo!
                                          .toLowerCase()
                                          .contains('msgmee'.toLowerCase()))
                                      .toList();
                                });
                              } else if (value == 3) {
                                setState(() {
                                  filterdList = state.contactModel.msgMeeContacts!
                                      .where((model) => model.linkedTo!
                                          .toLowerCase()
                                          .contains('SocioMee'.toLowerCase()))
                                      .toList();
                                });
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Divider(height: 0, color: AppColors.grey),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('All Connections',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          //*showing msgmee contacts in listview
                          context.watch<MsgmeeUserListCubit>().state.status ==
                                  MsgmeeUserListStatus.loading
                              ? Shimmer.fromColors(
                                  baseColor: AppColors.borderColor,
                                  highlightColor: AppColors.grey,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 14.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: AppColors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                            ),
                                            SizedBox(width: 12),
                                            Container(
                                                height: 20,
                                                width: context.screenWidth * .7,
                                                decoration: BoxDecoration(
                                                    color: AppColors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)))
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: filterdList.customSort().length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async{
                                       bool isConnected = await ConnectivityService().checkConnection();
                                       if(!isConnected){
                                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Internet not enabled. Please enable to start new chat')));
                                        return;
                                       }
                                        log('create room initialize..');
                                        BotToast.showLoading();
                                      await context
                                            .read<ChatRoomsCubit>()
                                            .createchatRoom(
                                              userid: filterdList[index].sId!,
                                            )
                                            .then((value) {
                                              var createdRoomId = context
                                                    .read<ChatRoomsCubit>()
                                                    .state
                                                    .createroom
                                                    .sId;
                                             if(createdRoomId == "" || createdRoomId == null){
                                              BotToast.closeAllLoading();
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Unable to initiate chat , please check your internet connection and try again.')));
                                                    return;
                                                    }
                                                    
                                          animatedScreenNavigator(
                                              context,
                                              ChatScreen(
                                                name: filterdList[index]
                                                        .contactName ??
                                                    '',
                                                  userId: "sss" ??
                                                    '',
                                                imageUrl: filterdList[index]
                                                    .otherProfileImage
                                                    .toString()
                                                    .toProfileUrl(),
                                                senderId: '',
                                                lastOnline: '',
                                                id: context
                                                    .read<ChatRoomsCubit>()
                                                    .state
                                                    .createroom
                                                    .sId,
                                              ));
                                          BotToast.closeAllLoading();
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 14.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            filterdList[index]
                                                        .otherProfileImage ==
                                                    null
                                                ? Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .lightgrey,
                                                          width: 1),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: Image.asset(
                                                        'assets/profile_icon.png',
                                                      ),
                                                    ),
                                                  )
                                                : ChatProfileWidget(
                                                    imageUrl: filterdList[index]
                                                        .otherProfileImage
                                                        .toString()
                                                        .toProfileUrl(),
                                                    isOnline: 'false',
                                                    hasStory: false,
                                                    radius: 20,
                                                  ),
                                            SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      context.screenWidth * .65,
                                                  child: Text(
                                                      filterdList[index].contactName.toString(),
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                      )),
                                                ),
                                                Text(
                                                    filterdList[index]
                                                            .username ??
                                                        '',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ))
                                              ],
                                            ),
                                            Spacer(),
                                            if (filterdList[index].linkedTo !=
                                                    null &&
                                                filterdList[index]
                                                        .linkedTo!
                                                        .toLowerCase() ==
                                                    'msgmee')
                                              SvgPicture.asset(
                                                'assets/msgmee.svg',
                                              ),
                                            if (filterdList[index].linkedTo !=
                                                    null &&
                                                filterdList[index]
                                                        .linkedTo!
                                                        .toLowerCase() ==
                                                    'sociomee')
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: SvgPicture.asset(
                                                  'assets/sociomee.svg',
                                                ),
                                              ),
                                            if (filterdList[index].linkedTo !=
                                                    null &&
                                                filterdList[index]
                                                        .linkedTo!
                                                        .toLowerCase() ==
                                                    'both')
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/msgmee.svg',
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 5,
                                                    ),
                                                    child: SvgPicture.asset(
                                                      'assets/sociomee.svg',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),

                          // Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Expanded(
                          //       flex: 110,
                          //       child: context
                          //                   .watch<MsgmeeUserListCubit>()
                          //                   .state
                          //                   .status ==
                          //               MsgmeeUserListStatus.loading
                          //           ? Shimmer.fromColors(
                          //               baseColor: AppColors.borderColor,
                          //               highlightColor: AppColors.grey,
                          //               child: ListView.builder(
                          //                 physics:
                          //                     NeverScrollableScrollPhysics(),
                          //                 shrinkWrap: true,
                          //                 itemCount: 5,
                          //                 itemBuilder: (context, index) {
                          //                   return Padding(
                          //                     padding: const EdgeInsets.only(
                          //                         bottom: 14.0),
                          //                     child: Row(
                          //                       mainAxisSize: MainAxisSize.min,
                          //                       children: [
                          //                         Container(
                          //                           height: 40,
                          //                           width: 40,
                          //                           decoration: BoxDecoration(
                          //                               color: AppColors.grey,
                          //                               borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(100)),
                          //                         ),
                          //                         SizedBox(width: 12),
                          //                         Container(
                          //                           height: 20,
                          //                           width: context.screenWidth *
                          //                               .7,
                          //                           decoration: BoxDecoration(
                          //                             color: AppColors.grey,
                          //                             borderRadius:
                          //                                 BorderRadius.circular(
                          //                               10,
                          //                             ),
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   );
                          //                 },
                          //               ),
                          //             )
                          //           : ListView.builder(
                          //               physics: NeverScrollableScrollPhysics(),
                          //               shrinkWrap: true,
                          //               itemCount:
                          //                   filterdList.customSort().length,
                          //               itemBuilder: (context, index) {
                          //                 return GestureDetector(
                          //                   onTap: () {
                          //                     log('create room initialize..');
                          //                     BotToast.showLoading();
                          //                     context
                          //                         .read<ChatRoomsCubit>()
                          //                         .createchatRoom(
                          //                           userid:
                          //                               filterdList[index].sId!,
                          //                         )
                          //                         .then((value) {
                          //                       animatedScreenNavigator(
                          //                           context,
                          //                           ChatScreen(
                          //                             name: filterdList[index]
                          //                                     .fullName ??
                          //                                 '',
                          //                             imageUrl:
                          //                                 filterdList[index]
                          //                                     .otherProfileImage
                          //                                     .toString()
                          //                                     .toProfileUrl(),
                          //                             senderId: '',
                          //                             lastOnline: '',
                          //                             id: context
                          //                                 .read<
                          //                                     ChatRoomsCubit>()
                          //                                 .state
                          //                                 .createroom
                          //                                 .room!
                          //                                 .sId,
                          //                           ));
                          //                       BotToast.closeAllLoading();
                          //                     });
                          //                   },
                          //                   child: Padding(
                          //                     padding: const EdgeInsets.only(
                          //                       bottom: 14.0,
                          //                     ),
                          //                     child: Row(
                          //                       crossAxisAlignment:
                          //                           CrossAxisAlignment.center,
                          //                       children: [
                          //                         filterdList[index]
                          //                                     .otherProfileImage ==
                          //                                 null
                          //                             ? Container(
                          //                                 height: 50,
                          //                                 width: 50,
                          //                                 decoration:
                          //                                     BoxDecoration(
                          //                                   borderRadius:
                          //                                       BorderRadius
                          //                                           .circular(
                          //                                               100),
                          //                                   border: Border.all(
                          //                                       color: AppColors
                          //                                           .lightgrey,
                          //                                       width: 1),
                          //                                 ),
                          //                                 child: ClipRRect(
                          //                                   borderRadius:
                          //                                       BorderRadius
                          //                                           .circular(
                          //                                               100),
                          //                                   child: Image.asset(
                          //                                     'assets/profile_icon.png',
                          //                                   ),
                          //                                 ),
                          //                               )
                          //                             : ChatProfileWidget(
                          //                                 imageUrl: filterdList[
                          //                                         index]
                          //                                     .otherProfileImage
                          //                                     .toString()
                          //                                     .toProfileUrl(),
                          //                                 isOnline: 'false',
                          //                                 hasStory: false,
                          //                                 radius: 20,
                          //                               ),
                          //                         SizedBox(width: 12),
                          //                         Column(
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment
                          //                                   .start,
                          //                           children: [
                          //                             SizedBox(
                          //                               width: context
                          //                                       .screenWidth *
                          //                                   .6,
                          //                               child: Text(
                          //                                   filterdList[index]
                          //                                       .fullName!,
                          //                                   style: TextStyle(
                          //                                     fontSize: 14.sp,
                          //                                   )),
                          //                             ),
                          //                             Text(
                          //                                 filterdList[index]
                          //                                         .username ??
                          //                                     '',
                          //                                 style: TextStyle(
                          //                                   fontSize: 10,
                          //                                 ))
                          //                           ],
                          //                         ),
                          //                         Spacer(),
                          //                         if (filterdList[index]
                          //                                     .linkedTo !=
                          //                                 null &&
                          //                             filterdList[index]
                          //                                     .linkedTo!
                          //                                     .toLowerCase() ==
                          //                                 'msgmee')
                          //                           SvgPicture.asset(
                          //                             'assets/msgmee.svg',
                          //                           ),
                          //                         if (filterdList[index]
                          //                                     .linkedTo !=
                          //                                 null &&
                          //                             filterdList[index]
                          //                                     .linkedTo!
                          //                                     .toLowerCase() ==
                          //                                 'sociomee')
                          //                           Padding(
                          //                             padding:
                          //                                 const EdgeInsets.only(
                          //                                     left: 5),
                          //                             child: SvgPicture.asset(
                          //                               'assets/sociomee.svg',
                          //                             ),
                          //                           ),
                          //                         if (filterdList[index]
                          //                                     .linkedTo !=
                          //                                 null &&
                          //                             filterdList[index]
                          //                                     .linkedTo!
                          //                                     .toLowerCase() ==
                          //                                 'both')
                          //                           Row(
                          //                             mainAxisSize:
                          //                                 MainAxisSize.min,
                          //                             children: [
                          //                               SvgPicture.asset(
                          //                                 'assets/msgmee.svg',
                          //                               ),
                          //                               Padding(
                          //                                 padding:
                          //                                     const EdgeInsets
                          //                                         .only(
                          //                                   left: 5,
                          //                                 ),
                          //                                 child:
                          //                                     SvgPicture.asset(
                          //                                   'assets/sociomee.svg',
                          //                                 ),
                          //                               ),
                          //                             ],
                          //                           ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 );
                          //               }),
                          //     ),
                          //     SizedBox(width: 10),
                          //     Expanded(
                          //         flex: 5,
                          //         child: ListView.separated(
                          //           padding: EdgeInsets.all(0),
                          //           shrinkWrap: true,
                          //           itemBuilder: (context, index) {
                          //             final letter = String.fromCharCode(
                          //                 'A'.codeUnitAt(0) + index);
                          //             return GestureDetector(
                          //               onTap: () {
                          //                 setState(() {
                          //                   currentindex = index;
                          //                   show = !show;
                          //                   filterdList = state
                          //                       .msgmeeUserList.users!
                          //                       .where((model) => model
                          //                           .firstName![0]
                          //                           .toLowerCase()
                          //                           .contains(
                          //                               alphabats[currentindex]
                          //                                   .toLowerCase()))
                          //                       .toList();
                          //                 });
                          //                 Timer(Duration(milliseconds: 500),
                          //                     () {
                          //                   setState(() {
                          //                     show = false;
                          //                   });
                          //                 });
                          //                 print(alphabats[index]);
                          //               },
                          //               child: Container(
                          //                 // height: 3,
                          //                 // width: 3,
                          //                 padding: EdgeInsets.all(2),
                          //                 decoration: BoxDecoration(
                          //                   color:
                          //                       // alphabats[index] == letter
                          //                       // ?
                          //                       // AppColors.darkbtnColor
                          //                       // :
                          //                       Colors.transparent,
                          //                   borderRadius:
                          //                       BorderRadius.circular(100),
                          //                   // color: AppColors.darkbtnColor,
                          //                 ),
                          //                 alignment: Alignment.center,
                          //                 child: Text(
                          //                   letter,
                          //                   style: TextStyle(
                          //                       color: AppColors.black,
                          //                       fontSize: 12),
                          //                 ),
                          //               ),
                          //             );
                          //           },
                          //           separatorBuilder: (context, index) {
                          //             return SizedBox(height: 3);
                          //           },
                          //           itemCount: 26,
                          //         )),
                          //   ],
                          // ),

                          SizedBox(height: 30),
                          Text('Invite Contact',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),

                          SizedBox(height: 24),
                          InviteFriendsList(
                            contacts: filterdContactList,
                            msgMeeUsers: filterdList.map((e) => e.phone.toString()).toList(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AlphabaticalFilterScreen extends StatefulWidget {
  const AlphabaticalFilterScreen({super.key});

  @override
  State<AlphabaticalFilterScreen> createState() =>
      _AlphabaticalFilterScreenState();
}

class _AlphabaticalFilterScreenState extends State<AlphabaticalFilterScreen> {
  String selectedLetter = "";
  List<String> filteredItems = [];

  // @override
  // void initState() {
  //   super.initState();
  //   filteredItems = itemList; // Initialize with all items.
  // }

  // void filterItemsByLetter(String letter) {
  //   setState(() {
  //     selectedLetter = letter;
  //     filteredItems =
  //         itemList.where((item) => item.startsWith(letter)).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400, // Adjust the height as needed
          child: ListView.builder(
            itemCount: 26,
            itemBuilder: (context, index) {
              final letter = String.fromCharCode('A'.codeUnitAt(0) + index);
              return GestureDetector(
                onTap: () {
                  // filterItemsByLetter(letter);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  color: selectedLetter == letter
                      ? Colors.blue // Highlight selected letter
                      : Colors.transparent,
                  child: Text(letter),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
