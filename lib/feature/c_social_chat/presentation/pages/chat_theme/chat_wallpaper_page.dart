import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/change_wallpaperview.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/set_chatbg/set_chatbg_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_theme/widget/chat_bg_type.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_theme/widget/chat_wallpaper_option.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../../data/model/chat_model.dart';
import '../../cubit/chat_theme/chat_theme_cubit.dart';
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
                  height: 515,
                  margin: EdgeInsets.symmetric(horizontal: 70),
                  decoration: AppColors.wallpaparPreviewdecoration,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios,
                                color: AppColors.black, size: 15),
                            CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColors.grey,
                                backgroundImage: NetworkImage(imageurl)),
                            SizedBox(width: 8),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Abriella Bond',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(height: 4),
                                Text('Active Now',
                                    style: TextStyle(
                                        fontSize: 11, color: AppColors.grey)),
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.videocam_outlined),
                            SizedBox(width: 13),
                            Icon(Icons.phone_outlined, size: 17),
                            SizedBox(width: 13),
                            Icon(Icons.more_vert_outlined, size: 22)
                          ],
                        ),
                      ),
                      Divider(color: AppColors.grey, thickness: 1, height: 0),
                      Stack(
                        children: [
                          context.watch<SetChatbgCubit>().state.bgType ==
                                  ChatBgType.solidColor
                              ? Container(
                                  height: 400,
                                  width: 300,
                                  color: context
                                      .read<SetChatbgCubit>()
                                      .state
                                      .bgContent)
                              : context.watch<SetChatbgCubit>().state.bgType ==
                                      ChatBgType.fileImage
                                  ? Container(
                                      height: 400,
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
                                      height: 400,
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
                                                  right: 18,
                                                  bottom: 5),
                                              decoration: BoxDecoration(
                                                  color: context
                                                      .watch<ChatThemeCubit>()
                                                      .state
                                                      .chatLightColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
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
                                                      SizedBox(
                                                        width: messages[index]
                                                                    .messageContent
                                                                    .trim()
                                                                    .length <=
                                                                15
                                                            ? 40
                                                            : messages[index]
                                                                        .messageContent
                                                                        .trim()
                                                                        .length <=
                                                                    21
                                                                ? 60
                                                                : 100,
                                                      ),
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 14,
                                                              right: 18,
                                                              bottom: 5),
                                                      decoration: BoxDecoration(
                                                        color: context
                                                            .watch<
                                                                ChatThemeCubit>()
                                                            .state
                                                            .chatDeepColor,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topRight:
                                                              Radius.circular(
                                                                  12),
                                                          topLeft:
                                                              Radius.circular(
                                                                  12),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  12),
                                                        ),
                                                      ),
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
                                                                width: messages[index]
                                                                            .messageContent
                                                                            .trim()
                                                                            .length <=
                                                                        15
                                                                    ? 40
                                                                    : messages[index].messageContent.trim().length <=
                                                                            21
                                                                        ? 60
                                                                        : 110,
                                                              ),
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
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              );
                            },
                          ),
                        ],
                      ),
                      Divider(color: AppColors.grey, thickness: 1, height: 0),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 5.w),
                          Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: AppColors.lightgrey1,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Transform.rotate(
                                  angle: -15,
                                  child: Icon(Icons.attach_file_outlined,
                                      size: 16, color: AppColors.black))),
                          SizedBox(width: 5.w),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: AppColors.lightgrey1,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(Icons.photo_camera_outlined,
                                size: 16, color: AppColors.iconColor),
                          ),
                          SizedBox(width: 10),
                          Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.grey.withOpacity(.4)),
                                color: AppColors.lightgrey1,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Type your message',
                                  style: TextStyle(
                                    color: Color(0xFF4E4E4E),
                                    fontSize: 8.48,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 50),
                                Icon(Icons.emoji_emotions_outlined, size: 15)
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: AppColors.lightgrey1,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(Icons.mic_none,
                                size: 16, color: AppColors.iconColor),
                          ),
                        ],
                      ),
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
