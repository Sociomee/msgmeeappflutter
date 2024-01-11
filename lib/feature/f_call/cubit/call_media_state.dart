part of 'call_media_cubit.dart';

 class CallMediaState extends Equatable {
  final List<MediaDeviceInfo> audioInputs;
  final List<MediaDeviceInfo> audioOutputs;
  final List<MediaDeviceInfo> videoInputs;
  final MediaDeviceInfo? selectedAudioInput;
  final MediaDeviceInfo? selectedAudioOutput;
  final MediaDeviceInfo? selectedVideoInput;
  final bool webcamInProgress;
  
  CallMediaState(
    {
    this.audioInputs = const [],
    this.audioOutputs = const [],
    this.videoInputs = const [],
    this.selectedAudioInput,
    this.selectedAudioOutput,
    this.selectedVideoInput,
    this.webcamInProgress = false,
  }
  );

 @override
  List<Object?> get props => [
        audioInputs,
        audioOutputs,
        videoInputs,
        selectedAudioInput,
        selectedAudioOutput,
        selectedVideoInput,
        webcamInProgress,
      ];

      CallMediaState copyWith({
    List<MediaDeviceInfo>? audioInputs,
    List<MediaDeviceInfo>? audioOutputs,
    List<MediaDeviceInfo>? videoInputs,
    MediaDeviceInfo? selectedAudioInput,
    MediaDeviceInfo? selectedAudioOutput,
    MediaDeviceInfo? selectedVideoInput,
    bool? webcamInProgress,
  }) {
    return CallMediaState(
      audioInputs: audioInputs != null ? audioInputs : List<MediaDeviceInfo>.of(this.audioInputs),
      audioOutputs: audioOutputs != null ? audioOutputs : List<MediaDeviceInfo>.of(this.audioOutputs),
      videoInputs: videoInputs != null ? videoInputs : List<MediaDeviceInfo>.of(this.videoInputs),
      selectedAudioInput: selectedAudioInput != null ? selectedAudioInput : this.selectedAudioInput,
      selectedAudioOutput: selectedAudioOutput != null ? selectedAudioOutput : this.selectedAudioOutput,
      selectedVideoInput: selectedVideoInput != null ? selectedVideoInput : this.selectedVideoInput,
      webcamInProgress: webcamInProgress !=null ? webcamInProgress : this.webcamInProgress
    );
  }
}

final class CallMediaInitial extends CallMediaState {
  
}
