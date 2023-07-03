import 'dart:io';

import 'package:flutter/material.dart';
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
  const SentMessageWidget({
    Key? key,
    required this.message,
    required this.msgStatus,
    required this.time,
    required this.type,
    this.image,
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

    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 0, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          type == MessageType.contact
              ? contactMessage
              : type == MessageType.image
                  ? imageMessage
                  : messageTextGroup,
        ],
      ),
    );
  }
}
