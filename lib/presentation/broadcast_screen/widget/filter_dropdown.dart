import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child:
                      Text('SocioMee Users', style: TextStyle(fontSize: 14))),
              Divider(color: AppColors.grey),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('MsgMee Users', style: TextStyle(fontSize: 14))),
              Divider(color: AppColors.grey),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child:
                      Text('Broadcast List', style: TextStyle(fontSize: 14))),
              Divider(color: AppColors.grey),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('Group List', style: TextStyle(fontSize: 14))),
            ],
          ),
        ));
  }
}
