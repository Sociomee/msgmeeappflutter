part of 'show_emoji_cubit.dart';

class ShowEmojiState extends Equatable {
  final int index;
  final bool showEmoji;
  ShowEmojiState({
    required this.index,
    required this.showEmoji,
  });

  factory ShowEmojiState.initial() {
    return ShowEmojiState(index: -1, showEmoji: false);
  }
  @override
  List<Object> get props => [index, showEmoji];

  ShowEmojiState copyWith({
    int? index,
    bool? showEmoji,
  }) {
    return ShowEmojiState(
      index: index ?? this.index,
      showEmoji: showEmoji ?? this.showEmoji,
    );
  }

  @override
  bool get stringify => true;
}
