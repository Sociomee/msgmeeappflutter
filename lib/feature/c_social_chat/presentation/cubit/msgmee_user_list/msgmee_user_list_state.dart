part of 'msgmee_user_list_cubit.dart';

enum ChatHeadStatus {
  initial,
  loading,
  loaded,
  error,
}

class MsgmeeUserListState extends Equatable {
  final MsgmeeUserList msgmeeUserList;
  final ChatHeadStatus status;
  final CustomError error;
  MsgmeeUserListState({
    required this.msgmeeUserList,
    required this.status,
    required this.error,
  });
  factory MsgmeeUserListState.initial() {
    return MsgmeeUserListState(
        msgmeeUserList: MsgmeeUserList(),
        status: ChatHeadStatus.initial,
        error: CustomError());
  }
  MsgmeeUserListState copyWith({
    MsgmeeUserList? msgmeeUserList,
    ChatHeadStatus? status,
    CustomError? error,
  }) {
    return MsgmeeUserListState(
      msgmeeUserList: msgmeeUserList ?? this.msgmeeUserList,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [msgmeeUserList, status, error];
}
