import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helper/navigator_function.dart';
import '../cubit/search_mode/search_mode_cubit.dart';
import '../pages/chat_theme/chat_theme_page.dart';
import '../pages/chat_theme/chat_wallpaper_page.dart';
import '../pages/media_doc_screen/media_and_doc_screen.dart';
import 'social_bottom_model_sheet.dart';

class MyNotesPopUp extends StatelessWidget {
  MyNotesPopUp({super.key});

  final List<ChatOptionsModel> options = [
    ChatOptionsModel(id: 1, option: 'Search'),
    ChatOptionsModel(id: 2, option: 'Clear Notes'),
    ChatOptionsModel(id: 3, option: 'Chat Theme'),
    ChatOptionsModel(id: 4, option: 'Change Wallpaper'),
    ChatOptionsModel(id: 5, option: 'Export Chats'),
    ChatOptionsModel(id: 6, option: 'Media, links and docs'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton<int>(
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
                    height: 35,
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
        offset: Offset(-30, 0),
        color: Colors.white,
        elevation: 2,
        onSelected: (value) {
          if (value == 1) {
            context.read<SearchModeCubit>().changemsgSearchMode();
          } else if (value == 2) {
          } else if (value == 3) {
            animatedScreenNavigator(context, ChatThemePage());
          } else if (value == 4) {
            animatedScreenNavigator(context, ChangeWallPaperPage());
          } else if (value == 5) {
          } else if (value == 6) {
            screenNavigator(context, MediaAndDocScreen(profilename: 'You'));
          }
        },
      ),
    );
  }
}
