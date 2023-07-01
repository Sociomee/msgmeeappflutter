// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/doc_sending_page.dart';
import 'package:msgmee/helper/navigator_function.dart';

import '../attach_contact_page.dart';
import '../attach_location_page.dart';
import '../image_preview_page.dart';

List<String> attachments = [
  'assets/attachment6.svg',
  'assets/attachment5.svg',
  'assets/attachment4.svg',
  'assets/attachment3.svg',
  'assets/attachment2.svg',
  'assets/attachment1.svg',
];

class CustomIcons {
  final String icons;
  final Color color;
  final String title;
  CustomIcons({
    required this.icons,
    required this.color,
    required this.title,
  });
}

class AttachedIcon extends StatefulWidget {
  const AttachedIcon({super.key, required this.profileImage});
  final String profileImage;
  @override
  State<AttachedIcon> createState() => _AttachedIconState();
}

class _AttachedIconState extends State<AttachedIcon> {
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  void pickGalleryPic() async {
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
      animatedScreenNavigator(
          context,
          ImagePreViewPage(
            image: imageFile,
            profileImage: widget.profileImage,
          ));
    }
  }

  void pickCameraPic() async {
    // Capture a photo
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
      });
      animatedScreenNavigator(
          context,
          ImagePreViewPage(
            image: imageFile,
            profileImage: widget.profileImage,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: attachments.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
              } else if (index == 1) {
                pickCameraPic();
              } else if (index == 2) {
                animatedScreenNavigator(context, AttachContactPage());
              } else if (index == 3) {
                pickGalleryPic();
              } else if (index == 4) {
                animatedScreenNavigator(context, DocSendingPage());
              } else if (index == 5) {
                animatedScreenNavigator(context, AttachLocationPage());
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(attachments[index]),
              ],
            ),
          );
        });
  }
}
