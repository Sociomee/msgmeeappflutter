// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'msgmee_user_list_cubit.dart';

enum MsgmeeUserListStatus {
  initial,
  loading,
  loaded,
  error,
}

class MsgmeeUserListState extends Equatable {
  final ContactModel contactModel;
  final MsgmeeUserListStatus status;
  final CustomError error;
  final double filteredDataPercentage;
  MsgmeeUserListState({
    required this.contactModel,
    required this.status,
    required this.error,
    required this.filteredDataPercentage,
  });
  factory MsgmeeUserListState.initial() {
    return MsgmeeUserListState(
      contactModel: ContactModel(),
      status: MsgmeeUserListStatus.initial,
      error: CustomError(),
      filteredDataPercentage: 0,
    );
  }
  MsgmeeUserListState copyWith({
    ContactModel? contactModel,
    MsgmeeUserListStatus? status,
    CustomError? error,
    double? filteredDataPercentage,
  }) {
    return MsgmeeUserListState(
      contactModel: contactModel ?? this.contactModel,
      status: status ?? this.status,
      error: error ?? this.error,
      filteredDataPercentage:
          filteredDataPercentage ?? this.filteredDataPercentage,
    );
  }

  @override
  List<Object> get props => [ contactModel, status, error];
}
