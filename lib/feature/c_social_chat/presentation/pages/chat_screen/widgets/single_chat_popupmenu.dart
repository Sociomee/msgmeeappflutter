import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/common_widgets/checkbox_widget.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/create_group_page.dart';

import 'package:msgmee/feature/c_social_chat/presentation/pages/media_doc_screen/media_and_doc_screen.dart';
import '../../../../../../helper/navigator_function.dart';
import '../../../cubit/cubit/search_mode_cubit.dart';
import '../../../widgets/social_bottom_model_sheet.dart';
import '../../chat_theme/chat_theme_page.dart';
import '../../chat_theme/chat_wallpaper_page.dart';

class SinglechatPopupMenu extends StatefulWidget {
  const SinglechatPopupMenu({super.key, required this.name});
  final String name;
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton(
        icon: Icon(Icons.more_vert, color: Colors.black),
        offset: Offset(0, 30),
        color: Colors.white,
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
                  return blockUserDialog(context);
                });
          } else if (value == 5) {
            animatedScreenNavigator(context, ChatThemePage());
          } else if (value == 6) {
            animatedScreenNavigator(context, ChangeWallPaperPage());
          } else if (value == 7) {
            animatedScreenNavigator(context, CreateGroupPage());
          } else if (value == 8) {
            screenNavigator(
                context, MediaAndDocScreen(profilename: widget.name));
          }
        },
      ),
    );
  }

  Widget blockUserDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You are going to block this contact. You cannot call and chats to this contact after blocking.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(
                  width: 16,
                  child: CheckBoxWidget(
                    selected: selected,
                    onChange: (e) {
                      setState(() {
                        selected = !selected;
                      });
                    },
                  )),
              SizedBox(width: 8),
              Text(
                'Report contact',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF368C4E),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 42),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Block',
                  style: TextStyle(
                    color: Color(0xFF368C4E),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
