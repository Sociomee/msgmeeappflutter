import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/theme/colors.dart';
import '../../../../common_widgets/custom_button_widget.dart';
import '../../../../helper/navigator_function.dart';
import '../cubit/number_validation/number_validation_cubit.dart';
import '../cubit/otp_send/otp_send_cubit.dart';
import '../widgets/country_code.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController numberController;
  String countryCode = '91';
  bool textFieldclick = false;
  String error = '';
  final GlobalKey<State> alertDialogKey = GlobalKey<State>();
  @override
  void initState() {
    numberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpSendCubit, OtpSendState>(
      listener: (context, state) {
        if (state.status == LoginStatus.loading) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                          child: CircularProgressIndicator(
                              color: AppColors.darkbtnColor)),
                    ],
                  ),
                );
              });
        } else if (state.status == LoginStatus.loaded) {
          animatedScreenReplaceNavigator(context,
              OtpScreen(number: "${countryCode}${numberController.text}"));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Icon(Icons.arrow_back, color: AppColors.black, size: 24),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(6.0),
              child: LinearProgressIndicator(
                backgroundColor: AppColors.white,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.darkbtnColor),
                value: 0.25,
              ),
            ),
            elevation: 2,
            actions: [
              GestureDetector(
                onTap: () {
                  if (context.read<NumberValidationCubit>().state.isvalid) {
                    context
                        .read<OtpSendCubit>()
                        .sendOtp("+${countryCode}${numberController.text}");
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, right: 10),
                  child: Text(
                    'GET OTP',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color:
                            context.watch<NumberValidationCubit>().state.isvalid
                                ? AppColors.darkbtnColor
                                : AppColors.inactivegrey),
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 26),
                Text(
                  'Enter your \nPhone Number',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 24.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.32,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'OTP will be sent to this number',
                  style: TextStyle(
                    color: Color(0xFF828282),
                    fontSize: 15.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.32,
                  ),
                ),
                SizedBox(height: 16.h),
                CountryCodeTextField(
                  controller: numberController,
                  countryCode: countryCode,
                ),
                Spacer(),
                CustomButtonWidget(
                    height: 46,
                    title: 'Get OTP',
                    fontsize: 15.sp,
                    color: context.watch<NumberValidationCubit>().state.isvalid
                        ? AppColors.darkbtnColor
                        : AppColors.inactivegrey,
                    borderColor:
                        context.watch<NumberValidationCubit>().state.isvalid
                            ? AppColors.darkbtnColor
                            : AppColors.inactivegrey,
                    ontap: () {
                      if (context.read<NumberValidationCubit>().state.isvalid) {
                        context
                            .read<OtpSendCubit>()
                            .sendOtp("+91${numberController.text}");
                      }
                    }),
                SizedBox(height: 32.h),
                Center(
                  child: Text(' Terms of Services & Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF368C4E),
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline)),
                ),
                SizedBox(height: 51.h)
              ],
            ),
          ),
        );
      },
    );
  }
}
