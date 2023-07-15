import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/sync_msg/sync_msg_cubit.dart';

import 'widget/social_chat_widget.dart';
import 'widget/social_stoty_widget.dart';

class SocialTabScreen extends StatefulWidget {
  const SocialTabScreen({super.key});

  @override
  State<SocialTabScreen> createState() => _SocialTabScreenState();
}

class _SocialTabScreenState extends State<SocialTabScreen> {
  @override
  Widget build(BuildContext context) {
    return
        //  !context.watch<SyncMsgCubit>().state
        //     ? Center(
        //         child: SvgPicture.asset('assets/no_msg.svg'),
        //       )
        //     :
        SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              SocialStoryWidget(),
              SocialchatWidget(),
            ],
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: SyncLoadingWidget(),
          // ),
        ],
      ),
    );
  }
}
