import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/msgmee_user_list/msgmee_user_list_cubit.dart';
import 'package:msgmee/helper/context_ext.dart';
import 'package:msgmee/helper/string_ext.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/model/phonebook_model.dart';
import '../../../../helper/navigator_function.dart';
import '../../../../theme/colors.dart';
import '../cubit/get_contact/get_contact_cubit.dart';
import '../widgets/chat_profile_widget.dart';
import '../widgets/contact_filtering_design.dart';
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
  List<User> filterdList = [];
  List<PhoneBookUserModel> filterdContactList = [];
  bool show = false;
  int currentindex = 0;
  double top = 17;
  @override
  void initState() {
    _contact = context.read<ContactCubit>();
    log('contacts-->${_contact.state.phonebookUser}');
    context
        .read<MsgmeeUserListCubit>()
        .getMsgmeeUsersList(_contact.state.phonebookUser);
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
          context
              .read<ContactCubit>()
              .getOverRidedContacts(state.msgmeeUserList.users!);
          filterdList = List.from(state.msgmeeUserList.users!);
          filterdContactList = List.from(_contact.state.phonebookUser);
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                                  context
                                      .read<ContactCubit>()
                                      .getOverRidedContacts(
                                          state.msgmeeUserList.users!);
                                  filterdList =
                                      List.from(state.msgmeeUserList.users!);
                                  filterdContactList = List.from(context
                                      .read<ContactCubit>()
                                      .state
                                      .phonebookUser);
                                } else {
                                  filterdList = state.msgmeeUserList.users!
                                      .where((model) => model.fullName!
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                  filterdContactList = context
                                      .read<ContactCubit>()
                                      .state
                                      .phonebookUser
                                      .where((e) => e.name
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
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
                                    List.from(state.msgmeeUserList.users!);
                              });
                            } else if (value == 2) {
                              setState(() {
                                filterdList = state.msgmeeUserList.users!
                                    .where((model) => model.linkedTo!
                                        .toLowerCase()
                                        .contains('msgmee'.toLowerCase()))
                                    .toList();
                              });
                            } else if (value == 3) {
                              setState(() {
                                filterdList = state.msgmeeUserList.users!
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
                        horizontal: 23, vertical: 10),
                    child: Stack(
                      children: [
                        Column(
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
                                            padding: const EdgeInsets.only(
                                                bottom: 14.0),
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
                                                    width: context.screenWidth *
                                                        .7,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)))
                                              ],
                                            ),
                                          );
                                        }))
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    itemCount: filterdList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          screenNavigator(
                                              context,
                                              ChatScreen(
                                                name: filterdList[index]
                                                    .fullName!,
                                                imageUrl: filterdList[index]
                                                    .otherProfileImage
                                                    .toString()
                                                    .toProfileUrl(),
                                                isOnline: true,
                                                hasStory: true,
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 14.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ChatProfileWidget(
                                                imageUrl: filterdList[index]
                                                    .otherProfileImage
                                                    .toString()
                                                    .toProfileUrl(),
                                                isOnline: false,
                                                hasStory: false,
                                                radius: 20,
                                              ),
                                              SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      filterdList[index]
                                                          .fullName!,
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                      )),
                                                  Text(
                                                      filterdList[index]
                                                          .username!,
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                      ))
                                                ],
                                              ),
                                              Spacer(),
                                              if (filterdList[index]
                                                      .linkedTo!
                                                      .toLowerCase() ==
                                                  'msgmee')
                                                SvgPicture.asset(
                                                  'assets/msgmee.svg',
                                                ),
                                              if (filterdList[index]
                                                      .linkedTo!
                                                      .toLowerCase() ==
                                                  'sociomee')
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: SvgPicture.asset(
                                                    'assets/sociomee.svg',
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),

                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     Expanded(
                            //         flex: 110,
                            //         child: AllconnectionsWidget(
                            //             list: filterdList)),
                            //     SizedBox(width: 10),
                            //     Expanded(
                            //         flex: 1,
                            //         child: ListView.separated(
                            //           padding: EdgeInsets.all(0),
                            //           shrinkWrap: true,
                            //           itemBuilder: (context, index) {
                            //             return GestureDetector(
                            //               onTap: () {
                            //                 setState(() {
                            //                   currentindex = index;
                            //                   show = !show;
                            //                 });
                            //                 print(alphabats[index]);
                            //               },
                            //               child: Container(
                            //                 height: 3,
                            //                 width: 3,
                            //                 decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(100),
                            //                     color: AppColors.darkbtnColor),
                            //               ),
                            //             );
                            //           },
                            //           separatorBuilder: (context, index) {
                            //             return SizedBox(height: 23.h);
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
                            )
                          ],
                        ),
                        show
                            ? Positioned(
                                top: top,
                                right: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      show = !show;
                                      filterdList = state.msgmeeUserList.users!
                                          .where((model) => model.firstName![0]
                                              .toLowerCase()
                                              .contains(alphabats[currentindex]
                                                  .toLowerCase()))
                                          .toList();
                                    });
                                  },
                                  child: ContactFilteringDesign(
                                      text: alphabats[currentindex]),
                                ))
                            : Container()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AlphabaticalFilterScreen extends StatelessWidget {
  const AlphabaticalFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
