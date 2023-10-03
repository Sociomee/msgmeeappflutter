import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/archived_list_screen.dart';
import 'package:msgmee/feature/c_social_chat/presentation/widgets/sync_msg_dialog.dart';
import 'package:msgmee/helper/string_ext.dart';

import '../../../../helper/navigator_function.dart';
import '../../../e_settings/pages/connect_webpanel/linked_devices_screen.dart';
import '../cubit/sync_sociomee/sync_sociomee_cubit.dart';
import '../pages/broadcast_screen/add_participant_screen.dart';
import '../pages/new_message_screen.dart';
import '../../../e_settings/pages/settings/settings_screen.dart';
import '../pages/create_group_page.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var synctime =
        context.read<SyncSociomeeCubit>().state.syncResponse.isMigratedOn;
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        child: PopupMenuButton<int>(
          icon: Icon(Icons.more_vert, color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          constraints: BoxConstraints(
            minWidth: 0.5.sw,
            maxWidth: 0.5.sw,
          ),
          padding: EdgeInsets.all(0),
          itemBuilder: (context) {
            return
                // context.watch<SyncSociomeeCubit>().state.isSocimeeAcSynced
                //     ?
                optionswithoutsync
                    .map(
                      (e) => PopupMenuItem(
                          value: e.id,
                          height: 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  ? SizedBox(
                                      width: 130,
                                      child: Text(
                                        context
                                                    .read<SyncSociomeeCubit>()
                                                    .state
                                                    .syncResponse
                                                    .isMigratedOn ==
                                                null
                                            ? 'No syncing processed yet'
                                            : "Last migrated on ${synctime!.createdAt.toString().toDateTime()}",
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          color: Color(0xB24E4E4E),
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(height: 12),
                              e.id == 8
                                  ? Container()
                                  : Divider(
                                      height: 0,
                                      thickness: 1,
                                      color: Color.fromARGB(255, 230, 230, 230),
                                    ),
                              e.id == 8 ? Container() : SizedBox(height: 10),
                            ],
                          )),
                    )
                    .toList();
            // : optionswithoutsync
            //     .map(
            //       (e) => PopupMenuItem(
            //           value: e.id,
            //           height: 35,
            //           child: Center(
            //             child: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   e.option,
            //                   style: TextStyle(
            //                     color: Color(0xFF4E4E4E),
            //                     fontSize: 14,
            //                     fontFamily: 'Poppins',
            //                     fontWeight: FontWeight.w400,
            //                   ),
            //                 ),
            //                 e.id == 7
            //                     ? Text(
            //                         'No syncing processed yet',
            //                         style: TextStyle(
            //                           color: Color(0xB24E4E4E),
            //                           fontSize: 10,
            //                           fontStyle: FontStyle.italic,
            //                           fontFamily: 'Poppins',
            //                           fontWeight: FontWeight.w400,
            //                         ),
            //                       )
            //                     : Container(),
            //                 SizedBox(height: 10),
            //                 e.id == 8
            //                     ? Container()
            //                     : Divider(
            //                         height: 0,
            //                         thickness: 1,
            //                         color: AppColors.grey.withOpacity(.5),
            //                       )
            //               ],
            //             ),
            //           )),
            //     )
            //     .toList();
          },
          offset: Offset(-30, 35),
          color: Colors.white,
          elevation: 2,
          onSelected:
              //  context.watch<SyncSociomeeCubit>().state.isSocimeeAcSynced
              //     ?
              //     (value) {
              //   if (value == 1) {
              //     screenNavigator(context, NewMessageScreen());
              //   } else if (value == 2) {
              //   } else if (value == 3) {
              //     animatedScreenNavigator(context, CreateGroupPage());
              //   } else if (value == 4) {
              //     animatedScreenNavigator(context, AddParticipantsScreen());
              //   } else if (value == 5) {
              //     animatedScreenNavigator(context, ArchivedListScreen());
              //   } else if (value == 6) {
              //     showDialog(
              //         context: context,
              //         builder: (context) {
              //           return SyncDialogWidget();
              //         });
              //   } else if (value == 7) {
              //     screenNavigator(context, SettingScreen());
              //   }
              // }
              // :
              (value) {
            if (value == 1) {
              screenNavigator(context, NewMessageScreen());
            } else if (value == 2) {
            } else if (value == 3) {
              animatedScreenNavigator(context, CreateGroupPage());
            } else if (value == 4) {
              screenNavigator(context, LinkedDevicesScreen());
            } else if (value == 5) {
              screenNavigator(context, AddParticipantsScreen());
            } else if (value == 6) {
              animatedScreenNavigator(context, ArchivedListScreen());
            } else if (value == 7) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SyncDialogWidget();
                  });
            } else if (value == 8) {
              screenNavigator(context, SettingScreen());
            }
          },
        ),
      ),
    );
  }
}
