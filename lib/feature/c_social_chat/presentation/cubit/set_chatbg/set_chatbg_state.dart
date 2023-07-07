part of 'set_chatbg_cubit.dart';

class SetChatbgState extends Equatable {
  final ChatBgType bgType;
  final dynamic bgContent;
  SetChatbgState({
    required this.bgType,
    required this.bgContent,
  });

  factory SetChatbgState.initial() {
    return SetChatbgState(
        bgType: ChatBgType.solidColor, bgContent: Colors.white);
  }
  SetChatbgState copyWith({
    ChatBgType? bgType,
    dynamic bgContent,
  }) {
    return SetChatbgState(
      bgType: bgType ?? this.bgType,
      bgContent: bgContent ?? this.bgContent,
    );
  }

  @override
  List<Object> get props => [bgType, bgContent];
}
