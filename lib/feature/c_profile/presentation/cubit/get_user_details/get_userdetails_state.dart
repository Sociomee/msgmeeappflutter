part of 'get_userdetails_cubit.dart';

enum GetUserDetailsStatus { initial, loading, loaded, error }

class GetUserDetailsState extends Equatable {
  final GetUserDetailsStatus status;
  final MsgmeeUserModel response;
  final CustomError error;
  GetUserDetailsState({
    required this.status,
    required this.response,
    required this.error,
  });
  factory GetUserDetailsState.initial() {
    return GetUserDetailsState(
        status: GetUserDetailsStatus.initial,
        response: MsgmeeUserModel(),
        error: CustomError());
  }

  GetUserDetailsState copyWith({
    GetUserDetailsStatus? status,
    MsgmeeUserModel? response,
    CustomError? error,
  }) {
    return GetUserDetailsState(
      status: status ?? this.status,
      response: response ?? this.response,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, response, error];
}
