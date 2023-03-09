import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/presentation/msgmee_screen/social_tab/cubit/showeditbtn/showeditbtn_cubit.dart';

import '../../../theme/custom_theme.dart';
import 'widget/social_chat_widget.dart';
import 'widget/social_stoty_widget.dart';

class SocialTabScreen extends StatelessWidget {
  const SocialTabScreen({super.key});

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
                      color: CustomTheme.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: CustomTheme.lightgrey,
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
                              color: CustomTheme.black),
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
                              color: CustomTheme.primaryColor),
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
