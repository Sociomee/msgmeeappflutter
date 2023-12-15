import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/data/api_data_source/repositories.dart';
import 'package:msgmee/data/api_data_source/repository/auth/auth_repository.dart';
import 'package:msgmee/data/model/config_model.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/chatrooms/chatrooms_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/typing/cubit/typing_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/chat_screen.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/selectedchat/selectedchat_cubit.dart';
import 'package:msgmee/helper/context_ext.dart';

import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/helper/string_ext.dart';
import 'package:msgmee/repos/base_repo.dart';
import 'package:msgmee/theme/colors.dart';
import 'package:shimmer/shimmer.dart';
import '../../../cubit/chat_selection_cubit.dart';
import '../../../widgets/chat_profile_widget.dart';
import '../../../widgets/profile_image_view_dialog.dart';
import '../../group_chat_screen/group_chat_screen.dart';

class SocialchatWidget extends StatefulWidget {
  const SocialchatWidget({super.key});

  @override
  State<SocialchatWidget> createState() => _SocialchatWidgetState();
}

class _SocialchatWidgetState extends State<SocialchatWidget> {
  var avaterUrl =
      'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg';

  @override
  void initState() {
    super.initState();
    context.read<ChatRoomsCubit>().getLocalChatRoomData();
  }

  @override
  Widget build(BuildContext context) {
    var selectcubit = context.watch<SelectedchatCubit>().state;
    final cubit = context.watch<SelectionCubit>();
    var authorId = context.read<ChatRoomsCubit>().state.userId;
    return BlocConsumer<ChatRoomsCubit, ChatRoomsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == ChatRoomStatus.loaded) {
          const userId = "652e6674c78cfd56a9c848c0";
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.chatroom.length,
              itemBuilder: (context, index) {
                final isSelected = cubit.state.containsKey(index);

                var localpeopledata = state.chatroom[index].people!.where((e) {
                  return e.sId != authorId;
                }).toList();
                var online = state.onlineUsers.where((e) {
                  return e['id'] == localpeopledata.first.sId;
                }).toList();
                Iterable<String> userIds = localpeopledata.map((e) => e.sId.toString());
                return localpeopledata.isEmpty ? Container(child: Column(
                  children: [
                    Text("Nodata"),
                    Text(state.chatroom[index].people!.length.toString())
                  ],
                ),): Column(
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        cubit.toggleSelection(index);
                      },
                      onTap: cubit.state.isEmpty
                          ? () {
                            print(state.chatroom[index].sId);
                            
                            context.read<BaseRepo>().syncRoomsFromServer("",Config());
                           
                              state.chatroom[index].isGroup == 'true'
                                  ? animatedScreenNavigator(
                                      context,
                                      GroupChatScreen(
                                        name: localpeopledata.first.fullName!,
                                        imageUrl: localpeopledata
                                            .first.otherProfileImage
                                            .toString()
                                            .toProfileUrl(),
                                        isOnline:
                                            localpeopledata.first.lastOnline ==
                                                DateTime.now(),
                                      ))
                                  : animatedScreenNavigator(
                                      context,
                                      ChatScreen(
                                        name: localpeopledata.first.fullName ??
                                            '',
                                        imageUrl: localpeopledata
                                            .first.otherProfileImage
                                            .toString()
                                            .toProfileUrl(),
                                        senderId:
                                            localpeopledata.first.sId ?? '',
                                        lastOnline: localpeopledata
                                            .first.lastOnline
                                            .toString()
                                            .toLastOnlineTime(),
                                        id: state.chatroom[index].sId,
                                      ));

                              context
                                  .read<ChatRoomsCubit>()
                                  .getchatRoomMessages(
                                    id: state.chatroom[index].sId!,
                                  );
                              context
                                  .read<ChatRoomsCubit>()
                                  .getLocalDBMessagesById(
                                    state.chatroom[index].sId ?? '',
                                  );
                            }
                          : () {
                              cubit.toggleSelection(index);
                            },
                      child: Container(
                        decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.selectedChatColor
                                : AppColors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => ProfileViewDialog(
                                          profilename:
                                              localpeopledata.first.fullName!,
                                          imageUrl: localpeopledata
                                              .first.otherProfileImage
                                              .toString()
                                              .toProfileUrl(),
                                        ));
                              },
                              child: localpeopledata.first.otherProfileImage ==
                                      null
                                  ? DefaultProfileImage(
                                      isOnline: online.isNotEmpty
                                          ? online.first['status']
                                          : 'Offline',
                                      hasStory: true,
                                    )
                                  : ChatProfileWidget(
                                      imageUrl: localpeopledata
                                          .first.otherProfileImage
                                          .toString()
                                          .toProfileUrl(),
                                      isOnline: online.isNotEmpty
                                          ? online.first['status']
                                          : 'Offline',
                                      hasStory: true,
                                    ),
                            ),
                            SizedBox(width: 12),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: context.screenWidth * .65,
                                      child: Text(
                                          localpeopledata.first.fullName ??
                                              "No name",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    selectcubit.starClicked && isSelected
                                        ? Icon(Icons.star,
                                            color: AppColors.primaryColor,
                                            size: 16)
                                        : Container(),
                                    selectcubit.pinned && isSelected
                                        ? Transform.rotate(
                                            angle: pi / 4,
                                            child: Icon(Icons.push_pin,
                                                color: AppColors.primaryColor,
                                                size: 16),
                                          )
                                        : Container()
                                  ],
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: context.screenWidth * .6,
                                  child: BlocBuilder<TypingCubit, TypingState>(
                                    builder: (context, tstate) {
                                      if(tstate is TypingStartState){
                                        print("typing detected" + tstate.typingStatus.id.toString());
                                        return (userIds.contains(tstate.typingStatus.id) )? Text("typing...",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grey,
                                        ),
                                      ) : Text(
                                        "${localpeopledata.first.sId}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grey,
                                        ),
                                      );

                                      }else if (tstate is TypingEndState){
                                        return Text(
                                        "${state.chatroom[index].lastMessageId}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grey,
                                        ),
                                      );
                                      }else{
                                        return Text(
                                        "${state.chatroom[index].lastMessageId}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grey,
                                        ),
                                      );
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    state.chatroom[index].timestamp
                                        .toString()
                                        .formatToCustomDate(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12, color: AppColors.grey)),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    selectcubit.mute &&
                                            selectcubit.selectedchat
                                                .contains(index)
                                        ? SvgPicture.asset('assets/mute.svg')
                                        : Container(),
                                    SizedBox(width: 5),
                                    //!Do not delete
                                    // Container(
                                    //   height: 20,
                                    //   padding: EdgeInsets.symmetric(
                                    //       vertical: 3, horizontal: 6),
                                    //   alignment: Alignment.center,
                                    //   decoration: BoxDecoration(
                                    //       color: AppColors.primaryColor,
                                    //       borderRadius:
                                    //           BorderRadius.circular(100)),
                                    //   child: Text(
                                    //       dummyData[index]
                                    //           .unseenMessage
                                    //           .toString(),
                                    //       style: TextStyle(
                                    //           color: AppColors.white,
                                    //           fontSize: 12,
                                    //           fontWeight: FontWeight.bold)),
                                    // )
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
              });
        }
        return Shimmer.fromColors(
            baseColor: AppColors.borderColor,
            highlightColor: AppColors.grey,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14.0, left: 11),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 59,
                          width: 59,
                          decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        SizedBox(width: 12),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 10,
                              width: context.screenWidth * .4,
                              decoration: BoxDecoration(
                                  color: AppColors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 20,
                              width: context.screenWidth * .7,
                              decoration: BoxDecoration(
                                  color: AppColors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                        Container(
                          height: 10,
                          width: 30,
                          margin: EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                  );
                }));
      },
    );

    // return context.watch<MsgmeeUserListCubit>().state.status ==
    //         ChatHeadStatus.loading
    //     ? Shimmer.fromColors(
    //         baseColor: AppColors.borderColor,
    //         highlightColor: AppColors.grey,
    //         child: ListView.builder(
    //             physics: NeverScrollableScrollPhysics(),
    //             shrinkWrap: true,
    //             itemCount: 15,
    //             itemBuilder: (context, index) {
    //               return Padding(
    //                 padding: const EdgeInsets.only(bottom: 14.0, left: 11),
    //                 child: Row(
    //                   mainAxisSize: MainAxisSize.min,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                       height: 59,
    //                       width: 59,
    //                       decoration: BoxDecoration(
    //                           color: AppColors.grey,
    //                           borderRadius: BorderRadius.circular(100)),
    //                     ),
    //                     SizedBox(width: 12),
    //                     Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Container(
    //                           height: 10,
    //                           width: context.screenWidth * .4,
    //                           decoration: BoxDecoration(
    //                               color: AppColors.grey,
    //                               borderRadius: BorderRadius.circular(10)),
    //                         ),
    //                         SizedBox(height: 8),
    //                         Container(
    //                           height: 20,
    //                           width: context.screenWidth * .7,
    //                           decoration: BoxDecoration(
    //                               color: AppColors.grey,
    //                               borderRadius: BorderRadius.circular(10)),
    //                         ),
    //                       ],
    //                     ),
    //                     Container(
    //                       height: 10,
    //                       width: 30,
    //                       margin: EdgeInsets.only(bottom: 30),
    //                       decoration: BoxDecoration(
    //                           color: AppColors.grey,
    //                           borderRadius: BorderRadius.circular(10)),
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             }))
    //     : ListView.builder(
    //         physics: NeverScrollableScrollPhysics(),
    //         shrinkWrap: true,
    //         itemCount: userlist != null ? userlist.length : 0,
    //         itemBuilder: (context, index) {
    //           final isSelected = cubit.state.containsKey(index);
    //           // print(
    //           //     'image Urls ------>>${chathead.data!.chatHeads![index].displayPicture ?? avaterUrl}');
    //           return Column(
    //             children: [
    //               GestureDetector(
    //                 onLongPress: () {
    //                   cubit.toggleSelection(index);
    //                 },
    //                 onTap: cubit.state.isEmpty
    //                     ? () {
    //                         // userlist![index].chatRoomType ==
    //                         //         "DM"
    //                         //     ?
    //                         animatedScreenNavigator(
    //                             context,
    //                             ChatScreen(
    //                               name: userlist![index].fullName!,
    //                               imageUrl: userlist[index]
    //                                   .otherProfileImage!
    //                                   .toProfileUrl(),
    //                               // : avaterUrl,
    //                               isOnline: false,
    //                             ));
    //                         // : userlist![index]
    //                         //             . ==
    //                         //         ''
    //                         //     ? animatedScreenNavigator(
    //                         //         context,
    //                         //         GroupChatScreen(
    //                         //           name: chathead
    //                         //               .data!.chatHeads![index].name!,
    //                         //           imageUrl: chathead
    //                         //                   .data!
    //                         //                   .chatHeads![index]
    //                         //                   .displayPicture!
    //                         //                   .isNotEmpty
    //                         //               ? chathead.data!.chatHeads![index]
    //                         //                   .displayPicture!
    //                         //               : avaterUrl,
    //                         //           isOnline: chathead.data!
    //                         //                   .chatHeads![index].isOnline ??
    //                         //               false,
    //                         //         ))
    //                         //     : null;
    //                       }
    //                     : () {
    //                         cubit.toggleSelection(index);
    //                       },
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       color: isSelected
    //                           ? AppColors.selectedChatColor
    //                           : AppColors.white),
    //                   padding: const EdgeInsets.symmetric(
    //                       horizontal: 12, vertical: 7),
    //                   child: Row(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       InkWell(
    //                         onTap: () {
    //                           showDialog(
    //                               context: context,
    //                               builder: (context) => ProfileViewDialog(
    //                                     profilename: userlist[index].fullName!,
    //                                     imageUrl: userlist[index]
    //                                             .otherProfileImage!
    //                                             .isNotEmpty
    //                                         ? userlist[index].otherProfileImage!
    //                                         : avaterUrl,
    //                                   ));
    //                         },
    //                         child: ChatProfileWidget(
    //                             imageUrl:
    //                                 //  userlist![index]
    //                                 // .otherProfileImage!
    //                                 // .isNotEmpty
    //                                 // ?
    //                                 userlist![index]
    //                                     .otherProfileImage!
    //                                     .toProfileUrl(), // : avaterUrl,
    //                             isOnline: false,
    //                             // chathead.data!.chatHeads![index].isOnline!,
    //                             hasStory: false),
    //                       ),
    //                       SizedBox(width: 12),
    //                       Column(
    //                         mainAxisSize: MainAxisSize.min,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Row(
    //                             children: [
    //                               Text(userlist[index].fullName!,
    //                                   style: TextStyle(
    //                                     fontSize: 16,
    //                                     fontFamily: 'Poppins',
    //                                     fontWeight: FontWeight.w600,
    //                                   )),
    //                               selectcubit.starClicked && isSelected
    //                                   ? Icon(Icons.star,
    //                                       color: AppColors.primaryColor,
    //                                       size: 16)
    //                                   : Container(),
    //                               selectcubit.pinned && isSelected
    //                                   ? Transform.rotate(
    //                                       angle: pi / 4,
    //                                       child: Icon(Icons.push_pin,
    //                                           color: AppColors.primaryColor,
    //                                           size: 16),
    //                                     )
    //                                   : Container()
    //                             ],
    //                           ),
    //                           SizedBox(height: 8),
    //                           Text('last message',
    //                               style: TextStyle(
    //                                   fontSize: 13, color: AppColors.grey))
    //                           // chathead.data!.chatHeads![index].latestMessage !=
    //                           //         null
    //                           //     ? Text(
    //                           //         chathead.data!.chatHeads![index]
    //                           //             .latestMessage!,
    //                           //         style: TextStyle(
    //                           //             fontSize: 13, color: AppColors.grey))
    //                           //     : Container(),
    //                         ],
    //                       ),
    //                       Spacer(),
    //                       Column(
    //                         mainAxisSize: MainAxisSize.min,
    //                         crossAxisAlignment: CrossAxisAlignment.end,
    //                         children: [
    //                           Text('now',
    //                               style: TextStyle(
    //                                   fontSize: 13, color: AppColors.grey)),
    //                           // if (chathead.data!.chatHeads![index]
    //                           //         .latestMessageAt !=
    //                           //     null)
    //                           //   Text(
    //                           //       getTime(chathead.data!.chatHeads![index]
    //                           //           .latestMessageAt!),
    //                           //       style: TextStyle(
    //                           //           fontSize: 13, color: AppColors.grey)),
    //                           SizedBox(height: 8),
    //                           Row(
    //                             children: [
    //                               selectcubit.mute &&
    //                                       selectcubit.selectedchat
    //                                           .contains(index)
    //                                   ? SvgPicture.asset('assets/mute.svg')
    //                                   : Container(),
    //                               SizedBox(width: 5),
    //                               // chathead.data!.chatHeads![index]
    //                               //             .unreadMessageCount !=
    //                               //         0
    //                               //     ?
    //                               Container(
    //                                 height: 20,
    //                                 padding: EdgeInsets.symmetric(
    //                                     vertical: 3, horizontal: 6),
    //                                 alignment: Alignment.center,
    //                                 decoration: BoxDecoration(
    //                                     color: AppColors.primaryColor,
    //                                     borderRadius:
    //                                         BorderRadius.circular(100)),
    //                                 child: Text('1',
    //                                     // chathead.data!.chatHeads![index]
    //                                     //     .unreadMessageCount
    //                                     //     .toString(),
    //                                     style: TextStyle(
    //                                         color: AppColors.white,
    //                                         fontSize: 12,
    //                                         fontWeight: FontWeight.bold)),
    //                               )
    //                               // : Container(),
    //                             ],
    //                           )
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Divider(
    //                   height: 0,
    //                   thickness: 1,
    //                   color: Color(0xFFE4E4E4).withOpacity(.5)),
    //             ],
    //           );
    //         });
  }
}
