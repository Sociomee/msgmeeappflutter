import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common_widgets/custom_button_widget.dart';
import '../../../../theme/colors.dart';
import '../cubit/get_user_details/get_userdetails_cubit.dart';

class ChooseDateOfBirthBottomSheet extends StatefulWidget {
  const ChooseDateOfBirthBottomSheet({super.key});

  @override
  State<ChooseDateOfBirthBottomSheet> createState() =>
      _ChooseDateOfBirthBottomSheetState();
}

class _ChooseDateOfBirthBottomSheetState
    extends State<ChooseDateOfBirthBottomSheet> {
  DateTime datetime = DateTime.now();

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
            Text('Enter Date Of Birth',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: CupertinoDatePicker(
                  initialDateTime: datetime,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (value) {
                    setState(() {
                      datetime = value;
                    });
                  }),
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
                      if (datetime.toString().isNotEmpty) {
                        context
                            .read<GetUserdetailsCubit>()
                            .getUserDetailsCubit();
                      }
                      Navigator.pop(context);
                    }),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Expanded(
            //         flex: 2,
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 20),
            //           child: Column(
            //             children: [
            //               TextFormField(
            //                 decoration: InputDecoration(
            //                   hintText: '10',
            //                   border: OutlineInputBorder(
            //                       borderSide:
            //                           BorderSide(color: AppColors.lightgrey)),
            //                 ),
            //               ),
            //               Text('date', style: TextStyle(color: AppColors.grey))
            //             ],
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 2,
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 20),
            //           child: Column(
            //             children: [
            //               TextFormField(
            //                 decoration: InputDecoration(
            //                     hintText: 'Jan',
            //                     border: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                             color: AppColors.lightgrey))),
            //               ),
            //               Text('month', style: TextStyle(color: AppColors.grey))
            //             ],
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 2,
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 18),
            //           child: Column(
            //             children: [
            //               TextFormField(
            //                 decoration: InputDecoration(
            //                     hintText: '2021',
            //                     border: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                             color: AppColors.lightgrey))),
            //               ),
            //               Text('year', style: TextStyle(color: AppColors.grey))
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
