// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  final List<OnboardingModel> items;
  final int currentIndex;
  OnboardingState({
    required this.items,
    required this.currentIndex,
  });

  factory OnboardingState.initial() =>
      OnboardingState(items: [], currentIndex: 1);

  OnboardingState copyWith({
    List<OnboardingModel>? items,
    int? currentIndex,
  }) {
    return OnboardingState(
      items: items ?? this.items,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [items, currentIndex];
}
