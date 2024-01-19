import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';
import 'package:msgmee/feature/f_call/cubit/call_media_cubit.dart';
import 'package:msgmee/feature/f_call/cubit/producer_cubit.dart';

class Webcam extends StatelessWidget {
  const Webcam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int videoInputDevicesLength = context.select(
            (CallMediaCubit bloc) =>
        bloc.state.videoInputs.length);
    final bool inProgress = context
        .select((CallMediaCubit bloc) => bloc.state.webcamInProgress);
    final Producer? webcam = context
        .select((ProducerCubit bloc) => bloc.state.webcam);
    if (videoInputDevicesLength == 0) {
      return IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.videocam,
          color: Colors.grey,
          // size: screenHeight * 0.045,
        ),
      );
    }
    if (webcam == null) {
      return ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(CircleBorder()),
          padding: MaterialStateProperty.all(EdgeInsets.all(8)),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed)) return Colors.grey;
          }),
          shadowColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed)) return Colors.grey;
          }),
        ),
        onPressed: () {
          if (!inProgress) {
            // context
            //     .read<RoomClientRepository>()
            //     .enableWebcam();
          }
        },
        child: Icon(
          Icons.videocam_off,
          color: Colors.black,
          // size: screenHeight * 0.045,
        ),
      );
    }
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(8)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) return Colors.grey;
        }),
        shadowColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) return Colors.grey;
        }),
      ),
      onPressed: () {
        if (!inProgress) {
          // context
          //     .read<RoomClientRepository>()
          //     .disableWebcam();
        }
      },
      child: Icon(
        Icons.videocam,
        color: Colors.black,
        // size: screenHeight * 0.045,
      ),
    );
  }
}