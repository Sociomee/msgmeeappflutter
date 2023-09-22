import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/data/model/dummy_chat_model.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/chat_screen.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/group_chat_screen/group_chat_screen.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/selectedchat/selectedchat_cubit.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/theme/colors.dart';
import '../../../cubit/chat_selection_cubit.dart';
import '../../../widgets/chat_profile_widget.dart';
import '../../../widgets/profile_image_view_dialog.dart';

class SocialchatWidget extends StatefulWidget {
  const SocialchatWidget({super.key});

  @override
  State<SocialchatWidget> createState() => _SocialchatWidgetState();
}

class _SocialchatWidgetState extends State<SocialchatWidget> {
  var avaterUrl =
      'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg';

  @override
  Widget build(BuildContext context) {
    var selectcubit = context.watch<SelectedchatCubit>().state;
    final cubit = context.watch<SelectionCubit>();
    // var chathead = context.watch<ChatHeadCubit>().state.chatheads;

    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          final isSelected = cubit.state.containsKey(index);
          // print(
          // 'image Urls ------>>${chathead.data!.chatHeads![index].displayPicture ?? avaterUrl}');
          return Column(
            children: [
              GestureDetector(
                onLongPress: () {
                  cubit.toggleSelection(index);
                },
                onTap: cubit.state.isEmpty
                    ? () {
                        dummyData[index].name == 'Office Group'
                            ? animatedScreenNavigator(
                                context,
                                GroupChatScreen(
                                  name: dummyData[index].name,
                                  imageUrl: dummyData[index].imageUrl,
                                  isOnline: dummyData[index].isOnline,
                                ))
                            : animatedScreenNavigator(
                                context,
                                ChatScreen(
                                  name: dummyData[index].name,
                                  imageUrl: dummyData[index].imageUrl,
                                  isOnline: dummyData[index].isOnline,
                                ));
                      }
                    : () {
                        cubit.toggleSelection(index);
                      },
                child: Container(
                  decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.selectedChatColor
                          : AppColors.white),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => ProfileViewDialog(
                                    profilename: dummyData[index].name,
                                    imageUrl: dummyData[index].imageUrl,
                                  ));
                        },
                        child: ChatProfileWidget(
                          imageUrl: dummyData[index].imageUrl,
                          isOnline: dummyData[index].isOnline,
                          // chathead.data!.chatHeads![index].isOnline!,
                          hasStory: dummyData[index].hasStory,
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(dummyData[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  )),
                              selectcubit.starClicked && isSelected
                                  ? Icon(Icons.star,
                                      color: AppColors.primaryColor, size: 16)
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
                          Text(dummyData[index].message,
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.grey))
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(dummyData[index].time,
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.grey)),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              selectcubit.mute &&
                                      selectcubit.selectedchat.contains(index)
                                  ? SvgPicture.asset('assets/mute.svg')
                                  : Container(),
                              SizedBox(width: 5),
                              dummyData[index].unseenMessage != 0
                                  ? Container(
                                      height: 20,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 6),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Text(
                                          dummyData[index]
                                              .unseenMessage
                                              .toString(),
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
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
        });

