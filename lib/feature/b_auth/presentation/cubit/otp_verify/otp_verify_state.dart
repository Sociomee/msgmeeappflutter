// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'otp_verify_cubit.dart';

enum OtpVerifyStatus {
  initial,
  loading,
  loaded,
  error,
}

class OtpVerifyState extends Equatable {
  final OtpVerifyStatus status;
  final CustomError error;
  final OtpModel response;

  OtpVerifyState(
      {required this.status, required this.error, required this.response});

  factory OtpVerifyState.initial() {
    return OtpVerifyState(
        status: OtpVerifyStatus.initial,
        error: CustomError(),
        response: OtpModel());
  }
  @override
  List<Object> get props => [status, error, response];

  OtpVerifyState copyWith({
    OtpVerifyStatus? status,
    CustomError? error,
    OtpModel? response,
  }) {
    return OtpVerifyState(
      status: status ?? this.status,
      error: error ?? this.error,
      response: response ?? this.response,
    );
  }
}
