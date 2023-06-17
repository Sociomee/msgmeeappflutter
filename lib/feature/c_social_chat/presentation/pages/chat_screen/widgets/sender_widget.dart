import 'package:flutter/material.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_status_widget.dart';
import '../../../../../../theme/colors.dart';
import 'custom_shape.dart';

class SentMessageWidget extends StatefulWidget {
  final String message;
  final String msgStatus;
  final String time;
  const SentMessageWidget({
    Key? key,
    required this.message,
    required this.msgStatus,
    required this.time,
  }) : super(key: key);

  @override
  State<SentMessageWidget> createState() => _SentMessageWidgetState();
}

class _SentMessageWidgetState extends State<SentMessageWidget> {
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
                          Text(widget.message,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                          SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(widget.time,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                              SizedBox(
                                width: widget.message.trim().length <= 15
                                    ? 40
                                    : widget.message.trim().length <= 21
                                        ? 80
                                        : 200,
                              ),
                              Text(widget.msgStatus,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                            ],
                          )
                        ],
                      )),
                  Positioned(
                    bottom: -2,
                    right: 0,
                    child: widget.msgStatus == 'read'
                        ? MessageStatus.read
                        : widget.msgStatus == 'send'
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
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}

class SentContactMessageWidget extends StatefulWidget {
  final String message;
  final String msgStatus;
  final String time;
  const SentContactMessageWidget({
    Key? key,
    required this.message,
    required this.msgStatus,
    required this.time,
  }) : super(key: key);

  @override
  State<SentMessageWidget> createState() => _SentMessageWidgetState();
}

class _SentContactMessageWidgetState extends State<SentMessageWidget> {
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
                          Text(widget.message,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                          SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(widget.time,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                              SizedBox(
                                width: widget.message.trim().length <= 15
                                    ? 40
                                    : widget.message.trim().length <= 21
                                        ? 80
                                        : 200,
                              ),
                              Text(widget.msgStatus,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10)),
                            ],
                          )
                        ],
                      )),
                  Positioned(
                    bottom: -2,
                    right: 0,
                    child: widget.msgStatus == 'read'
                        ? MessageStatus.read
                        : widget.msgStatus == 'send'
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
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}



// Container(
//                             margin: EdgeInsets.only(bottom: 5),
//                             padding: EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: AppColors.white,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Row(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.network(
//                                     'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
//                                     height: 44,
//                                     width: 44,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 SizedBox(width: 5),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text('Abriella Bond'),
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.person_2_outlined,
//                                           size: 18,
//                                         ),
//                                         Text('Joy Arthur')
//                                       ],
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),