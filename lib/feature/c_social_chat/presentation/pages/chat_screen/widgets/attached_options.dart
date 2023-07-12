// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/show_attachment.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/doc_sending_page.dart';
import 'package:msgmee/helper/getpdf_size.dart';
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
  String pdfname = '';
  void pickGalleryPic() async {
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      animatedScreenNavigator(
          context,
          ImagePreViewPage(
            image: File(image.path),
            profileImage: widget.profileImage,
          ));
    }
  }

  void pickMultipleGalleryPic() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      animatedScreenNavigator(
          context,
          ImagePreViewPage(
            image: File(images[0].path),
            profileImage: widget.profileImage,
          ));
    }
  }

  void pickCameraPic() async {
    // Capture a photo
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      animatedScreenNavigator(
          context,
          ImagePreViewPage(
            image: File(photo.path),
            profileImage: widget.profileImage,
          ));
    }
  }

  pickdoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      String? path = file.path;
      String? size = getFileSize(File(result.files[0].path!));

      setState(() {
        pdfname = path!.split('/').last;
      });
      animatedScreenNavigator(
          context, DocSendingPage(pftname: "${pdfname}/${size}"));
    } else {
      // User canceled file picking
      print('No PDF file selected');
    }
  }

  pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
      allowMultiple: false,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      String? path = file.path;
      String? size = getFileSize(File(result.files.single.path!));

      setState(() {
        pdfname = path!.split('/').last;
      });
      animatedScreenNavigator(
          context, DocSendingPage(pftname: "${pdfname}/${size}"));
    } else {
      // User canceled file picking
      print('No PDF file selected');
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
                pickAudio();
                // context.read<ShowAudioRecorder>().toggleValue();
                context.read<ShowAttachment>().toggleValue();
              } else if (index == 1) {
                pickCameraPic();
                context.read<ShowAttachment>().toggleValue();
              } else if (index == 2) {
                animatedScreenNavigator(context, AttachContactPage());
                context.read<ShowAttachment>().toggleValue();
              } else if (index == 3) {
                pickGalleryPic();
                context.read<ShowAttachment>().toggleValue();
              } else if (index == 4) {
                pickdoc();
                context.read<ShowAttachment>().toggleValue();
              } else if (index == 5) {
                animatedScreenNavigator(context, AttachLocationPage());
                context.read<ShowAttachment>().toggleValue();
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
