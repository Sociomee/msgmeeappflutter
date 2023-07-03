import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_textField.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_type.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../../data/model/chat_model.dart';

class ImagePreViewPage extends StatefulWidget {
  const ImagePreViewPage({super.key, this.image, required this.profileImage});
  final File? image;
  final String profileImage;
  @override
  State<ImagePreViewPage> createState() => _ImagePreViewPageState();
}

class _ImagePreViewPageState extends State<ImagePreViewPage> {
  late TextEditingController messageController;
  final ImagePicker _picker = ImagePicker();
  final List<File?> imagelist = [];
  int selectedImage = 0;
  void pickGalleryPic() async {
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagelist.add(File(image.path));
      });
    }
  }

  void pickCameraPic() async {
    // Capture a photo
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        imagelist.add(File(photo.path));
      });
    }
  }

  @override
  void initState() {
    messageController = TextEditingController();
    imagelist.add(widget.image);
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(Icons.arrow_back_ios, color: AppColors.black),
          ),
        ),
        titleSpacing: 0,
        title: CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.grey,
          backgroundImage: NetworkImage(widget.profileImage),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.delete_outline, color: AppColors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.insert_emoticon_outlined, color: AppColors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15, right: 20),
            child: Text(
              'T',
              style: TextStyle(
                  fontSize: 22,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.edit_outlined, color: AppColors.black),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.file(imagelist[selectedImage]!,
                  height: MediaQuery.of(context).size.height * .7,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white),
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 62,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: imagelist.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImage = index;
                                });
                              },
                              child: Container(
                                height: 62,
                                width: 62,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    border: selectedImage == index
                                        ? Border.all(
                                            color: AppColors.darkgreen,
                                            width: 3)
                                        : null,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    imagelist[index]!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }),
                      GestureDetector(
                        onTap: () {
                          pickCameraPic();
                        },
                        child: Container(
                          height: 62,
                          width: 62,
                          decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(.6),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.add,
                            size: 40,
                            color: AppColors.darkgreen,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 40,
              child: MessageTextFieldWidget(
                messageController: messageController,
                color: AppColors.white,
                onChanged: (e) {},
              ),
            )),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () async {
                messages.add(ChatMessage(
                    messageContent: messageController.text,
                    messageType: 'sender',
                    msgStatus: 'send',
                    time: '4:28 pm',
                    type: MessageType.image,
                    image_url: imagelist[selectedImage]!));
                Navigator.pop(context);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: AppColors.lightgrey1,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset('assets/attach.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
