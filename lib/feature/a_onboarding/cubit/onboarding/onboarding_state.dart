part of 'onboarding_cubit.dart';



class OnboardingState extends Equatable {
  final List<OnboardingModel> items;
  OnboardingState({
    required this.items,
  });

  factory OnboardingState.initial() => OnboardingState(items: []);

  OnboardingState copyWith({
    List<OnboardingModel>? items,
  }) {
    return OnboardingState(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];
}
