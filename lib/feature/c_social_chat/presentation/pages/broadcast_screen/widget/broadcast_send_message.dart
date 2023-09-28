import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../theme/colors.dart';
import '../../chat_screen/widgets/message_status_widget.dart';

class BoradCastSendMessage extends StatelessWidget {
  const BoradCastSendMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          SizedBox(child: SvgPicture.asset('assets/icons/speakerphone.svg')),
          SizedBox(width: 10),
          Stack(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 5, left: 10, right: 10, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.darkgreen,
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 300,
                                child: Text(
                                    'This is a broadcast message. Please link your SocioMee account with MsgMee account so that we can be friends in both applications',
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14)),
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Text('4.23 PM',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10)),
                                  SizedBox(width: 25)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 3)
                    ],
                  ),
                  SizedBox(width: 3)
                ],
              ),
              Positioned(bottom: 2, right: 0, child: MessageStatus.sent),
              Positioned(
                  bottom: 10,
                  right: 18,
                  child: Text('send',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 10))),
            ],
          ),
        ],
      ),
    );
  }
}
