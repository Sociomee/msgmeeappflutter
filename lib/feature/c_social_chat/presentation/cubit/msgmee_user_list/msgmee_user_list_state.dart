part of 'msgmee_user_list_cubit.dart';

enum MsgmeeUserListStatus {
  initial,
  loading,
  loaded,
  error,
}

class MsgmeeUserListState extends Equatable {
  final MsgmeeUserList msgmeeUserList;
  final MsgmeeUserListStatus status;
  final CustomError error;
  MsgmeeUserListState({
    required this.msgmeeUserList,
    required this.status,
    required this.error,
  });
  factory MsgmeeUserListState.initial() {
    return MsgmeeUserListState(
        msgmeeUserList: MsgmeeUserList(),
        status: MsgmeeUserListStatus.initial,
        error: CustomError());
  }
  MsgmeeUserListState copyWith({
    MsgmeeUserList? msgmeeUserList,
    MsgmeeUserListStatus? status,
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
