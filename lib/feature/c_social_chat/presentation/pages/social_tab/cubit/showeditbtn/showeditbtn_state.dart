part of 'showeditbtn_cubit.dart';

class ShoweditbtnState extends Equatable {
  final bool show;
  ShoweditbtnState({
    required this.show,
  });

  factory ShoweditbtnState.initial() {
    return ShoweditbtnState(show: false);
  }
  ShoweditbtnState copyWith({
    bool? show,
  }) {
    return ShoweditbtnState(
      show: show ?? this.show,
    );
  }

  @override
  List<Object> get props => [show];
}
