import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../../../theme/colors.dart';
import 'custom_shape.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final String message;
  final String msgStatus;
  final String time;
  const ReceivedMessageWidget({
    Key? key,
    required this.message,
    required this.msgStatus,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: CustomPaint(
                painter: CustomShape(AppColors.seconderyColor1),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 14, right: 18, bottom: 5),
                decoration: BoxDecoration(
                  color: AppColors.seconderyColor1,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
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

    return Padding(
      padding: EdgeInsets.only(right: 50.0, left: 18, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
