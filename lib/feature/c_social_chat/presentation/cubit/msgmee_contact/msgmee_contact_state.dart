
part of 'msgmee_contact_cubit.dart';

enum MsgmeeContactStatus {
  initial,
  loading,
  loaded,
  error,
}

class MsgmeeContactState extends Equatable {
  final MsgmeeContactStatus status;
  final CustomError error;
  final MsgmeeContactModel response;
  MsgmeeContactState({
    required this.status,
    required this.error,
    required this.response,
  });

  factory MsgmeeContactState.initial(){
    return MsgmeeContactState(status: MsgmeeContactStatus.initial, error: CustomError(), response: MsgmeeContactModel());
  }

  MsgmeeContactState copyWith({
    MsgmeeContactStatus? status,
    CustomError? error,
    MsgmeeContactModel? response,
  }) {
    return MsgmeeContactState(
      status: status ?? this.status,
      error: error ?? this.error,
      response: response ?? this.response,
    );
  }

  @override
  List<Object> get props => [status, error, response];
}
