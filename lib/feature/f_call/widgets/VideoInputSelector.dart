import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/feature/f_call/cubit/call_media_cubit.dart';
import 'package:msgmee/feature/f_call/widgets/MediaDeviceSelector.dart';

class VideoInputSelector extends StatelessWidget {
  const VideoInputSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MediaDeviceInfo> videoInputDevices =
    context.select((CallMediaCubit bloc) => bloc.state.videoInputs);
    final MediaDeviceInfo? selectedVideoInput = context
        .select((CallMediaCubit bloc) => bloc.state.selectedVideoInput);

    return MediaDeviceSelector(
      selected: selectedVideoInput,
      options: videoInputDevices,
      onChanged: (MediaDeviceInfo? device) =>
          context.read<CallMediaCubit>().handleMediaDeviceSelectVideoInput(device),
          
    );
  }
}
