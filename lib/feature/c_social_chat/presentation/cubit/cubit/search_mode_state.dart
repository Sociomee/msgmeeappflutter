// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'search_mode_cubit.dart';

class SearchModeState extends Equatable {
  final bool msgSearchMode;
  final bool chatuserSearchMode;
  SearchModeState({
    required this.msgSearchMode,
    required this.chatuserSearchMode,
  });

  factory SearchModeState.initial() {
    return SearchModeState(msgSearchMode: false, chatuserSearchMode: false);
  }
  @override
  List<Object> get props => [msgSearchMode, chatuserSearchMode];

  SearchModeState copyWith({
    bool? msgSearchMode,
    bool? chatuserSearchMode,
  }) {
    return SearchModeState(
      msgSearchMode: msgSearchMode ?? this.msgSearchMode,
      chatuserSearchMode: chatuserSearchMode ?? this.chatuserSearchMode,
    );
  }
}
