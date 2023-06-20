import 'package:flutter/material.dart';
import '../../../../../../theme/colors.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  bool isSelected = true;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text('Boradcast List',
                          style: TextStyle(fontSize: 14))),
                  Checkbox(
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(
                            width: 1.0, color: AppColors.primaryColor),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      activeColor: AppColors.primaryColor,
                      value: isSelected,
                      onChanged: (w) {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      })
                ],
              ),
              Divider(color: AppColors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text('Group List (12)',
                          style: TextStyle(fontSize: 14))),
                  Checkbox(
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(
                            width: 1.0, color: AppColors.primaryColor),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      activeColor: AppColors.primaryColor,
                      value: isSelected,
                      onChanged: (w) {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      })
                ],
              ),
              Divider(color: AppColors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child:
                          Text('MsgMee User', style: TextStyle(fontSize: 14))),
                  Checkbox(
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(
                            width: 1.0, color: AppColors.primaryColor),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      activeColor: AppColors.primaryColor,
                      value: isSelected,
                      onChanged: (w) {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      })
                ],
              ),
              Divider(color: AppColors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text('SocoiMee Users',
                          style: TextStyle(fontSize: 14))),
                  Checkbox(
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(
                            width: 1.0, color: AppColors.primaryColor),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      activeColor: AppColors.primaryColor,
                      value: isSelected,
                      onChanged: (w) {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      })
                ],
              ),
            ],
          ),
        ));
  }
}
