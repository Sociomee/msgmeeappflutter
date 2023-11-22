part of 'typing_cubit.dart';

abstract class TypingState extends Equatable {
  const TypingState();

  @override
  List<Object> get props => [];
}

class TypingInitial extends TypingState {

}

class TypingStartState extends TypingState {
  
  final TypingStatus typingStatus;
   TypingStartState({required this.typingStatus});
   @override
  List<Object> get props => [typingStatus];
}

class TypingEndState extends TypingState {
  final TypingStatus typingStatus;

  TypingEndState({required this.typingStatus});
   @override
  List<Object> get props => [typingStatus];
}
