import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../widgets/social_bottom_model_sheet.dart';

class PopupMenuWidget extends StatefulWidget {
  const PopupMenuWidget({super.key});

  @override
  State<PopupMenuWidget> createState() => _PopupMenuWidgetState();
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  final List<ChatOptionsModel> options = [
    ChatOptionsModel(id: 1, option: 'Search'),
    ChatOptionsModel(id: 2, option: 'Clear Chat'),
    ChatOptionsModel(id: 3, option: 'Media, Link & Doc'),
    ChatOptionsModel(id: 4, option: 'Change Wallpaper'),
    ChatOptionsModel(id: 5, option: 'Delete Broadcast'),
  ];
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.more_vert, color: Colors.black),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      constraints: BoxConstraints(
        minWidth: 0.5.sw,
        maxWidth: 0.5.sw,
      ),
      padding: EdgeInsets.all(0),
      itemBuilder: (context) {
        return options
            .map(
              (e) => PopupMenuItem(
                  value: e.id,
                  child: Text(
                    e.option,
                    style: TextStyle(
                      color: Color(0xFF4E4E4E),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            )
            .toList();
      },
      offset: Offset(-30, 44),
      color: Colors.white,
      elevation: 2,
      onSelected: (value) {
        if (value == 1) {
        } else if (value == 2) {
        } else if (value == 3) {
        } else if (value == 4) {
        } else if (value == 5) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'You are  going to delete broadcast!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Delete',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF368C4E),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Divider(color: AppColors.grey, height: 0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF368C4E),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Divider(color: AppColors.grey, height: 0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Learn More',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF2F80ED),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        }
      },
    );
  }
}
