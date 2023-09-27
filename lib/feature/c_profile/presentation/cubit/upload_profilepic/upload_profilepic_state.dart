part of 'upload_profilepic_cubit.dart';

class UploadProfilepicState extends Equatable {
  final File? imageFile;

  UploadProfilepicState({this.imageFile});

  factory UploadProfilepicState.initial() {
    return UploadProfilepicState();
  }

  UploadProfilepicState copyWith({
    File? imageFile,
  }) {
    return UploadProfilepicState(
      imageFile: imageFile ?? this.imageFile,
    );
  }

  @override
  List<Object?> get props => [imageFile];
}
