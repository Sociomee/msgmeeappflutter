// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'otp_send_cubit.dart';

enum LoginStatus {
  initial,
  loading,
  loaded,
  error,
}

class OtpSendState extends Equatable {
  final LoginStatus status;
  final CustomError error;

  const OtpSendState({required this.status, required this.error});

  @override
  List<Object> get props => [status, error];
  factory OtpSendState.initial() {
    return OtpSendState(status: LoginStatus.initial, error: CustomError());
  }
  OtpSendState copyWith({
    LoginStatus? status,
    CustomError? error,
  }) {
    return OtpSendState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
