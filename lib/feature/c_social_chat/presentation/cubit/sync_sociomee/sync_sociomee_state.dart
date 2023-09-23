part of 'sync_sociomee_cubit.dart';

enum SyncSociomeeStatus {
  initial,
  loading,
  loaded,
  error,
}

class SyncSociomeeState extends Equatable {
  final SyncSociomeeStatus status;
  final SociomeeUserModel syncResponse;
  final CustomError error;
  final String phone;
  final String socimeeAuthToken;
  final bool isSocimeeAcSynced;
  SyncSociomeeState({
    required this.status,
    required this.syncResponse,
    required this.error,
    required this.phone,
    required this.socimeeAuthToken,
    required this.isSocimeeAcSynced,
  });

  factory SyncSociomeeState.initial() {
    return SyncSociomeeState(
      status: SyncSociomeeStatus.initial,
      error: CustomError(),
      syncResponse: SociomeeUserModel(),
      phone: '',
      socimeeAuthToken: '',
      isSocimeeAcSynced: false,
    );
  }

  SyncSociomeeState copyWith({
    SyncSociomeeStatus? status,
    SyncModel? response,
    SociomeeUserModel? syncResponse,
    CustomError? error,
    String? phone,
    String? socimeeAuthToken,
    bool? isSocimeeAcSynced,
  }) {
    return SyncSociomeeState(
      status: status ?? this.status,
      syncResponse: syncResponse ?? this.syncResponse,
      error: error ?? this.error,
      phone: phone ?? this.phone,
      socimeeAuthToken: socimeeAuthToken ?? this.socimeeAuthToken,
      isSocimeeAcSynced: isSocimeeAcSynced ?? this.isSocimeeAcSynced,
    );
  }

  @override
  List<Object> get props =>
      [status, syncResponse, error, phone, socimeeAuthToken, isSocimeeAcSynced];
}
