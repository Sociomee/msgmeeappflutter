// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sync_sociomee_cubit.dart';

enum SyncSociomeeStatus {
  initial,
  loading,
  loaded,
  error,
}

enum CheckSociomeeStatus {
  initial,
  loading,
  loaded,
  error,
}

class SyncSociomeeState extends Equatable {
  final SyncSociomeeStatus status;
  final SociomeeUserModel syncResponse;
  final CheckSociomeeStatus checkStatus;
  final CustomError error;
  final String phone;
  final String socimeeAuthToken;
  final bool isSocimeeAcSynced;
  final double processend;
  final StreamController<double> _progressController =
      StreamController<double>();
  Stream<double> get progressStream => _progressController.stream;

  SyncSociomeeState({
    required this.status,
    required this.syncResponse,
    required this.checkStatus,
    required this.error,
    required this.phone,
    required this.socimeeAuthToken,
    required this.isSocimeeAcSynced,
    required this.processend,
  });

  factory SyncSociomeeState.initial() {
    return SyncSociomeeState(
      status: SyncSociomeeStatus.initial,
      error: CustomError(),
      syncResponse: SociomeeUserModel(),
      checkStatus: CheckSociomeeStatus.initial,
      phone: '',
      socimeeAuthToken: '',
      isSocimeeAcSynced: false,
      processend: 0,
    );
  }

  SyncSociomeeState copyWith({
    SyncSociomeeStatus? status,
    SociomeeUserModel? syncResponse,
    CheckSociomeeStatus? checkStatus,
    CustomError? error,
    String? phone,
    String? socimeeAuthToken,
    bool? isSocimeeAcSynced,
    double? processend,
  }) {
    return SyncSociomeeState(
      status: status ?? this.status,
      syncResponse: syncResponse ?? this.syncResponse,
      checkStatus: checkStatus ?? this.checkStatus,
      error: error ?? this.error,
      phone: phone ?? this.phone,
      socimeeAuthToken: socimeeAuthToken ?? this.socimeeAuthToken,
      isSocimeeAcSynced: isSocimeeAcSynced ?? this.isSocimeeAcSynced,
      processend: processend ?? this.processend,
    );
  }

  @override
  List<Object> get props => [
        status,
        syncResponse,
        checkStatus,
        error,
        phone,
        socimeeAuthToken,
        isSocimeeAcSynced,
        processend
      ];
}
