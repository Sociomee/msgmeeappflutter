import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/create_group_page.dart';

import 'package:msgmee/feature/c_social_chat/presentation/pages/media_doc_screen/media_and_doc_screen.dart';
import 'package:msgmee/theme/colors.dart';
import '../../../../../../helper/navigator_function.dart';
import '../../../cubit/search_mode/search_mode_cubit.dart';
import '../../../cubit/show_attachment.dart';
import '../../../widgets/social_bottom_model_sheet.dart';
import '../../chat_theme/chat_theme_page.dart';
import '../../chat_theme/chat_wallpaper_page.dart';
import 'block_user_popup.dart';

class SinglechatPopupMenu extends StatefulWidget {
  const SinglechatPopupMenu(
      {super.key, required this.name, required this.imageUrl});
  final String name;
  final String imageUrl;
  @override
  State<SinglechatPopupMenu> createState() => _SinglechatPopupMenuState();
}

class _SinglechatPopupMenuState extends State<SinglechatPopupMenu> {
  bool selected = false;
  List<ChatOptionsModel> options = [
    ChatOptionsModel(id: 1, option: 'Search'),
    ChatOptionsModel(id: 2, option: 'Mute Messages'),
    ChatOptionsModel(id: 3, option: 'Clear Chats'),
    ChatOptionsModel(id: 4, option: 'Block This User'),
    ChatOptionsModel(id: 5, option: 'Chat Theme'),
    ChatOptionsModel(id: 6, option: 'Change Wallpaper'),
    ChatOptionsModel(id: 7, option: 'Create Groups'),
    ChatOptionsModel(id: 8, option: 'Media, links and docs'),
  ];
  final String url =
      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ShowAttachment>().closeAttachment();
      },
      child: PopupMenuButton(
        icon: Icon(Icons.more_vert, color: Colors.black),
        offset: Offset(0, 30),
        color: Colors.white,
        onOpened: () {
          context.read<ShowAttachment>().closeAttachment();
        },
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
        onSelected: (value) {
          if (value == 1) {
            context.read<SearchModeCubit>().changemsgSearchMode();
          } else if (value == 2) {
          } else if (value == 3) {
          } else if (value == 4) {
            showDialog(
                context: context,
                builder: (context) {
                  return BlockUserPopupWidget();
                });
          } else if (value == 5) {
            animatedScreenNavigator(context, ChatThemePage());
          } else if (value == 6) {
            animatedScreenNavigator(context, ChangeWallPaperPage());
          } else if (value == 7) {
            showDialog(
                context: context,
                builder: (context) {
                  return createGroup(context);
                });
          } else if (value == 8) {
            screenNavigator(
                context, MediaAndDocScreen(profilename: widget.name));
          }
        },
      ),
    );
  }

  Widget createGroup(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You and Abriella Bond are going to create a new group...',
            style: TextStyle(
              color: Color(0xFF111111),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: 200,
              height: 110,
              child: Stack(
                children: [
                  Positioned(
                    left: 90,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: AppColors.primaryColor, width: 2)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          url,
                          width: 98,
                          height: 98,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColors.white, width: 2)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        widget.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 42),
          GestureDetector(
              onTap: () {
                animatedScreenNavigator(context, CreateGroupPage());
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.primaryColor),
                  alignment: Alignment.center,
                  child: Text('Proceed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600)))),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.white),
              alignment: Alignment.center,
              child: Text(
                'Cancel',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GroupchatPopupMenu extends StatefulWidget {
  const GroupchatPopupMenu(
      {super.key, required this.name, required this.imageUrl});
  final String name;
  final String imageUrl;
  @override
  State<GroupchatPopupMenu> createState() => _GroupchatPopupMenuState();
}

class _GroupchatPopupMenuState extends State<GroupchatPopupMenu> {
  bool selected = false;
  List<ChatOptionsModel> options = [
    ChatOptionsModel(id: 1, option: 'Search'),
    ChatOptionsModel(id: 2, option: 'Mute Messages'),
    ChatOptionsModel(id: 3, option: 'Clear Chats'),
    ChatOptionsModel(id: 4, option: 'Block This Group'),
    ChatOptionsModel(id: 5, option: 'Chat Theme'),
    ChatOptionsModel(id: 6, option: 'Change Wallpaper'),
    ChatOptionsModel(id: 7, option: 'Export Chat'),
    ChatOptionsModel(id: 8, option: 'Add Shortcut'),
    ChatOptionsModel(id: 9, option: 'Media, links and docs'),
  ];
  final String url =
      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ShowAttachment>().closeAttachment();
      },
      child: PopupMenuButton(
        icon: Icon(Icons.more_vert, color: Colors.black),
        offset: Offset(-23.5, 40),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
        onSelected: (value) {
          if (value == 1) {
            context.read<SearchModeCubit>().changemsgSearchMode();
          } else if (value == 2) {
          } else if (value == 3) {
          } else if (value == 4) {
            showDialog(
                context: context,
                builder: (context) {
                  return BlockUserPopupWidget();
                });
          } else if (value == 5) {
            animatedScreenNavigator(context, ChatThemePage());
          } else if (value == 6) {
            animatedScreenNavigator(context, ChangeWallPaperPage());
          } else if (value == 9) {
            screenNavigator(
                context, MediaAndDocScreen(profilename: widget.name));
          }
        },
      ),
    );
  }
}
