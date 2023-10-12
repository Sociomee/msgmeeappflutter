// part of 'update_profile_cubit.dart';

// enum UpdateProfileStatus { initial, loading, loaded, error }

// class UpdateProfileState extends Equatable {
//   final UpdateProfileStatus status;
//   final MsgmeeUserModel reponse;
//   final CustomError error;
//   UpdateProfileState({
//     required this.status,
//     required this.reponse,
//     required this.error,
//   });
//   factory UpdateProfileState.initial() {
//     return UpdateProfileState(
//         status: UpdateProfileStatus.initial,
//         reponse: MsgmeeUserModel(),
//         error: CustomError());
//   }

//   UpdateProfileState copyWith({
//     UpdateProfileStatus? status,
//     MsgmeeUserModel? reponse,
//     CustomError? error,
//   }) {
//     return UpdateProfileState(
//       status: status ?? this.status,
//       reponse: reponse ?? this.reponse,
//       error: error ?? this.error,
//     );
//   }

//   @override
//   List<Object> get props => [status, reponse, error];
// }
