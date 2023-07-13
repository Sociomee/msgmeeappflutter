import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/map_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_status_widget.dart';
import '../../../../../../theme/colors.dart';
import '../../../cubit/chat_theme/chat_theme_cubit.dart';

import 'message_type.dart';

class SentMessageWidget extends StatelessWidget {
  final String message;
  final String msgStatus;
  final String time;
  final MessageType type;
  final File? image;
  final String? doc;
  final List<File?>? images;
  final List<String>? docs;
  final int? numberofContact;
  const SentMessageWidget({
    Key? key,
    required this.message,
    required this.msgStatus,
    required this.time,
    required this.type,
    this.image,
    this.doc,
    this.images,
    this.docs,
    this.numberofContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                          top: 10, left: 14, right: 18, bottom: 5),
                      decoration: BoxDecoration(
                        color:
                            context.watch<ChatThemeCubit>().state.chatDeepColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                          SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(time,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                              SizedBox(
                                width: message.trim().length <= 15
                                    ? 40
                                    : message.trim().length <= 21
                                        ? 80
                                        : 200,
                              ),
                              Text(msgStatus,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                            ],
                          )
                        ],
                      )),
                  Positioned(
                    bottom: -1,
                    right: -1,
                    child: msgStatus == 'read'
                        ? MessageStatus.read
                        : msgStatus == 'send'
                            ? MessageStatus.sent
                            : MessageStatus.delivered,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    final contactMessage = Flexible(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    padding: const EdgeInsets.only(
                        top: 5, left: 5, right: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color:
                          context.watch<ChatThemeCubit>().state.chatDeepColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        message != ''
                            ? Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
                                        height: 44,
                                        width: 44,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      'Joy Arthur',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    SvgPicture.asset('assets/video.svg'),
                                    SizedBox(width: 10),
                                    SvgPicture.asset('assets/call.svg')
                                  ],
                                ),
                              )
                            : Container(
                                width: 200.w,
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        SizedBox(
                                          width: 80.w,
                                          child: Text(
                                            'Joy Arthure',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SvgPicture.asset('assets/video.svg'),
                                        SizedBox(width: 10),
                                        SvgPicture.asset('assets/call.svg')
                                      ],
                                    ),
                                    Divider(
                                        color: AppColors.lightgrey,
                                        height: 10,
                                        thickness: 1),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      child: Text(
                                        'Message',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF368C4E),
                                          fontSize: 14,
                                          fontFamily: 'Nunito Sans',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        SizedBox(height: 5),
                        message == ""
                            ? Container()
                            : Text(message,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14)),
                        SizedBox(height: 5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(time,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10)),
                            SizedBox(
                              width: message.length == 0
                                  ? 130.w
                                  : message.trim().length <= 21
                                      ? 80
                                      : 200,
                            ),
                            Text(msgStatus,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10)),
                          ],
                        )
                      ],
                    )),
                Positioned(
                  bottom: -2,
                  right: 0,
                  child: msgStatus == 'read'
                      ? MessageStatus.read
                      : msgStatus == 'send'
                          ? MessageStatus.sent
                          : MessageStatus.delivered,
                ),
              ],
            ),
          ],
        ),
      ),
    );
    final multiplecontact = contactMessage;

    final imageMessage = Flexible(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                          top: 5, left: 5, right: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color:
                            context.watch<ChatThemeCubit>().state.chatDeepColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 140,
                            width: 220,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ))
                                : Container(),
                          ),
                          SizedBox(height: 5),
                          Text(message,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                          SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(time,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                              SizedBox(
                                width: message.trim().length <= 15
                                    ? 40
                                    : message.trim().length <= 21
                                        ? 80
                                        : 200,
                              ),
                              Text(msgStatus,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                            ],
                          )
                        ],
                      )),
                  Positioned(
                    bottom: -2,
                    right: 0,
                    child: msgStatus == 'read'
                        ? MessageStatus.read
                        : msgStatus == 'send'
                            ? MessageStatus.sent
                            : MessageStatus.delivered,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    final multipleImageMessage = Flexible(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:
                            context.watch<ChatThemeCubit>().state.chatDeepColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          images != null
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: images!.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                          mainAxisExtent: 100),
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            images![index]!,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          )),
                                    );
                                  },
                                )
                              : Container(),
                          SizedBox(height: 5),
                          Text(message,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                          SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(time,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                              SizedBox(
                                width: message.trim().length <= 15
                                    ? 40
                                    : message.trim().length <= 21
                                        ? 80
                                        : 200,
                              ),
                              Text(msgStatus,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                            ],
                          )
                        ],
                      )),
                  Positioned(
                    bottom: -2,
                    right: 0,
                    child: msgStatus == 'read'
                        ? MessageStatus.read
                        : msgStatus == 'send'
                            ? MessageStatus.sent
                            : MessageStatus.delivered,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    final audioMessage = Flexible(
      child: Container(
        width: 230,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:
                            context.watch<ChatThemeCubit>().state.chatDeepColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.headset, color: Colors.blue),
                                    Image.asset('assets/audio_eq.png'),
                                    Icon(Icons.play_circle_outlined)
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('00:30'),
                                    SizedBox(
                                      width: 120,
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: Colors.white,
                                          thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 4.0),
                                          overlayShape: RoundSliderOverlayShape(
                                              overlayRadius: 0.0),
                                        ),
                                        child: Slider(
                                            value: 130,
                                            min: 129.0,
                                            max: 160.0,
                                            onChanged: (e) {}),
                                      ),
                                    ),
                                    Text('32 KB')
                                  ],
                                )
                              ],
                            ),
                          ),
                          Text(message,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                          SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(time,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                              SizedBox(
                                width: message.trim().length <= 15
                                    ? 40
                                    : message.trim().length <= 21
                                        ? 80
                                        : 200,
                              ),
                              Text(msgStatus,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                            ],
                          )
                        ],
                      )),
                  Positioned(
                    bottom: -2,
                    right: 0,
                    child: msgStatus == 'read'
                        ? MessageStatus.read
                        : msgStatus == 'send'
                            ? MessageStatus.sent
                            : MessageStatus.delivered,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    final docMessage = Container(
      width: 195.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: context.watch<ChatThemeCubit>().state.chatDeepColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            doc != null
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Jocelyn Westervelt',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/document.svg'),
                                          SizedBox(width: 6),
                                          SizedBox(
                                            width: 120.w,
                                            child: Text(
                                              doc!.split('/').first,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10.sp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(),
                            doc != null
                                ? Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                        color: AppColors.seconderyColor1,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    child: Center(
                                        child: doc!
                                                    .split('/')
                                                    .first
                                                    .split('.')
                                                    .last
                                                    .toString() ==
                                                'pdf'
                                            ? SvgPicture.asset('assets/docx.svg',
                                                height: 35)
                                            : doc!
                                                        .split('/')
                                                        .first
                                                        .split('.')
                                                        .last
                                                        .toString() ==
                                                    'mp3'
                                                ? SvgPicture.asset('assets/mp3.svg',
                                                    height: 35)
                                                : doc!
                                                            .split('/')
                                                            .first
                                                            .split('.')
                                                            .last
                                                            .toString() ==
                                                        'mp4'
                                                    ? SvgPicture.asset('assets/mp4.svg',
                                                        height: 35)
                                                    : doc!
                                                                .split('/')
                                                                .first
                                                                .split('.')
                                                                .last
                                                                .toString() ==
                                                            'png'
                                                        ? SvgPicture.asset(
                                                            'assets/png.svg',
                                                            height: 35)
                                                        : SvgPicture.asset(
                                                            'assets/jpg.svg',
                                                            height: 35)),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      message == ""
                          ? SizedBox(height: 5)
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 2, top: 3),
                              child: Text(message,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14)),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(time,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10)),
                            SizedBox(width: 110.w),
                            Text(msgStatus,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10)),
                          ],
                        ),
                      )
                    ],
                  )),
              Positioned(
                bottom: -2,
                right: 0,
                child: msgStatus == 'read'
                    ? MessageStatus.read
                    : msgStatus == 'send'
                        ? MessageStatus.sent
                        : MessageStatus.delivered,
              ),
            ],
          ),
        ],
      ),
    );
    final locationMessage = Flexible(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                          top: 5, left: 5, right: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color:
                            context.watch<ChatThemeCubit>().state.chatDeepColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 140,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: MapViewWidget()),
                          ),
                          SizedBox(height: 5),
                          Text(message,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                          SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(time,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                              SizedBox(
                                width: message.trim().length <= 15
                                    ? 40
                                    : message.trim().length <= 21
                                        ? 80
                                        : 200,
                              ),
                              Text(msgStatus,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                            ],
                          )
                        ],
                      )),
                  Positioned(
                    bottom: -2,
                    right: 0,
                    child: msgStatus == 'read'
                        ? MessageStatus.read
                        : msgStatus == 'send'
                            ? MessageStatus.sent
                            : MessageStatus.delivered,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 0, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          type == MessageType.contact
              ? contactMessage
              : type == MessageType.audio
                  ? audioMessage
                  : type == MessageType.doc
                      ? docMessage
                      : type == MessageType.image
                          ? imageMessage
                          : type == MessageType.location
                              ? locationMessage
                              : type == MessageType.multipleImage
                                  ? multipleImageMessage
                                  : type == MessageType.multiplecontact
                                      ? multiplecontact
                                      : messageTextGroup,
        ],
      ),
    );
  }
}
