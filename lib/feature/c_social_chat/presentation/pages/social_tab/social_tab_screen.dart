import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:msgmee/data/model/config_model.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/sync_sociomee/sync_sociomee_cubit.dart';
import 'package:msgmee/helper/context_ext.dart';
import 'package:msgmee/repos/base_repo.dart';
import 'package:msgmee/theme/colors.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/sync_msg/sync_msg_cubit.dart';

import '../../../../../data/sqlite_data_source/sqlite_helper.dart';
import '../../cubit/chatrooms/chatrooms_cubit.dart';
import '../../widgets/sync_loading_widget.dart';
import 'widget/social_chat_widget.dart';
import 'widget/social_stoty_widget.dart';

class SocialTabScreen extends StatefulWidget {
  const SocialTabScreen({super.key});

  @override
  State<SocialTabScreen> createState() => _SocialTabScreenState();
}

class _SocialTabScreenState extends State<SocialTabScreen> {
  late SyncSociomeeCubit cubit;
  @override
  void initState() {
    cubit = context.read<SyncSociomeeCubit>();
    context.read<ChatRoomsCubit>().getPhoneAndUserid();
    context.read<ChatRoomsCubit>().getLocalChatRoomData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        //  !context.watch<SyncMsgCubit>().state
        //     ? Center(
        //         child: SvgPicture.asset('assets/no_msg.svg'),
        //       )
        //     :
        RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: () {
        context.read<ChatRoomsCubit>().getLocalChatRoomData();
        return Future(() {});
      },
      child: context.watch<ChatRoomsCubit>().state.chatroom.length == 0
          ? Column(
              children: [
                SizedBox(
                  height: (context.screenHeight / 2) - 250,
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/no_message.svg',
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
               
              ],
            )
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SocialStoryWidget(),
                      SocialchatWidget(),
                    ],
                  ),
                  if (cubit.state.status == SyncSociomeeStatus.loading)
                    Align(
                      alignment: Alignment.topCenter,
                      child: SyncLoadingWidget(),
                    ),
                ],
              ),
            ),
    );
  }
}
