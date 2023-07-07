import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/choose_image_wallpaper_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/choose_solid_color_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/set_chatbg/set_chatbg_cubit.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_theme/solid_color_page.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_theme/wallpaper_image_page.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_theme/widget/chat_bg_type.dart';

import '../../../../../../helper/navigator_function.dart';
import '../../../../../../theme/colors.dart';
import '../../../cubit/change_wallpaperview.dart';

class WallpaperOptionsWidget extends StatefulWidget {
  const WallpaperOptionsWidget({super.key});

  @override
  State<WallpaperOptionsWidget> createState() => _WallpaperOptionsWidgetState();
}

class _WallpaperOptionsWidgetState extends State<WallpaperOptionsWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  int click = 0;
  void pickGalleryPic() async {
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String phoneImg =
        'https://images.pexels.com/photos/1366630/pexels-photo-1366630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
    var type = context.watch<SetChatbgCubit>().state;
    var networkwallpaper = context.watch<ChooseImageWallpaperCubit>().state;
    var solidColor = context.watch<ChooseSolidColorCubit>().state;
    print(solidColor);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    click = 0;
                  });
                  animatedScreenNavigator(context, SolidColorPage());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: context.watch<ChooseSolidColorCubit>().state),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Solid Colors',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    click = 1;
                  });
                  animatedScreenNavigator(context, WallPaparImagePage());
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          context.watch<ChooseImageWallpaperCubit>().state,
                          height: 180,
                          width: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Wallpapers',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ]),
              )
            ],
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                click = 2;
              });
              pickGalleryPic();
            },
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imageFile != null
                      ? Image.file(
                          File(imageFile!.path),
                          height: 180,
                          width: 180,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          phoneImg,
                          height: 180,
                          width: 180,
                          fit: BoxFit.cover,
                        )),
              SizedBox(height: 5),
              Text(
                'My Phone',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              )
            ]),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              print(type.bgType);
              if (imageFile != null && click == 2) {
                context
                    .read<SetChatbgCubit>()
                    .getChatBg(imageFile, ChatBgType.fileImage);
                context.read<ChangeWallPaperView>().changeView();
              } else if (networkwallpaper.isNotEmpty && click == 1) {
                context
                    .read<SetChatbgCubit>()
                    .getChatBg(networkwallpaper, ChatBgType.networkImage);
                context.read<ChangeWallPaperView>().changeView();
              } else if (click == 0) {
                context
                    .read<SetChatbgCubit>()
                    .getChatBg(solidColor, ChatBgType.solidColor);
                context.read<ChangeWallPaperView>().changeView();
              }
            },
            child: Center(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primaryColor,
                      border: Border.all(color: AppColors.primaryColor)),
                  child: Text(
                    'Set Default Wallpaper',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  )),
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
