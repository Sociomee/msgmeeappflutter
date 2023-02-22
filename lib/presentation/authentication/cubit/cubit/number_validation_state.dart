part of 'number_validation_cubit.dart';

class NumberValidationState extends Equatable {
  final bool isvalid;
  const NumberValidationState({
    required this.isvalid,
  });

  factory NumberValidationState.initial() {
    return const NumberValidationState(isvalid: false);
  }
  @override
  List<Object> get props => [isvalid];

  NumberValidationState copyWith({
    bool? isvalid,
  }) {
    return NumberValidationState(
      isvalid: isvalid ?? this.isvalid,
    );
  }
}
