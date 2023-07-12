import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../data/model/chat_model.dart';
import '../../../../../../theme/colors.dart';
import '../../../cubit/add_message/add_message_cubit.dart';
import '../../../cubit/show_audio_recorder.dart';
import 'message_type.dart';

class AudioRecordWidget extends StatefulWidget {
  const AudioRecordWidget({super.key});

  @override
  State<AudioRecordWidget> createState() => _AudioRecordWidgetState();
}

class _AudioRecordWidgetState extends State<AudioRecordWidget> {
  final recorder = FlutterSoundRecorder();

  @override
  void initState() {
    super.initState();
    initRecorder();
    Timer(Duration(milliseconds: 500), () {
      record();
    });
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw "Microphone permission not granted";
    } else if (status == PermissionStatus.granted) {
      await recorder.openRecorder();
      recorder.setSubscriptionDuration(Duration(microseconds: 500));
      record();
    }
  }

  record() async {
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    await recorder.stopRecorder();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    return Row(
      children: [
        Container(
          height: 40,
          width: 240.w,
          decoration: BoxDecoration(
              color: AppColors.lightgrey1,
              borderRadius: BorderRadius.circular(40)),
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(Icons.mic_none_outlined,
                  size: 23, color: AppColors.iconColor),
              SizedBox(width: 10),
              StreamBuilder<RecordingDisposition>(
                  stream: recorder.onProgress,
                  builder: (context, snapshot) {
                    final duration = snapshot.hasData
                        ? snapshot.data!.duration
                        : Duration.zero;
                    print('recording ....${snapshot.data}');
                    var min = strDigits(duration.inMinutes.remainder(60));
                    var sec = strDigits(duration.inSeconds.remainder(60));
                    return Text('$min:$sec sec');
                  }),
            ],
          ),
        ),
        SizedBox(width: 7),
        GestureDetector(
          onTap: () {
            context.read<AddMessageCubit>().addMessage(ChatMessage(
                  messageContent: '',
                  messageType: 'sender',
                  msgStatus: 'send',
                  time: '4:28 pm',
                  type: MessageType.audio,
                ));
            context.read<ShowAudioRecorder>().toggleValue();
            stop();
            setState(() {});
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: AppColors.lightgrey1,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Image.asset('assets/attach.png'),
          ),
        ),
      ],
    );
  }
}
