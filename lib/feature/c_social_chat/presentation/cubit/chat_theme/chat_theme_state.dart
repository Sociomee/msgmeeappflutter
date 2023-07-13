part of 'chat_theme_cubit.dart';

class ChatThemeState extends Equatable {
  final Color chatDeepColor;
  final Color chatLightColor;
  final int selectedTheme;
  ChatThemeState({
    required this.chatDeepColor,
    required this.chatLightColor,
    required this.selectedTheme,
  });
  factory ChatThemeState.initial() {
    return ChatThemeState(
        chatDeepColor: AppColors.darkgreen,
        chatLightColor: AppColors.seconderyColor,
        selectedTheme: 0);
  }

  @override
  List<Object> get props => [chatDeepColor, chatLightColor, selectedTheme];

  ChatThemeState copyWith({
    Color? chatDeepColor,
    Color? chatLightColor,
    int? selectedTheme,
  }) {
    return ChatThemeState(
      chatDeepColor: chatDeepColor ?? this.chatDeepColor,
      chatLightColor: chatLightColor ?? this.chatLightColor,
      selectedTheme: selectedTheme ?? this.selectedTheme,
    );
  }
}
