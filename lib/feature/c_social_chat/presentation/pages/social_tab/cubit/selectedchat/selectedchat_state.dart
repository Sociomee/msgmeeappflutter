
part of 'selectedchat_cubit.dart';

class SelectedchatState extends Equatable {
  final List<int> selectedchat;
  final bool starClicked;
  final bool mute;
  SelectedchatState({
    required this.selectedchat,
    required this.starClicked,
    required this.mute,
  });
  factory SelectedchatState.initial() {
    return SelectedchatState(selectedchat: [], starClicked: false, mute: false);
  }

  @override
  List<Object> get props => [selectedchat, starClicked, mute];

  SelectedchatState copyWith({
    List<int>? selectedchat,
    bool? starClicked,
    bool? mute,
  }) {
    return SelectedchatState(
      selectedchat: selectedchat ?? this.selectedchat,
      starClicked: starClicked ?? this.starClicked,
      mute: mute ?? this.mute,
    );
  }
}
