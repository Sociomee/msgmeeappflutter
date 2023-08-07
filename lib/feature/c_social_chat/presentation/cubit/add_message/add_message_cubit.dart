import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/model/chat_model.dart';
import '../../pages/chat_screen/widgets/message_type.dart';

part 'add_message_state.dart';

class AddMessageCubit extends Cubit<AddMessageState> {
  AddMessageCubit() : super(AddMessageState.initial());

  addMessage(ChatMessage chat) {
    emit(state.copyWith(messages: [...state.messages, chat]));
  }

  removeMessage(ChatMessage message) {
    emit(state.copyWith(
        messages: state.messages
            .where((e) => e.messageContent != message.messageContent)
            .toList()));
  }
}
