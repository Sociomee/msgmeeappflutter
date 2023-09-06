import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/c_profile/presentation/cubit/update_profile/update_profile_cubit.dart';

import '../../../../common_widgets/custom_button_widget.dart';
import '../../../../helper/local_data.dart';
import '../../../../theme/colors.dart';
import '../cubit/get_user_details/get_userdetails_cubit.dart';

class EditBioBottomSheet extends StatefulWidget {
  const EditBioBottomSheet({super.key});

  @override
  State<EditBioBottomSheet> createState() => _EditBioBottomSheetState();
}

class _EditBioBottomSheetState extends State<EditBioBottomSheet> {
  late TextEditingController bioController;
  int characters = 600;
  @override
  void initState() {
    bioController = TextEditingController(
        text: context.read<GetUserdetailsCubit>().state.response.data!.bio);
    super.initState();
  }

  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Container(
              height: 3,
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
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
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
                    onChanged: (e) {
                      setState(() {
                        characters = 600 - e.length;
                      });
                    },
                    controller: bioController,
                    cursorColor: AppColors.primaryColor,
                    minLines: 1,
                    maxLines: 4,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(600),
                    ],
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColors.borderColor)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColors.borderColor)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColors.primaryColor)),
                        hintText: 'please write your bio',
                        hintStyle: const TextStyle(
                            color: AppColors.lightgrey, fontSize: 12)),
                  ),
                  Row(children: [Spacer(), Text('Max $characters Characters')])
                ],
              ),
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                child: CustomButtonWidget(
                    height: 50,
                    title: 'Save Changes',
                    color: AppColors.primaryColor,
                    ontap: () async {
                      if (bioController.text.isNotEmpty) {
                        context
                            .read<UpdateProfileCubit>()
                            .updateBio(bioController.text);
                        var phone = await Localdata().readData('phone');
                        context
                            .read<GetUserdetailsCubit>()
                            .getUserDetailsCubit(phone);
                      }

                      Navigator.pop(context);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
