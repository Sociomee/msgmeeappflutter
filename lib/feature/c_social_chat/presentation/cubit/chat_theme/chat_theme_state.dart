// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'chat_theme_cubit.dart';

class ChatThemeState extends Equatable {
  final Color chatDeepColor;
  final Color chatLightColor;
  ChatThemeState({
    required this.chatDeepColor,
    required this.chatLightColor,
  });
  factory ChatThemeState.initial() {
    return ChatThemeState(
        chatDeepColor: AppColors.darkgreen,
        chatLightColor: AppColors.seconderyColor1);
  }

  @override
  List<Object> get props => [chatDeepColor, chatLightColor];

  ChatThemeState copyWith({
    Color? chatDeepColor,
    Color? chatLightColor,
  }) {
    return ChatThemeState(
      chatDeepColor: chatDeepColor ?? this.chatDeepColor,
      chatLightColor: chatLightColor ?? this.chatLightColor,
    );
  }
}
