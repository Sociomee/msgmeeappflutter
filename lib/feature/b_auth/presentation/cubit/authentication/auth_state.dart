// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

enum LoginStatus {
  initial,
  loading,
  loaded,
  error,
}

class AuthState extends Equatable {
  final LoginStatus status;
  final CustomError error;

  const AuthState({required this.status, required this.error});

  @override
  List<Object> get props => [status, error];
  factory AuthState.initial() {
    return AuthState(status: LoginStatus.initial, error: CustomError());
  }
  AuthState copyWith({
    LoginStatus? status,
    CustomError? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
