import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/data/model/typing_status_model.dart';

part 'typing_state.dart';

class TypingCubit extends Cubit<TypingState> {
  TypingCubit() : super(TypingInitial());

  startTyping(data){
    TypingStatus ts = TypingStatus.fromJson(data as Map<String, dynamic>);
    print(data);
    print(ts.isTyping);
    if (ts.isTyping as bool) {
      emit(TypingStartState(typingStatus: ts));
    } else {
      emit(TypingEndState(typingStatus: ts));
    }
    
  }
}
