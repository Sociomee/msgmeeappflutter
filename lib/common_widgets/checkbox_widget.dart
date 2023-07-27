import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({super.key, required this.selected, this.onChange});
  final bool selected;
  final Function(bool?)? onChange;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        activeColor: AppColors.primaryColor,
        side: MaterialStateBorderSide.resolveWith(
          (states) =>
              const BorderSide(width: 1.0, color: AppColors.primaryColor),
        ),
        value: selected,
        onChanged: onChange);
  }
}
