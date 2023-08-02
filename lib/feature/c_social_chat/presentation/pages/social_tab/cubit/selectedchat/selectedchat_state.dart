// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'selectedchat_cubit.dart';

class SelectedchatState extends Equatable {
  final List<int> selectedchat;
  final bool starClicked;
  final bool mute;
  final bool pinned;
  final bool selctmode;

  SelectedchatState(
      {required this.selectedchat,
      required this.starClicked,
      required this.mute,
      required this.pinned,
      required this.selctmode});
  factory SelectedchatState.initial() {
    return SelectedchatState(
        selectedchat: [],
        starClicked: false,
        mute: false,
        pinned: false,
        selctmode: false);
  }

  @override
  List<Object> get props =>
      [selectedchat, starClicked, mute, pinned, selctmode];

  SelectedchatState copyWith({
    List<int>? selectedchat,
    bool? starClicked,
    bool? mute,
    bool? pinned,
    bool? selectmode,
  }) {
    return SelectedchatState(
        selectedchat: selectedchat ?? this.selectedchat,
        starClicked: starClicked ?? this.starClicked,
        mute: mute ?? this.mute,
        pinned: pinned ?? this.pinned,
        selctmode: selectmode ?? this.selctmode);
  }
}
