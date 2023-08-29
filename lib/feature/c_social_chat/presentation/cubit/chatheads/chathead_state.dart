part of 'chathead_cubit.dart';

enum ChatHeadStatus {
  initial,
  loading,
  loaded,
  error,
}

class ChatHeadState extends Equatable {
  final ChatHeadModel chatheads;
  final ChatHeadStatus status;
  final CustomError error;
  ChatHeadState({
    required this.chatheads,
    required this.status,
    required this.error,
  });
  factory ChatHeadState.initial() {
    return ChatHeadState(
        chatheads: ChatHeadModel(),
        status: ChatHeadStatus.initial,
        error: CustomError());
  }
  ChatHeadState copyWith({
    ChatHeadModel? chatheads,
    ChatHeadStatus? status,
    CustomError? error,
  }) {
    return ChatHeadState(
      chatheads: chatheads ?? this.chatheads,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [chatheads, status, error];
}
