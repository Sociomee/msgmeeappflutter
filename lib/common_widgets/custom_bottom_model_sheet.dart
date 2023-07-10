import 'package:flutter/material.dart';
import 'package:msgmee/theme/colors.dart';

class CustomBottomModelSheet extends StatelessWidget {
  const CustomBottomModelSheet(
      {super.key, required this.cameraClick, required this.galleryClick});
  final VoidCallback cameraClick;
  final VoidCallback galleryClick;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lightgrey),
          ),
          SizedBox(height: 10),
          const Text(
            'Select Media From?',
            textScaleFactor: 1.0,
            style: TextStyle(fontSize: 16),
          ),
          const Text(
            'Use camera or select file from device gallery',
            textScaleFactor: 1.0,
            style: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 109, 109, 109)),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: cameraClick,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.lightgrey.withOpacity(.4),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lightgrey.withOpacity(.5),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.camera_alt, size: 30),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Camera',
                      textScaleFactor: 1.0,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: galleryClick,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lightgrey.withOpacity(.5),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.image,
                        // Icons.folder_open_outlined,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Gallery',
                      textScaleFactor: 1.0,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
