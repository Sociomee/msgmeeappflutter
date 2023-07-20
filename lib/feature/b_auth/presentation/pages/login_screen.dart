import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/feature/b_auth/presentation/widgets/number_confirmation_dialog.dart';
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
          animatedScreenReplaceNavigator(
              context, OtpScreen(number: numberController.text));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: AppColors.black, size: 30.h),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(6.0),
              child: LinearProgressIndicator(
                backgroundColor: AppColors.white,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.darkbtnColor),
                value:
                    // context.watch<NumberValidationCubit>().state.isvalid
                    // ?
                    0.25
                // : 0
                ,
              ),
            ),
            elevation: 2,
            actions: [
              GestureDetector(
                onTap: () {
                  context.read<NumberValidationCubit>().state.isvalid
                      ? showDialog(
                          context: context,
                          builder: (context) {
                            return NumberConfirmationDialog(
                                inputNumber: numberController.text);
                          })
                      : null;
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 10),
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
                CountryCodeTextField(controller: numberController),
                Spacer(),
                CustomButtonWidget(
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


// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   late TextEditingController numberController;
//   bool textFieldclick = false;
//   String error = '';
//   final _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     numberController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     numberController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: AppColors.black,
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(6.0),
//           child: LinearProgressIndicator(
//             backgroundColor: AppColors.white,
//             valueColor: AlwaysStoppedAnimation<Color>(
//                 context.watch<NumberValidationCubit>().state.isvalid
//                     ? AppColors.primaryColor
//                     : AppColors.white),
//             value: 0.25,
//           ),
//         ),
//         // backgroundColor: CustomTheme.white,
//         elevation: 2,
//         centerTitle: true,
//         title: ChooseLanguage(),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               if (_formKey.currentState!.validate()) {
//                 context.read<NumberValidationCubit>().state.isvalid
//                     ? showDialog(
//                         context: context,
//                         builder: (context) {
//                           return NumberConfirmationDialog(
//                               inputNumber: numberController.text);
//                         })
//                     : null;
//               }
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(top: 18.0, right: 10),
//               child: Text(
//                 'CONTINUE',
//                 style: TextStyle(
//                     color: context.watch<NumberValidationCubit>().state.isvalid
//                         ? AppColors.primaryColor
//                         : AppColors.grey),
//               ),
//             ),
//           )
//         ],
//       ),
//       // backgroundColor: CustomTheme.white,
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           child: Column(
//             children: [
//               const SizedBox(height: 100),
//               const Center(
//                   child: Text('Welcome', style: TextStyle(fontSize: 33))),
//               const SizedBox(height: 50),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Row(children: [
//                   CountryCodeWidget(),
//                   const SizedBox(width: 5),
//                   Expanded(
//                     child: SizedBox(
//                       height: 40,
//                       child: TextFormField(
//                         controller: numberController,
//                         keyboardType: TextInputType.phone,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.allow(
//                               RegExp(r'^[0-9]+$')),
//                           LengthLimitingTextInputFormatter(10),
//                         ],
//                         decoration: const InputDecoration(
//                           contentPadding:
//                               EdgeInsets.only(top: 5, bottom: 5, left: 15),
//                           border: OutlineInputBorder(),
//                           focusedBorder: const OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: 2, color: AppColors.primaryColor)),
//                           hintText: 'Enter your mobile number',
//                         ),
//                         onTap: () {
//                           setState(() {
//                             textFieldclick = true;
//                           });
//                         },
//                         onChanged: (e) {
//                           context
//                               .read<NumberValidationCubit>()
//                               .checkingValidation(e);
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             setState(() {
//                               error = 'Please Enter a Number';
//                             });
//                           } else if (value.length < 10) {
//                             setState(() {
//                               error = 'Please Enter A Valid Mobile Number';
//                             });
//                           } else {
//                             setState(() {
//                               error = '';
//                             });
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   )
//                 ]),
//               ),
//               const SizedBox(height: 5),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     SizedBox(width: 90),
//                     error == ''
//                         ? Container()
//                         : Icon(
//                             Icons.error_outline,
//                             color: AppColors.errorRedColor,
//                             size: 12,
//                           ),
//                     SizedBox(width: 5),
//                     Text(error,
//                         style: TextStyle(
//                           color: AppColors.errorRedColor,
//                           fontSize: 12,
//                         ))
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Center(
//                 child: Container(
//                   width: 250.w,
//                   child: const Text(
//                     'We at MsgMee want to ensure that you have the best\nexperience possible.\nTo ensure that your mobile number is verified, please enter\nyour country code along with your mobile number.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: AppColors.black,
//                       fontSize: 12,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: CustomButtonWidget(
//                     borderColor:
//                         context.watch<NumberValidationCubit>().state.isvalid
//                             ? AppColors.primaryColor
//                             : AppColors.primaryColor.withOpacity(.5),
//                     ontap: () {
//                       if (_formKey.currentState!.validate()) {
//                         context.read<NumberValidationCubit>().state.isvalid
//                             ? showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return NumberConfirmationDialog(
//                                       inputNumber: numberController.text);
//                                 })
//                             : null;
//                       }
//                     },
//                     title: 'CONTINUE',
//                     color: context.watch<NumberValidationCubit>().state.isvalid
//                         ? AppColors.primaryColor
//                         : AppColors.primaryColor.withOpacity(.5)),
//               ),
//               const SizedBox(height: 10),
//               textFieldclick
//                   ? Container()
//                   : Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'By Signing-up, you agree to our ',
//                           style: TextStyle(color: AppColors.grey),
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               'Terms & Conditions.',
//                               style: TextStyle(color: AppColors.black),
//                             ),
//                             Container(
//                               height: 1,
//                               width: 113.w,
//                               color: AppColors.black,
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//               textFieldclick
//                   ? Container()
//                   : RichText(
//                       text: const TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: 'By Signing-up, you agree to our ',
//                             style: TextStyle(color: AppColors.grey)),
//                         TextSpan(
//                             text: 'Privacy Policy',
//                             style: TextStyle(
//                                 color: AppColors.black,
//                                 decoration: TextDecoration.underline)),
//                       ],
//                     )),
//               textFieldclick
//                   ? Container()
//                   : RichText(
//                       text: const TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: 'and ',
//                             style: TextStyle(color: AppColors.grey)),
//                         TextSpan(
//                             text: 'Cookies Policy',
//                             style: TextStyle(
//                                 color: AppColors.black,
//                                 decoration: TextDecoration.underline)),
//                       ],
//                     )),
//               const SizedBox(height: 20)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
