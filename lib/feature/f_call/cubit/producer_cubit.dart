import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';

part 'producer_state.dart';

class ProducerCubit extends Cubit<ProducerState> {
  ProducerCubit() : super(ProducerState());


 



  FutureOr<void> handleProducerAdd(String source , value) async{
     switch (source) {
      case 'mic': {
         emit(ProducerState.copy(state, mic: value));
        break;
      }
      case 'webcam': {
        emit(ProducerState.copy(state, webcam: value));
        break;
      }
      case 'screen': {
        emit(ProducerState.copy(state, screen: value));
        break;
      }
      default: break;
    }
  }

  FutureOr<void> handleProducerRemove(String source) async{
    switch (source) {
      case 'mic': {
        state.mic?.close();
        emit(ProducerState.removeMic(state));
        break;
      }
      case 'webcam': {
        state.webcam?.close();
        emit(ProducerState.removeWebcam(state));
        break;
      }
      case 'screen': {
        state.screen?.close();
        emit(ProducerState.removeScreen(state));
        break;
      }
      default: break;
    }
  }

  FutureOr<void> handleProducerResumed(String source) async{
     switch (source) {
      case 'mic': {
        emit(ProducerState.copy(state, mic: state.mic!.resumeCopy()));
        break;
      }
      case 'webcam': {
        emit(ProducerState.copy(state, webcam: state.webcam!.resumeCopy()));
        break;
      }
      case 'screen': {
        emit(ProducerState.copy(state, screen: state.screen?.resumeCopy()));
        break;
      }
      default: break;
    }
  }

  FutureOr<void> handleProducerPaused(String source) async{
    switch (source) {
      case 'mic': {
        emit(ProducerState.copy(state, mic: state.mic!.pauseCopy()));
        break;
      }
      case 'webcam': {
        emit(ProducerState.copy(state, webcam: state.webcam!.pauseCopy()));
        break;
      }
      case 'screen': {
        emit(ProducerState.copy(state, screen: state.screen!.pauseCopy()));
        break;
      }
      default: break;
    }
  }
}
