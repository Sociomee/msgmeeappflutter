import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_status_widget.dart';
import '../../../../../../theme/colors.dart';
import 'custom_shape.dart';
import 'message_type.dart';

class SentMessageWidget extends StatelessWidget {
  final String message;
  final String msgStatus;
  final String time;
  final MessageType type;
  final File? image;
  final String? doc;
  const SentMessageWidget(
      {Key? key,
      required this.message,
      required this.msgStatus,
      required this.time,
      required this.type,
      this.image,
      this.doc})
      : super(key: key);

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
                        color: AppColors.darkgreen,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
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
            CustomPaint(painter: CustomShape(AppColors.darkgreen)),
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
            Flexible(
              child: Stack(
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                          top: 5, left: 5, right: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: AppColors.darkgreen,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(15)),
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
                                SizedBox(width: 10),
                                Text(
                                  'Joy Arthur',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF141414),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.videocam_outlined),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.phone_outlined,
                                  size: 19,
                                )
                              ],
                            ),
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
            CustomPaint(painter: CustomShape(AppColors.darkgreen)),
          ],
        ),
      ),
    );
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
                        color: AppColors.darkgreen,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
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
            CustomPaint(painter: CustomShape(AppColors.darkgreen)),
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
                        color: AppColors.darkgreen,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
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
            CustomPaint(painter: CustomShape(AppColors.darkgreen)),
          ],
        ),
      ),
    );
    final docMessage = Flexible(
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
                        color: AppColors.darkgreen,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset('assets/docx.svg', height: 38),
                                SizedBox(width: 10),
                                doc != null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doc!.split('/').first,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '${doc!.split('/').last} Kb',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, bottom: 2, top: 3),
                            child: Text(message,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14)),
                          ),
                          SizedBox(height: 2),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
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
            ),
            CustomPaint(painter: CustomShape(AppColors.darkgreen)),
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
                          : messageTextGroup,
        ],
      ),
    );
  }
}
