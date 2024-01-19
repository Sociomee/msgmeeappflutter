import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/data/model/reply_msg_model.dart';

part 'reply_msg_state.dart';

class ReplyMsgCubit extends Cubit<ReplyMsgState> {
  ReplyMsgCubit() : super(ReplyMsgState.initial());

  replyMsg(String owner, String msg , {String? sId}) {
    emit(state.copyWith(
        reply: true, replymodel: ReplyMsgModel(owner: owner, msg: msg , sId: sId)));
  }

  closeReplyMsg() {
    emit(state.copyWith(reply: false));
  }
}
