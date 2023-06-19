import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/sync_msg/sync_msg_cubit.dart';

import '../../../../../theme/colors.dart';
import '../../widgets/sync_loading_widget.dart';
import 'cubit/showeditbtn/showeditbtn_cubit.dart';
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
    return !context.watch<SyncMsgCubit>().state
        ? Center(
            child: SvgPicture.asset('assets/no_msg.svg'),
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
                Align(
                  alignment: Alignment.topCenter,
                  child: SyncLoadingWidget(),
                ),
                Positioned(
                  top: 100,
                  child: AnimatedContainer(
                    height:
                        context.watch<ShoweditbtnCubit>().state.show ? 130 : 0,
                    duration: Duration(milliseconds: 500),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: context.watch<ShoweditbtnCubit>().state.show
                          ? [
                              BoxShadow(
                                  color: AppColors.lightgrey,
                                  offset: Offset(0, 0.5),
                                  blurRadius: 10,
                                  spreadRadius: 5),
                            ]
                          : null,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.black),
                            child: Image.asset('assets/camera1.png'),
                          ),
                          Container(
                            height: 42,
                            width: 42,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 19),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.primaryColor),
                            child: Image.asset('assets/edit1.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
