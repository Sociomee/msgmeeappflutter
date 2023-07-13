import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/helper/navigator_function.dart';
import 'package:msgmee/helper/nth_character_function.dart';
import 'package:msgmee/feature/c_profile/presentation/pages/setup_profile_screen.dart';
import 'package:pinput/pinput.dart';
import '../../../../theme/colors.dart';
import '../../../../common_widgets/custom_button_widget.dart';
import '../cubit/number_validation/number_validation_cubit.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.number});
  final String number;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  bool isFocused = false;
  bool isValid = false;
  Duration duration = Duration(seconds: 120);
  Timer? timer;
  removeTime() {
    setState(() {
      var seconds = duration.inSeconds - 1;
      duration = Duration(seconds: seconds);
    });
  }

  void startNewTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) => removeTime());
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  int _timerDuration = 20;
  String error = '';
  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_timerDuration == 1) {
        setState(() {
          timer.cancel();
        });
      }
      setState(() {
        _timerDuration--;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    startNewTimer();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    var min = strDigits(_timerDuration.remainder(60));
    var sec = strDigits(_timerDuration.remainder(60));
    var min1 = strDigits(duration.inMinutes.remainder(60));
    var sec1 = strDigits(duration.inSeconds.remainder(60));
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            backgroundColor: AppColors.white,
            valueColor: AlwaysStoppedAnimation<Color>(
                context.watch<NumberValidationCubit>().state.isvalid
                    ? AppColors.primaryColor
                    : AppColors.white),
            value: 0.50,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            )),
        actions: [
          GestureDetector(
            onTap: () {
              screenNavigator(context, const SetupProfileScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, right: 10),
              child: Text(
                'CONTINUE',
                style: TextStyle(
                    color: isValid ? AppColors.primaryColor : AppColors.grey),
              ),
            ),
          )
        ],
      ),
      backgroundColor: AppColors.white,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Center(
                  child: Text('Enter OTP ', style: TextStyle(fontSize: 33))),
              const SizedBox(height: 5),
              Text(
                'An OTP has been sent to your phone number \nending with ${widget.number.toString().lastChars(4)}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 10,
                  right: 10,
                ),
                child: Pinput(
                  controller: _otpController,
                  length: 6,
                  defaultPinTheme: AppColors.defaultpintheme,
                  focusedPinTheme: AppColors.focuspintheme,
                  submittedPinTheme: AppColors.focuspintheme,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  cursor:
                      Container(color: AppColors.black, height: 2, width: 10),
                  errorTextStyle:
                      TextStyle(fontSize: 12, color: AppColors.errorRedColor),
                  validator: (s) {
                    if (s!.isEmpty) {
                      setState(() {
                        error = "Please Enter a Otp!";
                      });
                    } else {
                      setState(() {
                        error = '';
                      });
                    }
                    return null;
                  },
                  onTap: () {
                    setState(() {
                      isFocused = true;
                    });
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) {
                    setState(() {
                      isValid = true;
                    });
                  },
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    error == ''
                        ? Container()
                        : Icon(
                            Icons.error_outline,
                            color: AppColors.errorRedColor,
                            size: 12,
                          ),
                    SizedBox(width: 5),
                    Text(error,
                        style: TextStyle(
                          color: AppColors.errorRedColor,
                          fontSize: 12,
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 68),
              Text(
                "$min1:$sec1 sec",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 6),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: 'Didn’t receive OTP yet? ',
                    style: TextStyle(color: AppColors.black, fontSize: 14)),
                TextSpan(
                    text: 'Resend',
                    style: TextStyle(
                        color: sec == '00'
                            ? AppColors.primaryColor
                            : AppColors.primaryColor.withOpacity(.5),
                        fontSize: 14)),
              ])),
              const Spacer(),
              CustomButtonWidget(
                  borderColor: isValid
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(.5),
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      screenNavigator(context, const SetupProfileScreen());
                    }
                  },
                  title: 'CONTINUE',
                  color: isValid
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(.5)),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
