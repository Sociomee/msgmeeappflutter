part of 'sync_sociomee_cubit.dart';

enum SyncSociomeeStatus {
  initial,
  loading,
  loaded,
  error,
}

class SyncSociomeeState extends Equatable {
  final SyncSociomeeStatus status;
  final SyncModel response;
  final SociomeeAccountModel syncResponse;
  final CustomError error;
  SyncSociomeeState({
    required this.status,
    required this.response,
    required this.syncResponse,
    required this.error,
  });

  factory SyncSociomeeState.initial() {
    return SyncSociomeeState(
      status: SyncSociomeeStatus.initial,
      response: SyncModel(),
      error: CustomError(),
      syncResponse: SociomeeAccountModel(),
    );
  }

  SyncSociomeeState copyWith({
    SyncSociomeeStatus? status,
    SyncModel? response,
    SociomeeAccountModel? syncResponse,
    CustomError? error,
  }) {
    return SyncSociomeeState(
      status: status ?? this.status,
      response: response ?? this.response,
      syncResponse: syncResponse ?? this.syncResponse,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, response, syncResponse, error];
}
