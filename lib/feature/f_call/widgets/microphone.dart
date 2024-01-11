import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';
import 'package:msgmee/connectivity/call_service.dart';
import 'package:msgmee/feature/f_call/cubit/call_media_cubit.dart';
import 'package:msgmee/feature/f_call/cubit/producer_cubit.dart';

class Microphone extends StatelessWidget {
  const Microphone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Producer? microphone =
        context.select((ProducerCubit bloc) => bloc.state.mic);
    final int audioInputDevicesLength = context
        .select((CallMediaCubit bloc) => bloc.state.audioInputs.length);
    if (audioInputDevicesLength == 0) {
      return IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.mic_off,
          color: Colors.grey,
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
         print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>debug subscriber>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        CallService().testData();
        print("Subscribing");
        if (microphone?.paused == true) {
         // context.read<RoomClientRepository>().unmuteMic();
        } else {
         // context.read<RoomClientRepository>().muteMic();
        }
      },
      child: Icon(
        microphone?.paused == true ? Icons.mic_off : Icons.mic,
        color: microphone == null ? Colors.grey : Colors.black,
      ),
    );
  }
}