    // return context.watch<ChatHeadCubit>().state.status == ChatHeadStatus.loading
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
    //         itemCount:
    //             chathead.data != null ? chathead.data!.chatHeads!.length : 0,
    //         itemBuilder: (context, index) {
    //           final isSelected = cubit.state.containsKey(index);
    //           print(
    //               'image Urls ------>>${chathead.data!.chatHeads![index].displayPicture ?? avaterUrl}');
    //           return Column(
    //             children: [
    //               GestureDetector(
    //                 onLongPress: () {
    //                   cubit.toggleSelection(index);
    //                 },
    //                 onTap: cubit.state.isEmpty
    //                     ? () {
    //                         chathead.data!.chatHeads![index].chatRoomType ==
    //                                 "DM"
    //                             ? animatedScreenNavigator(
    //                                 context,
    //                                 ChatScreen(
    //                                   name: chathead
    //                                       .data!.chatHeads![index].name!,
    //                                   imageUrl: chathead.data!.chatHeads![index]
    //                                           .displayPicture!.isNotEmpty
    //                                       ? chathead.data!.chatHeads![index]
    //                                           .displayPicture!
    //                                       : avaterUrl,
    //                                   isOnline: chathead.data!.chatHeads![index]
    //                                           .isOnline ??
    //                                       false,
    //                                 ))
    //                             : chathead.data!.chatHeads![index]
    //                                         .chatRoomType ==
    //                                     ''
    //                                 ? animatedScreenNavigator(
    //                                     context,
    //                                     GroupChatScreen(
    //                                       name: chathead
    //                                           .data!.chatHeads![index].name!,
    //                                       imageUrl: chathead
    //                                               .data!
    //                                               .chatHeads![index]
    //                                               .displayPicture!
    //                                               .isNotEmpty
    //                                           ? chathead.data!.chatHeads![index]
    //                                               .displayPicture!
    //                                           : avaterUrl,
    //                                       isOnline: chathead.data!
    //                                               .chatHeads![index].isOnline ??
    //                                           false,
    //                                     ))
    //                                 : null;
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
    //                                     profilename: chathead
    //                                         .data!.chatHeads![index].name!,
    //                                     imageUrl: chathead
    //                                             .data!
    //                                             .chatHeads![index]
    //                                             .displayPicture!
    //                                             .isNotEmpty
    //                                         ? chathead.data!.chatHeads![index]
    //                                             .displayPicture!
    //                                         : avaterUrl,
    //                                   ));
    //                         },
    //                         child: ChatProfileWidget(
    //                             imageUrl: chathead.data!.chatHeads![index]
    //                                     .displayPicture!.isNotEmpty
    //                                 ? chathead
    //                                     .data!.chatHeads![index].displayPicture!
    //                                 : avaterUrl,
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
    //                               Text(chathead.data!.chatHeads![index].name!,
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
    //                           chathead.data!.chatHeads![index].latestMessage !=
    //                                   null
    //                               ? Text(
    //                                   chathead.data!.chatHeads![index]
    //                                       .latestMessage!,
    //                                   style: TextStyle(
    //                                       fontSize: 13, color: AppColors.grey))
    //                               : Container(),
    //                         ],
    //                       ),
    //                       Spacer(),
    //                       Column(
    //                         mainAxisSize: MainAxisSize.min,
    //                         crossAxisAlignment: CrossAxisAlignment.end,
    //                         children: [
    //                           if (chathead.data!.chatHeads![index]
    //                                   .latestMessageAt !=
    //                               null)
    //                             Text(
    //                                 getTime(chathead.data!.chatHeads![index]
    //                                     .latestMessageAt!),
    //                                 style: TextStyle(
    //                                     fontSize: 13, color: AppColors.grey)),
    //                           SizedBox(height: 8),
    //                           Row(
    //                             children: [
    //                               selectcubit.mute &&
    //                                       selectcubit.selectedchat
    //                                           .contains(index)
    //                                   ? SvgPicture.asset('assets/mute.svg')
    //                                   : Container(),
    //                               SizedBox(width: 5),
    //                               chathead.data!.chatHeads![index]
    //                                           .unreadMessageCount !=
    //                                       0
    //                                   ? Container(
    //                                       height: 20,
    //                                       padding: EdgeInsets.symmetric(
    //                                           vertical: 3, horizontal: 6),
    //                                       alignment: Alignment.center,
    //                                       decoration: BoxDecoration(
    //                                           color: AppColors.primaryColor,
    //                                           borderRadius:
    //                                               BorderRadius.circular(100)),
    //                                       child: Text(
    //                                           chathead.data!.chatHeads![index]
    //                                               .unreadMessageCount
    //                                               .toString(),
    //                                           style: TextStyle(
    //                                               color: AppColors.white,
    //                                               fontSize: 12,
    //                                               fontWeight: FontWeight.bold)),
    //                                     )
    //                                   : Container(),
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
