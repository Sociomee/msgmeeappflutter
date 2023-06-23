import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../presentation/widgets/custom_button_widget.dart';
import '../../../../theme/colors.dart';

class EditBioBottomSheet extends StatefulWidget {
  const EditBioBottomSheet({super.key});

  @override
  State<EditBioBottomSheet> createState() => _EditBioBottomSheetState();
}

class _EditBioBottomSheetState extends State<EditBioBottomSheet> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10),
        Container(
          height: 2,
          width: 80.w,
          decoration: BoxDecoration(color: AppColors.grey),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(Icons.description_outlined),
              SizedBox(width: 5),
              Text('Bio',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                onTap: () {},
                onChanged: (e) {},
                controller: controller,
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: AppColors.borderColor)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppColors.borderColor)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: AppColors.primaryColor)),
                    hintText:
                        'Norem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit.',
                    hintStyle: const TextStyle(
                        color: AppColors.lightgrey, fontSize: 12)),
              ),
              Row(children: [Spacer(), Text('Max 600 Characters')])
            ],
          ),
        ),
        Spacer(),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: CustomButtonWidget(
                title: 'Save Changes',
                color: AppColors.primaryColor,
                ontap: () {
                  Navigator.pop(context);
                }),
          ),
        ),
      ],
    );
  }
}
