import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../theme/colors.dart';

class BroadCastsWidget extends StatelessWidget {
  const BroadCastsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'My Broadcasts (3)',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
              ),
              Icon(
                Icons.error_outline,
                size: 15,
                color: AppColors.grey,
              ),
              Spacer(),
              Text('See More',
                  style: TextStyle(fontSize: 16, color: Colors.blue))
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                splashColor: AppColors.seconderyColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: SvgPicture.asset('assets/broadcast.svg')),
                      SizedBox(width: 13),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              index == 1
                                  ? "Eid Broadcast"
                                  : index == 2
                                      ? 'Diwali Broadcast'
                                      : 'Christmas Broadcast',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          SizedBox(height: 8),
                          Text('Alam, Saurabh, Taha Jamal, Anshuman...',
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.grey)),
                        ],
                      ),
                      Spacer(),
                      Text('2w ago',
                          style:
                              TextStyle(fontSize: 13, color: AppColors.grey)),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }
}
