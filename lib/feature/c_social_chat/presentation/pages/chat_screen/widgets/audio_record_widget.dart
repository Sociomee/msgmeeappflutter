import 'package:flutter/material.dart';

import '../../../../../../theme/colors.dart';

class AudioRecordWidget extends StatefulWidget {
  const AudioRecordWidget({super.key});

  @override
  State<AudioRecordWidget> createState() => _AudioRecordWidgetState();
}

class _AudioRecordWidgetState extends State<AudioRecordWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 281,
          decoration: BoxDecoration(
              color: AppColors.lightgrey1,
              borderRadius: BorderRadius.circular(40)),
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(Icons.mic_none_outlined,
                  size: 23, color: AppColors.iconColor),
              SizedBox(width: 10),
              Text('0:01 sec', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        // SizedBox(width: 7),
        // GestureDetector(
        //   onTap: () {
        //     context.read<AddMessageCubit>().addMessage(ChatMessage(
        //           messageContent: '',
        //           messageType: 'sender',
        //           msgStatus: 'send',
        //           time: '4:28 pm',
        //           type: MessageType.audio,
        //         ));
        //     setState(() {});
        //   },
        //   child: Container(
        //     height: 30,
        //     width: 30,
        //     decoration: BoxDecoration(
        //       color: AppColors.lightgrey1,
        //       borderRadius: BorderRadius.circular(30),
        //     ),
        //     child: Image.asset('assets/attach.png'),
        //   ),
        // ),
      ],
    );
  }
}
