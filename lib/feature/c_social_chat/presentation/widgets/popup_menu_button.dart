import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/sycn_with_sociomee.dart';
import 'package:msgmee/feature/c_social_chat/presentation/widgets/sync_msg_dialog.dart';

import '../../../../helper/navigator_function.dart';
import '../pages/broadcast_screen/add_participant_screen.dart';
import '../../../e_settings/pages/connect_webpanel/linked_devices_screen.dart';
import '../pages/new_message_screen.dart';
import '../../../../theme/colors.dart';
import '../../../e_settings/pages/settings/settings_screen.dart';
import '../pages/create_group_page.dart';
import '../pages/social_tab/cubit/sync_msg/sync_msg_cubit.dart';
import '../widgets/social_bottom_model_sheet.dart';

class PopupMenuButtonWidget extends StatefulWidget {
  const PopupMenuButtonWidget({super.key});

  @override
  State<PopupMenuButtonWidget> createState() => _PopupMenuButtonWidgetState();
}

class _PopupMenuButtonWidgetState extends State<PopupMenuButtonWidget> {
  List<ChatOptionsModel> optionswithoutsync = [
    ChatOptionsModel(id: 1, option: 'New Message'),
    ChatOptionsModel(id: 2, option: 'My Notes'),
    ChatOptionsModel(id: 3, option: 'Create New Group'),
    ChatOptionsModel(id: 4, option: 'Link Device'),
    ChatOptionsModel(id: 5, option: 'Create a Broadcast'),
    ChatOptionsModel(id: 6, option: 'Archived Chats'),
    ChatOptionsModel(id: 7, option: 'Sync your Sociomate'),
    ChatOptionsModel(id: 8, option: 'Settings'),
  ];
  List<ChatOptionsModel> options = [
    ChatOptionsModel(id: 1, option: 'New Message'),
    ChatOptionsModel(id: 2, option: 'My Notes'),
    ChatOptionsModel(id: 3, option: 'Create New Group'),
    ChatOptionsModel(id: 4, option: 'Create a Broadcast'),
    ChatOptionsModel(id: 5, option: 'Archived Chats'),
    ChatOptionsModel(id: 6, option: 'Sync your Sociomate'),
    ChatOptionsModel(id: 7, option: 'Settings'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton<int>(
        icon: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        itemBuilder: (context) {
          return context.read<SyncMsgCubit>().state
              ? options
                  .map(
                    (e) => PopupMenuItem(
                        value: e.id,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.option,
                                style: TextStyle(
                                  color: Color(0xFF4E4E4E),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              e.id == 6
                                  ? Text(
                                      'No syncing processed yet',
                                      style: TextStyle(
                                          fontSize: 10, color: AppColors.grey),
                                    )
                                  : Container(),
                              SizedBox(height: 10),
                              e.id == 7
                                  ? Container()
                                  : Divider(
                                      height: 0,
                                      thickness: 1,
                                      color: AppColors.grey.withOpacity(.5))
                            ],
                          ),
                        )),
                  )
                  .toList()
              : optionswithoutsync
                  .map(
                    (e) => PopupMenuItem(
                        value: e.id,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.option,
                                style: TextStyle(
                                  color: Color(0xFF4E4E4E),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              e.id == 7
                                  ? Text(
                                      'No syncing processed yet',
                                      style: TextStyle(
                                          fontSize: 10, color: AppColors.grey),
                                    )
                                  : Container(),
                              SizedBox(height: 10),
                              e.id == 8
                                  ? Container()
                                  : Divider(
                                      height: 0,
                                      thickness: 1,
                                      color: AppColors.grey.withOpacity(.5),
                                    )
                            ],
                          ),
                        )),
                  )
                  .toList();
        },
        offset: Offset(-30, 30),
        color: Colors.white,
        elevation: 2,
        onSelected: context.watch<SyncMsgCubit>().state
            ? (value) {
                if (value == 1) {
                  screenNavigator(context, NewMessageScreen());
                } else if (value == 2) {
                } else if (value == 3) {
                  animatedScreenNavigator(context, CreateGroupPage());
                } else if (value == 4) {
                  animatedScreenNavigator(context, AddParticipantsScreen());
                } else if (value == 5) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SyncDialogWidget();
                      });
                } else if (value == 6) {
                  context.read<SyncWithSociomee>().sync();
                  // screenNavigator(context, LinkedDevicesScreen());
                } else if (value == 7) {
                  screenNavigator(context, SettingScreen());
                }
              }
            : (value) {
                if (value == 1) {
                  screenNavigator(context, NewMessageScreen());
                } else if (value == 2) {
                  animatedScreenNavigator(context, CreateGroupPage());
                } else if (value == 3) {
                } else if (value == 4) {
                  screenNavigator(context, LinkedDevicesScreen());
                } else if (value == 5) {
                  screenNavigator(context, AddParticipantsScreen());
                } else if (value == 6) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SyncDialogWidget();
                      });
                } else if (value == 7) {
                  context.read<SyncWithSociomee>().sync();
                } else if (value == 8) {
                  screenNavigator(context, SettingScreen());
                }
              },
      ),
    );
  }
}
