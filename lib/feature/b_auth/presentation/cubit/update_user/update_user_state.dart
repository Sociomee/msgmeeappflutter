// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'update_user_cubit.dart';

enum UpdateUserStatus {
  initial,
  loading,
  loaded,
  error,
}

class UpdateUserState extends Equatable {
  final UpdateUserStatus status;
  final MsgmeeUserModel reponse;
  final CustomError error;
  UpdateUserState({
    required this.status,
    required this.reponse,
    required this.error,
  });

  factory UpdateUserState.initial() {
    return UpdateUserState(
      status: UpdateUserStatus.initial,
      error: CustomError(),
      reponse: MsgmeeUserModel(),
    );
  }
  @override
  List<Object> get props => [status, error, reponse];

  UpdateUserState copyWith({
    UpdateUserStatus? status,
    MsgmeeUserModel? reponse,
    CustomError? error,
  }) {
    return UpdateUserState(
      status: status ?? this.status,
      reponse: reponse ?? this.reponse,
      error: error ?? this.error,
    );
  }
}
