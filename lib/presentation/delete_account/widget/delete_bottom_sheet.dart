// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/custom_theme.dart';

class DeleteBottomSheet extends StatelessWidget {
  const DeleteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: CustomTheme.white,
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 80,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    color: CustomTheme.lightgrey,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height: 20),
              Text('Delete account',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 40),
              Text(
                'Do you want to really delete your account ?',
                style: TextStyle(
                  color: CustomTheme.iconColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CupertinoButton(
                      color: CustomTheme.primaryColor,
                      child: Text('OK'),
                      onPressed: () {}),
                  CupertinoButton(
                      color: CustomTheme.grey,
                      child: Text('Cancel'),
                      onPressed: () {}),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ));
  }
}
