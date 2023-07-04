import 'package:flutter_bloc/flutter_bloc.dart';

class ShowAudioRecorder extends Cubit<bool> {
  ShowAudioRecorder() : super(false);
  void toggleValue() {
    emit(!state); 
  }
}
