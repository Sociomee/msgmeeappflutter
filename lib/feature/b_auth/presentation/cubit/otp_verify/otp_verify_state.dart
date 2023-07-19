// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'otp_verify_cubit.dart';

class OtpVerifyState extends Equatable {
  final LoginStatus status;
  final CustomError error;
  OtpVerifyState({
    required this.status,
    required this.error,
  });

  factory OtpVerifyState.initial() {
    return OtpVerifyState(status: LoginStatus.initial, error: CustomError());
  }
  @override
  List<Object> get props => [status, error];

  OtpVerifyState copyWith({
    LoginStatus? status,
    CustomError? error,
  }) {
    return OtpVerifyState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
