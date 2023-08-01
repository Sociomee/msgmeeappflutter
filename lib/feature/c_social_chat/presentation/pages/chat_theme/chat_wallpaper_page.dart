import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/change_wallpaperview.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/set_chatbg/set_chatbg_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_theme/widget/chat_bg_type.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_theme/widget/chat_wallpaper_option.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../../data/model/chat_model.dart';
import '../../cubit/chat_theme/chat_theme_cubit.dart';
import '../chat_screen/widgets/message_status_widget.dart';
import '../chat_screen/widgets/message_type.dart';

List<ChatMessage> messages = [
  ChatMessage(
    messageContent: "Hello, Will",
    messageType: "receiver",
    msgStatus: 'read',
    time: '04.25 pm',
    type: MessageType.text,
  ),
  ChatMessage(
    messageContent: "How have you been?",
    messageType: "receiver",
    msgStatus: 'read',
    time: '04.25 pm',
    type: MessageType.text,
  ),
  ChatMessage(
    messageContent: "Hey Kriss, I am doing fine dude. wbu?",
    messageType: "sender",
    msgStatus: 'read',
    time: '04.25 pm',
    type: MessageType.text,
  ),
  ChatMessage(
    messageContent: "ehhhh, doing OK.",
    messageType: "receiver",
    msgStatus: 'read',
    time: '04.25 pm',
    type: MessageType.text,
  ),
  ChatMessage(
    messageContent: "Is there any thing wrong?",
    messageType: "sender",
    msgStatus: 'read',
    time: '04.25 pm',
    type: MessageType.text,
  ),
];

class ChangeWallPaperPage extends StatefulWidget {
  const ChangeWallPaperPage({super.key});

  @override
  State<ChangeWallPaperPage> createState() => _ChangeWallPaperPageState();
}

class _ChangeWallPaperPageState extends State<ChangeWallPaperPage> {
  @override
  Widget build(BuildContext context) {
    final String imageurl =
        'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?cs=srgb&dl=pexels-masha-raymers-2726111.jpg&fm=jpg';
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: AppColors.black)),
        elevation: 1,
        titleSpacing: 0,
        title: Text('Wallpaper', style: TextStyle(color: AppColors.black)),
      ),
      body: context.watch<ChangeWallPaperView>().state
          ? WallpaperOptionsWidget()
          : Column(
              children: [
                SizedBox(height: 30),
                Container(
                  height: 418.h,
                  margin: EdgeInsets.symmetric(horizontal: 70),
                  decoration: AppColors.wallpaparPreviewdecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10.w, right: 10.w, top: 10),
                        child: Row(
                          children: [
                            Text(
                              '9:27',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 10.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/network.svg'),
                            SvgPicture.asset('assets/Wifi.svg'),
                            SvgPicture.asset('assets/Battery.svg')
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios,
                                color: AppColors.black, size: 15),
                            CircleAvatar(
                                radius: 16,
                                backgroundColor: AppColors.grey,
                                backgroundImage: NetworkImage(imageurl)),
                            SizedBox(width: 8),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Abriella Bond',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(height: 4),
                                Text('Active Now',
                                    style: TextStyle(
                                        fontSize: 10, color: AppColors.grey)),
                              ],
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              'assets/video.svg',
                              height: 15.w,
                            ),
                            SizedBox(width: 13),
                            SvgPicture.asset(
                              'assets/calling.svg',
                              height: 15.w,
                            ),
                            SizedBox(width: 13),
                            Icon(Icons.more_vert_outlined, size: 18)
                          ],
                        ),
                      ),
                      Divider(color: AppColors.grey, thickness: .3, height: 0),
                      Stack(
                        children: [
                          context.watch<SetChatbgCubit>().state.bgType ==
                                  ChatBgType.solidColor
                              ? Container(
                                  height: 320.h,
                                  width: 300,
                                  color: context
                                      .read<SetChatbgCubit>()
                                      .state
                                      .bgContent)
                              : context.watch<SetChatbgCubit>().state.bgType ==
                                      ChatBgType.fileImage
                                  ? Container(
                                      height: 320.h,
                                      width: 300,
                                      child: Image.file(
                                        File(
                                          context
                                              .read<SetChatbgCubit>()
                                              .state
                                              .bgContent!
                                              .path,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      height: 320.h,
                                      width: 300,
                                      child: Image.network(
                                        context
                                            .read<SetChatbgCubit>()
                                            .state
                                            .bgContent,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                          ListView.builder(
                            itemCount: messages.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 10),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Align(
                                alignment:
                                    (messages[index].messageType == "receiver"
                                        ? Alignment.topLeft
                                        : Alignment.topRight),
                                child: messages[index].messageType == "receiver"
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 5, left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 14,
                                                  right: 5,
                                                  bottom: 5),
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.seconderyColor1,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      messages[index]
                                                          .messageContent,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                          fontSize: 10)),
                                                  SizedBox(height: 2),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(width: 50.w),
                                                      Text(messages[index].time,
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontSize: 8)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 15, right: 10),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                      // width: 150.w,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 14,
                                                              right: 17,
                                                              bottom: 5),
                                                      decoration: BoxDecoration(
                                                          color: context
                                                              .watch<
                                                                  ChatThemeCubit>()
                                                              .state
                                                              .chatDeepColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              messages[index]
                                                                  .messageContent,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      10)),
                                                          SizedBox(height: 2),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                  messages[
                                                                          index]
                                                                      .time,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          8)),
                                                              SizedBox(
                                                                  width: 104.w),
                                                              Text(
                                                                  messages[
                                                                          index]
                                                                      .msgStatus,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          8)),
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: messages[index]
                                                                .msgStatus ==
                                                            'read'
                                                        ? MessageStatus.read
                                                        : messages[index]
                                                                    .msgStatus ==
                                                                'send'
                                                            ? MessageStatus.sent
                                                            : MessageStatus
                                                                .delivered,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              );
                            },
                          ),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 11.74, vertical: 6.52),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF3FFE9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.91),
                                    ),
                                  ),
                                  child: Text('23 March, 2021',
                                      style: TextStyle(
                                          color: Color(0xFF81C14B),
                                          fontSize: 7.83,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600))))
                        ],
                      ),
                      Spacer(),
                      Divider(
                          color: Color(0xFFE0E0E0), thickness: .7, height: 0),
                      SizedBox(height: 5.h),
                      Container(
                        width: 273.w,
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                width: 20,
                                height: 20,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: SvgPicture.asset('assets/clip.svg')),
                            SizedBox(width: 5.w),
                            Container(
                              width: 20,
                              height: 20,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Icon(Icons.photo_camera_outlined,
                                  size: 16, color: AppColors.iconColor),
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.grey.withOpacity(.4)),
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Type your message',
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 8.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 40.w),
                                  SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: Center(
                                      child: SvgPicture.asset(
                                          'assets/smiley.svg',
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 7.17),
                            Container(
                                width: 20,
                                height: 20,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: SvgPicture.asset('assets/microphone.svg',
                                    fit: BoxFit.contain)),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
                Spacer(),
                Divider(
                    color: AppColors.lightgrey.withOpacity(.5), thickness: 1),
                SizedBox(height: 42),
                GestureDetector(
                  onTap: () {
                    context.read<ChangeWallPaperView>().changeView();
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 138, vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.primaryColor)),
                      child: Text(
                        'Change',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
                Spacer(),
              ],
            ),
    );
  }
}
