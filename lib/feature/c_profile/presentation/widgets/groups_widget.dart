import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../theme/colors.dart';

class GroupsWidget extends StatelessWidget {
  const GroupsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Divider(
            color: AppColors.grey.withOpacity(.4),
            height: 0,
            thickness: 6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'My Groups (3)',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
              ),
              SizedBox(width: 5),
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
                          child: SvgPicture.asset('assets/group.svg')),
                      SizedBox(width: 13),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              index == 1
                                  ? "Family Group"
                                  : index == 2
                                      ? 'Office Group'
                                      : 'College Group',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          SizedBox(height: 8),
                          Text('Members:33',
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.black)),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Admin',
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.black)),
                          Text('Since : 27 Dec, 2023',
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }
}
