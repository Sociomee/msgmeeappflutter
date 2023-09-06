// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'interest_cubit.dart';

enum InterestStatus { initial, loading, loaded, error }

class InterestState extends Equatable {
  final InterestStatus status;
  final CustomError error;
  final InterestsModel response;
  final List<InterestData> intersts;
  InterestState({
    required this.status,
    required this.error,
    required this.response,
    required this.intersts,
  });

  factory InterestState.initial() {
    return InterestState(
        status: InterestStatus.initial,
        error: CustomError(),
        response: InterestsModel(),
        intersts: []);
  }

  InterestState copyWith({
    InterestStatus? status,
    CustomError? error,
    InterestsModel? response,
    List<InterestData>? intersts,
  }) {
    return InterestState(
      status: status ?? this.status,
      error: error ?? this.error,
      response: response ?? this.response,
      intersts: intersts ?? this.intersts,
    );
  }

  @override
  List<Object> get props => [status, error, response, intersts];
}
