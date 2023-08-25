// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'create_user_cubit.dart';

enum CreateUserStatus {
  initial,
  loading,
  loaded,
  error,
}

class CreateUserState extends Equatable {
  final CreateUserStatus status;
  final CustomError error;
  CreateUserState({
    required this.status,
    required this.error,
  });

  factory CreateUserState.initial() {
    return CreateUserState(status: CreateUserStatus.initial, error: CustomError());
  }
  @override
  List<Object> get props => [status, error];

  CreateUserState copyWith({
    CreateUserStatus? status,
    CustomError? error,
  }) {
    return CreateUserState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
