part of 'producer_cubit.dart';

class ProducerState extends Equatable {
  final Producer? mic;
  final Producer? webcam;
  final Producer? screen;
   ProducerState({
    this.mic,
    this.webcam,
    this.screen,
  });

  static ProducerState copy(ProducerState old, {
    Producer? mic,
    Producer? webcam,
    Producer? screen,
  }) {
    return ProducerState(
      mic: mic ?? old.mic,
      webcam: webcam ?? old.webcam,
      screen: screen ?? old.screen,
    );
  }

  static ProducerState removeMic(ProducerState old) {
    return ProducerState(
      mic: null,
      webcam: old.webcam,
      screen: old.screen,
    );
  }

  static ProducerState removeWebcam(ProducerState old) {
    return ProducerState(
      mic: old.mic,
      webcam: null,
      screen: old.screen,
    );
  }

  static ProducerState removeScreen(ProducerState old) {
    return ProducerState(
      mic: old.mic,
      webcam: old.webcam,
      screen: null,
    );
  }

  @override
  List<Object?> get props => [mic, webcam, screen];
}

final class ProducerInitial extends ProducerState {}
