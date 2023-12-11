import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../theme/colors.dart';
import '../../../cubit/chat_theme/chat_theme_cubit.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final String message;
  final int msgStatus;
  final String time;
  final String type;

  const ReceivedMessageWidget({
    Key? key,
    required this.message,
    required this.msgStatus,
    required this.time,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 14, right: 18, bottom: 5),
                decoration: BoxDecoration(
                  color: context
                      .watch<ChatThemeCubit>()
                      .state
                      .chatLightColor
                      .withOpacity(.4),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Text(message,
                        style: TextStyle(color: AppColors.black, fontSize: 14)),
                    SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: message.trim().length <= 15
                              ? 40
                              : message.trim().length <= 21
                                  ? 80
                                  : 200,
                        ),
                        Text(time,
                            style: const TextStyle(
                                color: AppColors.black, fontSize: 10)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    final contactMessage = Flexible(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 14, right: 18, bottom: 15),
                decoration: BoxDecoration(
                    color: context
                        .watch<ChatThemeCubit>()
                        .state
                        .chatLightColor
                        .withOpacity(.5),
                    borderRadius: BorderRadius.circular(100)),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
                        height: 44,
                        width: 44,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(message,
                        style: TextStyle(color: AppColors.black, fontSize: 14)),
                    SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: message.trim().length <= 15
                              ? 40
                              : message.trim().length <= 21
                                  ? 80
                                  : 200,
                        ),
                        Text(time,
                            style: const TextStyle(
                                color: AppColors.black, fontSize: 10)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return Padding(
      padding: EdgeInsets.only(right: 50.0, left: 18, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          type == 'contact' ? contactMessage : messageTextGroup,
        ],
      ),
    );
  }
}
