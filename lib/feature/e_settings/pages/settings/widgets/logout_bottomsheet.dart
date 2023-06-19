// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';

class LogoutOptions {
  final String option;
  final VoidCallback onClick;
  bool isSelected;
  LogoutOptions({
    required this.option,
    required this.onClick,
    required this.isSelected,
  });
}

List<LogoutOptions> options = [
  LogoutOptions(option: 'Proceed', onClick: () {}, isSelected: true),
  LogoutOptions(option: 'Cancel', onClick: () {}, isSelected: false),
  LogoutOptions(option: 'Learn more', onClick: () {}, isSelected: false),
];

class LogOutBottomSheet extends StatelessWidget {
  const LogOutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 80,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    color: AppColors.lightgrey,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height: 20),
              Text('Logout',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Text(
                'Are you sure to logout',
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 24),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: index == options.length - 1 ? 25 : 15),
                          color: options[index].isSelected
                              ? AppColors.seconderyColor1
                              : AppColors.white,
                          child: Text(
                            options[index].option,
                            style: TextStyle(
                              color: options[index].isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        index == options.length - 1
                            ? Container()
                            : Divider(
                                height: 0,
                                color: AppColors.seconderyColor,
                              )
                      ],
                    );
                  })
            ],
          ),
        ));
  }
}
