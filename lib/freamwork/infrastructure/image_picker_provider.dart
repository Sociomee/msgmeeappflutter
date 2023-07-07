import 'package:image_picker/image_picker.dart';

class ImagePickerSingleton {
  static final ImagePickerSingleton _instance =
      ImagePickerSingleton._internal();
  final ImagePicker _imagePicker = ImagePicker();

  factory ImagePickerSingleton() {
    return _instance;
  }

  ImagePickerSingleton._internal();

  Future<String?> pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    return pickedFile?.path;
  }

  // Rest of the class implementation...
}
