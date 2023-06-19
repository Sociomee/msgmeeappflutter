import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../theme/colors.dart';
import '../pages/social_tab/cubit/showeditbtn/showeditbtn_cubit.dart';

class SmallProfileWidget extends StatelessWidget {
  const SmallProfileWidget(
      {super.key,
      required this.imageUrl,
      required this.isOnline,
      required this.isMe,
      required this.hasStory});
  final String imageUrl;
  final bool isOnline;
  final bool isMe;
  final bool hasStory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: isMe
                      ? null
                      : Border.all(color: AppColors.primaryColor, width: 2)),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.grey,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            Positioned(
              top: 40,
              right: 0,
              child: isOnline
                  ? Container(
                      height: 13,
                      width: 13,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.white, width: 2),
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(100)),
                    )
                  : isMe
                      ? InkWell(
                          onTap: () {
                            context.read<ShoweditbtnCubit>().showdialog();
                          },
                          child: Container(
                            height: 19,
                            width: 19,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.white,
                              size: 17,
                            ),
                          ),
                        )
                      : Container(),
            )
          ],
        ),
      ],
    );
  }
}