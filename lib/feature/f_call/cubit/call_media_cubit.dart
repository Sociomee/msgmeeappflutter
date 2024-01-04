import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';

part 'call_media_state.dart';

class CallMediaCubit extends Cubit<CallMediaState> {


  CallMediaCubit() : super(CallMediaInitial());

Future<FutureOr<void>> handleMediaDeviceLoadEvent() async {
print("Loading devices");
    try {
      final List<MediaDeviceInfo> devices =
          await navigator.mediaDevices.enumerateDevices();

      final List<MediaDeviceInfo> audioInputs = [];
      final List<MediaDeviceInfo> audioOutputs = [];
      final List<MediaDeviceInfo> videoInputs = [];

      for (final device in devices) {
        switch (device.kind) {
          case 'audioinput':
            audioInputs.add(device);
            break;
          case 'audiooutput':
            audioOutputs.add(device);
            break;
          case 'videoinput':
            videoInputs.add(device);
            break;
          default:
            break;
        }
      }

      MediaDeviceInfo? selectedAudioInput = audioInputs.isNotEmpty ? audioInputs.first : null;
      MediaDeviceInfo? selectedAudioOutput = audioOutputs.isNotEmpty ? audioOutputs.first : null;
      MediaDeviceInfo? selectedVideoInput = videoInputs.isNotEmpty ? videoInputs.last : null;
      emit(CallMediaState(
        audioInputs: audioInputs,
        audioOutputs: audioOutputs,
        videoInputs: videoInputs,
        selectedAudioInput: selectedAudioInput,
        selectedAudioOutput: selectedAudioOutput,
        selectedVideoInput: selectedVideoInput,
      ));
      print("Video devices ${videoInputs.length}");
       print("Audio devices ${audioInputs.length}");
       print("Selected device video ${selectedVideoInput?.label} and id is ${selectedVideoInput?.deviceId}");
      print("Selected device audio ${selectedAudioInput?.label} and id is ${selectedAudioInput?.deviceId}");

    } catch (e) {
      print("Error while handling ");
      print(e);
    }
  }

  FutureOr<void> handleMediaDeviceSelectAudioInput(MediaDeviceInfo? selectedAudioInput) async{
    emit(state.copyWith(selectedAudioInput: selectedAudioInput));
  }

  FutureOr<void> handleMediaDeviceSelectAudioOutput(MediaDeviceInfo? selectedAudioOutput) async{
    emit(state.copyWith(selectedAudioOutput: selectedAudioOutput));
  }

  FutureOr<void> handleMediaDeviceSelectVideoInput(MediaDeviceInfo? selectedVideoInput) async{
    emit(state.copyWith(selectedVideoInput: selectedVideoInput));
  }
}
