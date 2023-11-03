// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'showeditbtn_cubit.dart';

class ShoweditbtnState extends Equatable {
  final bool show;
  final double height;
  ShoweditbtnState({
    required this.show,
    required this.height,
  });

  factory ShoweditbtnState.initial() {
    return ShoweditbtnState(show: false, height: 0);
  }
  ShoweditbtnState copyWith({
    bool? show,
    double? height,
  }) {
    return ShoweditbtnState(
      show: show ?? this.show,
      height: height ?? this.height,
    );
  }

  @override
  List<Object> get props => [show, height];
}
