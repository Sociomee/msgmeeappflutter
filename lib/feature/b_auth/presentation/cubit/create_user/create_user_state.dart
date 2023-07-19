// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'create_user_cubit.dart';

class CreateUserState extends Equatable {
  final LoginStatus status;
  final CustomError error;
  CreateUserState({
    required this.status,
    required this.error,
  });

  factory CreateUserState.initial() {
    return CreateUserState(status: LoginStatus.initial, error: CustomError());
  }
  @override
  List<Object> get props => [status, error];

  CreateUserState copyWith({
    LoginStatus? status,
    CustomError? error,
  }) {
    return CreateUserState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
