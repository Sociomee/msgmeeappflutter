import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/b_auth/presentation/cubit/otp_verify/otp_verify_cubit.dart';
import 'package:msgmee/feature/b_auth/presentation/pages/name_screen.dart';
import 'package:msgmee/helper/navigator_function.dart';
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
  bool isFocused = false;
  bool isValid = false;
  bool textFieldclick = false;
  Duration duration = Duration(seconds: 20);
  Timer? timer;
  removeTime() {
    setState(() {
      if (duration.inSeconds >= 1) {
        var seconds = duration.inSeconds - 1;
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) => removeTime());
  }

  void resetTimer() {
    setState(() {
      duration = Duration(seconds: 20);
    });
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  String error = '';

  @override
  void initState() {
    super.initState();
    startTimer();
    print(widget.number);
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    var min = strDigits(duration.inMinutes.remainder(60));
    var sec = strDigits(duration.inSeconds.remainder(60));
    return BlocConsumer<OtpVerifyCubit, OtpVerifyState>(
      listener: (context, state) {
        if (state.status == OtpVerifyStatus.loading) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      context.watch<OtpVerifyCubit>().state.status ==
                                  OtpVerifyStatus.error &&
                              state.response.successMessage != null
                          ? Text(
                              state.response.successMessage!,
                              style: TextStyle(color: AppColors.errorRedColor),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.darkbtnColor))
                    ],
                  ),
                );
              });
        } else if (state.status == OtpVerifyStatus.loaded) {
          animatedScreenReplaceNavigator(
              context,
              NameScreen(
                phone: widget.number,
              ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(6.0),
              child: LinearProgressIndicator(
                backgroundColor: AppColors.white,
                valueColor: AlwaysStoppedAnimation<Color>(
                    context.watch<NumberValidationCubit>().state.isvalid
                        ? AppColors.darkbtnColor
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
                  Icons.arrow_back,
                  color: AppColors.black,
                )),
            actions: [
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate() &&
                      _otpController.length == 6 &&
                      isValid) {
                    context
                        .read<OtpVerifyCubit>()
                        .verifyUserOtp(widget.number, _otpController.text);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0, right: 10),
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color:
                            isValid ? AppColors.darkbtnColor : AppColors.grey),
                  ),
                ),
              )
            ],
          ),
          backgroundColor: AppColors.white,
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 26),
                  Text(
                    'Verify with OTP\nSent to ${widget.number}',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        height: 21,
                        width: 21,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.darkbtnColor),
                          color: AppColors.darkbtnColor,
                          backgroundColor: AppColors.grey,
                          // value: .3,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Auto fetching OTP',
                        style: TextStyle(
                          color: Color(0xFF828282),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
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
                      focusedPinTheme: error == ''
                          ? AppColors.focuspintheme
                          : AppColors.errorpintheme,
                      submittedPinTheme: error == ''
                          ? AppColors.focuspintheme
                          : AppColors.errorpintheme,
                      errorPinTheme: AppColors.errorpintheme,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      cursor: Container(
                          color: AppColors.black, height: 2, width: 10),
                      errorTextStyle: TextStyle(
                          fontSize: 12, color: AppColors.errorRedColor),
                      errorText: error,
                      preFilledWidget: Container(
                        decoration: BoxDecoration(
                            color: AppColors.lightgrey1,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '0',
                              style: TextStyle(
                                color: Color(0xFFABB0BC),
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                                color: Color(0xFFABB0BC),
                                height: 2,
                                width: 14.w),
                          ],
                        )),
                      ),
                      validator: (s) {
                        if (s!.isEmpty) {
                          setState(() {
                            error = "Please Enter a Otp!";
                          });
                        } else if (s.length != 6) {
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
                          textFieldclick = true;
                        });
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onChanged: (pin) {
                        print(pin.isEmpty);
                        if (pin.isNotEmpty && pin.length == 6) {
                          setState(() {
                            isValid = true;
                          });
                        } else if (pin.length < 6) {
                          setState(() {
                            isValid = false;
                          });
                        }
                      },
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
                        Spacer(),
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
                            )),
                        SizedBox(width: 15)
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: 'Didn’t receive it? Reply in ',
                          style: TextStyle(
                            color: Color(0xFF828282),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: "$min:$sec sec",
                          style: TextStyle(
                            color: sec == '00'
                                ? AppColors.black
                                : AppColors.darkbtnColor,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          )),
                    ])),
                  ),
                  SizedBox(height: 24),
                  sec == '00'
                      ? GestureDetector(
                          onTap: () {
                            resetTimer();
                          },
                          child: Center(
                            child: Text(
                              'Resend OTP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF1976D2),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  const Spacer(),
                  CustomButtonWidget(
                      height: 46,
                      borderColor: isValid
                          ? AppColors.darkbtnColor
                          : AppColors.lightgrey,
                      fontsize: 18,
                      ontap: () {
                        if (formKey.currentState!.validate() &&
                            _otpController.length == 6 &&
                            isValid) {
                          print(widget.number);
                          context.read<OtpVerifyCubit>().verifyUserOtp(
                              widget.number, _otpController.text);
                        }
                      },
                      title: 'Continue',
                      color: isValid
                          ? AppColors.darkbtnColor
                          : AppColors.lightgrey),
                  const SizedBox(height: 10),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'By Clicking continue, You agree to our\n',
                            style: TextStyle(
                              color: Color(0xFF8F8F8F),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.32,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of Services',
                            style: TextStyle(
                              color: Color(0xFF277044),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              color: Color(0xFF8F8F8F),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.32,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy.',
                            style: TextStyle(
                              color: Color(0xFF277044),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
