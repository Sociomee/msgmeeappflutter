import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseImageWallpaperCubit extends Cubit<String> {
  ChooseImageWallpaperCubit()
      : super(
            'https://images.pexels.com/photos/1624438/pexels-photo-1624438.jpeg?auto=compress&cs=tinysrgb&w=600');
  void chooseImage(String imageUrl) {
    emit(imageUrl);
  }
}
