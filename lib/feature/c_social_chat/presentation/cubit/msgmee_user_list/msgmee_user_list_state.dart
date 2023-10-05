// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final double filteredDataPercentage;
  MsgmeeUserListState({
    required this.msgmeeUserList,
    required this.status,
    required this.error,
    required this.filteredDataPercentage,
  });
  factory MsgmeeUserListState.initial() {
    return MsgmeeUserListState(
      msgmeeUserList: MsgmeeUserList(),
      status: MsgmeeUserListStatus.initial,
      error: CustomError(),
      filteredDataPercentage: 0,
    );
  }
  MsgmeeUserListState copyWith({
    MsgmeeUserList? msgmeeUserList,
    MsgmeeUserListStatus? status,
    CustomError? error,
    double? filteredDataPercentage,
  }) {
    return MsgmeeUserListState(
      msgmeeUserList: msgmeeUserList ?? this.msgmeeUserList,
      status: status ?? this.status,
      error: error ?? this.error,
      filteredDataPercentage:
          filteredDataPercentage ?? this.filteredDataPercentage,
    );
  }

  @override
  List<Object> get props => [msgmeeUserList, status, error];
}
