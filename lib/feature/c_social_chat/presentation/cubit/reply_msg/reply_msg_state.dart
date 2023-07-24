// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'reply_msg_cubit.dart';

class ReplyMsgState extends Equatable {
  final ReplyMsgModel replymodel;
  final bool reply;
  const ReplyMsgState({
    required this.replymodel,
    required this.reply,
  });

  factory ReplyMsgState.initial() {
    return ReplyMsgState(
        replymodel: ReplyMsgModel(owner: '', msg: ''), reply: false);
  }
  @override
  List<Object> get props => [replymodel, reply];

  ReplyMsgState copyWith({
    ReplyMsgModel? replymodel,
    bool? reply,
  }) {
    return ReplyMsgState(
      replymodel: replymodel ?? this.replymodel,
      reply: reply ?? this.reply,
    );
  }
}
