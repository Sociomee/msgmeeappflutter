import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/data/model/dummy_chat_model.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/selectedchat/selectedchat_cubit.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../widgets/chat_profile_widget.dart';
import '../../../widgets/profile_image_view_dialog.dart';
import '../../chat_screen/chat_screen.dart';

class SocialchatWidget extends StatefulWidget {
  const SocialchatWidget({super.key});

  @override
  State<SocialchatWidget> createState() => _SocialchatWidgetState();
}

class _SocialchatWidgetState extends State<SocialchatWidget> {
  @override
  Widget build(BuildContext context) {
    var selectcubit = context.watch<SelectedchatCubit>().state;
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onLongPress: () {
                  print(
                      "----->>>>>${context.read<SelectedchatCubit>().state.selectedchat}${context.read<SelectedchatCubit>().state.selctmode}");
                  if (!context
                      .read<SelectedchatCubit>()
                      .state
                      .selectedchat
                      .contains(index)) {
                    context.read<SelectedchatCubit>().selectmode();
                    context.read<SelectedchatCubit>().select(index);
                  } else if (context
                      .read<SelectedchatCubit>()
                      .state
                      .selectedchat
                      .contains(index)) {
                    context.read<SelectedchatCubit>().remove(index);
                  }
                },
                onTap: () {
                  if (context
                      .read<SelectedchatCubit>()
                      .state
                      .selectedchat
                      .contains(index)) {
                    context.read<SelectedchatCubit>().remove(index);

                    print(context.read<SelectedchatCubit>().state.selctmode);
                  } else if (context
                      .read<SelectedchatCubit>()
                      .state
                      .selctmode) {
                    context.read<SelectedchatCubit>().select(index);
                  } else if (context
                              .read<SelectedchatCubit>()
                              .state
                              .selectedchat
                              .length ==
                          1 &&
                      context.read<SelectedchatCubit>().state.selctmode) {
                    context.read<SelectedchatCubit>().selectmode();
                  } else {
                    screenNavigator(
                        context,
                        ChatScreen(
                          name: dummyData[index].name,
                          imageUrl: dummyData[index].imageUrl,
                          isOnline: dummyData[index].isOnline,
                          hasStory: dummyData[index].hasStory,
                        ));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: context
                              .watch<SelectedchatCubit>()
                              .state
                              .selectedchat
                              .contains(index)
                          ? AppColors.selectedChatColor
                          : AppColors.white),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => ProfileViewDialog(
                                    profilename: dummyData[index].name,
                                    imageUrl: dummyData[index].imageUrl,
                                  ));
                        },
                        child: ChatProfileWidget(
                            imageUrl: dummyData[index].imageUrl,
                            isOnline: dummyData[index].isOnline,
                            hasStory: dummyData[index].hasStory),
                      ),
                      SizedBox(width: 13),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(dummyData[index].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              selectcubit.starClicked &&
                                      selectcubit.selectedchat.contains(index)
                                  ? Icon(Icons.star,
                                      color: AppColors.primaryColor, size: 16)
                                  : Container(),
                              selectcubit.pinned &&
                                      selectcubit.selectedchat.contains(index)
                                  ? Transform.rotate(
                                      angle: pi / 4,
                                      child: Icon(Icons.push_pin,
                                          color: AppColors.primaryColor,
                                          size: 16),
                                    )
                                  : Container()
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(dummyData[index].message,
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.grey)),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(dummyData[index].time,
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.grey)),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              selectcubit.mute &&
                                      selectcubit.selectedchat.contains(index)
                                  ? SvgPicture.asset('assets/mute.svg')
                                  : Container(),
                              SizedBox(width: 5),
                              dummyData[index].unseenMessage != 0
                                  ? Container(
                                      height: 20,
                                      // width: 20,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 6),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Text(
                                          dummyData[index]
                                              .unseenMessage
                                              .toString(),
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  : Container(),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                  height: 0,
                  thickness: 1,
                  color: Color(0xFFE4E4E4).withOpacity(.5)),
            ],
          );
        });
  }
}
