import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_theme/widget/chat_wallpaper_option.dart';
import 'package:msgmee/theme/colors.dart';
import 'dart:math' as math;
import '../../cubit/add_message/add_message_cubit.dart';
import '../../cubit/chat_theme/chat_theme_cubit.dart';
import '../chat_screen/widgets/custom_shape.dart';
import '../chat_screen/widgets/message_status_widget.dart';

class ChangeWallPaperPage extends StatefulWidget {
  const ChangeWallPaperPage({super.key});

  @override
  State<ChangeWallPaperPage> createState() => _ChangeWallPaperPageState();
}

class _ChangeWallPaperPageState extends State<ChangeWallPaperPage> {
  bool showOptions = false;
  @override
  Widget build(BuildContext context) {
    var messagecubit = context.read<AddMessageCubit>().state.messages;
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
      body: showOptions
          ? WallpaperOptionsWidget()
          : Column(
              children: [
                SizedBox(height: 30),
                Container(
                  height: 533,
                  margin: EdgeInsets.symmetric(horizontal: 70),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 0,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 3,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x16000000),
                        blurRadius: 6,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 8,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x02000000),
                        blurRadius: 9,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x00000000),
                        blurRadius: 10,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.black,
                              size: 15,
                            ),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.grey,
                              backgroundImage: NetworkImage(imageurl),
                            ),
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
                      Divider(color: AppColors.grey, thickness: 1),
                      ListView.builder(
                        itemCount: context
                            .watch<AddMessageCubit>()
                            .state
                            .messages
                            .length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 60),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: (context
                                        .watch<AddMessageCubit>()
                                        .state
                                        .messages[index]
                                        .messageType ==
                                    "receiver"
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: context
                                        .read<AddMessageCubit>()
                                        .state
                                        .messages[index]
                                        .messageType ==
                                    "receiver"
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 5, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.rotationY(math.pi),
                                          child: CustomPaint(
                                            painter: CustomShape(context
                                                .watch<ChatThemeCubit>()
                                                .state
                                                .chatLightColor),
                                          ),
                                        ),
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
                                                const BorderRadius.only(
                                              topRight: Radius.circular(18),
                                              bottomLeft: Radius.circular(18),
                                              bottomRight: Radius.circular(18),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  messagecubit[index]
                                                      .messageContent,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: 10)),
                                              SizedBox(height: 2),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: messagecubit[index]
                                                                .messageContent
                                                                .trim()
                                                                .length <=
                                                            15
                                                        ? 40
                                                        : messagecubit[index]
                                                                    .messageContent
                                                                    .trim()
                                                                    .length <=
                                                                21
                                                            ? 60
                                                            : 100,
                                                  ),
                                                  Text(messagecubit[index].time,
                                                      style: const TextStyle(
                                                          color:
                                                              AppColors.black,
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
                                    padding:
                                        EdgeInsets.only(bottom: 5, right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                                        .watch<ChatThemeCubit>()
                                                        .state
                                                        .chatDeepColor,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(18),
                                                      bottomLeft:
                                                          Radius.circular(18),
                                                      bottomRight:
                                                          Radius.circular(18),
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
                                                          messagecubit[index]
                                                              .messageContent,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      10)),
                                                      SizedBox(height: 2),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                              messagecubit[
                                                                      index]
                                                                  .time,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 8)),
                                                          SizedBox(
                                                            width: messagecubit[
                                                                            index]
                                                                        .messageContent
                                                                        .trim()
                                                                        .length <=
                                                                    15
                                                                ? 40
                                                                : messagecubit[index]
                                                                            .messageContent
                                                                            .trim()
                                                                            .length <=
                                                                        21
                                                                    ? 60
                                                                    : 100,
                                                          ),
                                                          Text(
                                                              messagecubit[
                                                                      index]
                                                                  .msgStatus,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 8)),
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                              Positioned(
                                                bottom: -2,
                                                right: 0,
                                                child: messagecubit[index]
                                                            .msgStatus ==
                                                        'read'
                                                    ? MessageStatus.read
                                                    : messagecubit[index]
                                                                .msgStatus ==
                                                            'send'
                                                        ? MessageStatus.sent
                                                        : MessageStatus
                                                            .delivered,
                                              ),
                                            ],
                                          ),
                                        ),
                                        CustomPaint(
                                            painter: CustomShape(context
                                                .watch<ChatThemeCubit>()
                                                .state
                                                .chatDeepColor)),
                                      ],
                                    ),
                                  ),
                          );
                        },
                      ),
                      Spacer(),
                      Divider(color: AppColors.grey, thickness: 1),
                      Row(
                        children: [
                          SizedBox(width: 10),
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
                          SizedBox(width: 10),
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
                            padding: EdgeInsets.all(10),
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
                      SizedBox(height: 10)
                    ],
                  ),
                ),
                Spacer(),
                Divider(color: AppColors.grey, thickness: 1),
                SizedBox(height: 42),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showOptions = !showOptions;
                    });
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
