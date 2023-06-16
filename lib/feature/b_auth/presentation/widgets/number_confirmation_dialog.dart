import 'package:flutter/material.dart';
import 'package:msgmee/presentation/widgets/custom_button_widget.dart';
import '../../../../helper/navigator_function.dart';
import '../../../../theme/colors.dart';
import '../pages/otp_screen.dart';

class NumberConfirmationDialog extends StatefulWidget {
  const NumberConfirmationDialog({super.key, required this.inputNumber});
  final String inputNumber;

  @override
  State<NumberConfirmationDialog> createState() =>
      _NumberConfirmationDialogState();
}

class _NumberConfirmationDialogState extends State<NumberConfirmationDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              const Text(
                'You entered the below phone number.',
                style: TextStyle(fontSize: 12),
              ),
              TextFormField(
                controller:
                    TextEditingController(text: "+91${widget.inputNumber}"),
                decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    hintText: "+91${widget.inputNumber}",
                    hintStyle: const TextStyle(
                        color: AppColors.black, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 15),
              const Text(
                'Is this OK, or would you like to edit number?',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 55),
              CustomButtonWidget(
                  ontap: () {
                    try {
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                    screenNavigator(
                        context, OtpScreen(number: widget.inputNumber));
                  },
                  title: 'OK',
                  color: AppColors.primaryColor),
              const SizedBox(height: 21),
              CustomButtonWidget(
                ontap: () {
                  Navigator.pop(context);
                },
                title: 'EDIT',
                color: AppColors.white,
                textColor: AppColors.primaryColor,
              )
            ]),
      ),
    );
  }
}
