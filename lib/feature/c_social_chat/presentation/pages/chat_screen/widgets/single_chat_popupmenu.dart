import 'package:flutter/material.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/export_chat_dialog.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/media_doc_screen/media_and_doc_screen.dart';
import '../../../../../../helper/navigator_function.dart';
import '../../../widgets/social_bottom_model_sheet.dart';
import '../../chat_theme/chat_theme_page.dart';

class SinglechatPopupMenu extends StatefulWidget {
  const SinglechatPopupMenu({super.key, required this.name});
  final String name;
  @override
  State<SinglechatPopupMenu> createState() => _SinglechatPopupMenuState();
}

class _SinglechatPopupMenuState extends State<SinglechatPopupMenu> {
  List<ChatOptionsModel> options = [
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
      child: PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
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
          } else if (value == 2) {
          } else if (value == 3) {
            animatedScreenNavigator(context, ChatThemePage());
          } else if (value == 4) {
            // animatedScreenNavigator(context, AddParticipantsScreen());
          } else if (value == 5) {
            showDialog(
                context: context,
                builder: (context) {
                  return ExportChatDialog();
                });
          } else if (value == 6) {
            screenNavigator(
                context, MediaAndDocScreen(profilename: widget.name));
          }
        },
      ),
    );
  }
}
