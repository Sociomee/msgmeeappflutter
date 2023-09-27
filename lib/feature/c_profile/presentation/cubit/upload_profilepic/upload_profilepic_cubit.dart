import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'upload_profilepic_state.dart';

// class UploadProfilepicCubit extends Cubit<UploadProfilepicState> {
//   UploadProfilepicCubit() : super(UploadProfilepicState.initial());
//   final ImagePicker _picker = ImagePicker();
//   void pickGalleryImage() async {
//     var image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       emit(state.copyWith(imageFile: File(image.path)));
//     }
//   }

//   void pickCameraImage() async {
//     var photo = await _picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       emit(state.copyWith(imageFile: File(photo.path)));
//     }

//     //
//   }

//   void deleteImage() async {
//     if (state.imageFile != null) {
//       try {
//         state.imageFile!.deleteSync(); // Synchronously delete the image file
//         emit(state.copyWith(imageFile: null));
//       } catch (e) {
//         log('delete error===>$e');
//         emit(state);
//       }
//       log('delete===>${state.imageFile}');
//     }
//   }
// }
class UploadProfilepicCubit extends Cubit<UploadProfilepicState> {
  UploadProfilepicCubit() : super(UploadProfilepicState.initial());
  final ImagePicker _picker = ImagePicker();

  void pickGalleryImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(UploadProfilepicState(imageFile: File(image.path)));
    }
  }

  void pickCameraImage() async {
    var photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      emit(UploadProfilepicState(imageFile: File(photo.path)));
    }
  }

  void deleteImage() {
    if (state.imageFile != null) {
      try {
        state.imageFile!.deleteSync();
        emit(UploadProfilepicState(imageFile: null));
      } catch (e) {
        log('delete error===>$e');
      }
    }
  }
}
