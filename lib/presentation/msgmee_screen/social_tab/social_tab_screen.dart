import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/presentation/msgmee_screen/social_tab/cubit/showeditbtn/showeditbtn_cubit.dart';

import '../../../theme/colors.dart';
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
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              SocialStoryWidget(),
              SocialchatWidget(),
            ],
          ),
          context.watch<ShoweditbtnCubit>().state.show
              ? Positioned(
                  top: 100,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.lightgrey,
                            offset: Offset(0, 0.5),
                            blurRadius: 10,
                            spreadRadius: 5),
                      ],
                    ),
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
                )
              : Container()
        ],
      ),
    );
  }
}
