import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:msgmee/common_widgets/custom_button_widget.dart';
import 'package:msgmee/helper/validation_ext.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../common_widgets/shimmer_effect.dart';
import '../cubit/sync_sociomee/sync_sociomee_cubit.dart';

class SyncDialogWidget extends StatefulWidget {
  const SyncDialogWidget({super.key});

  @override
  State<SyncDialogWidget> createState() => _SyncDialogWidgetState();
}

class _SyncDialogWidgetState extends State<SyncDialogWidget> {
  bool useotherac = false;
  bool showpassword = true;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool _isButtonEnabled = false;
  bool validno = false;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailController.addListener(() {
      _validateInput();
    });
    passwordController.addListener(() {
      _validateInput();
    });
    super.initState();
  }

  void _validateInput() {
    RegExp phoneRegex = RegExp(r'^\d{10}$');
    setState(() {
      _isButtonEnabled = validno &&
          passwordController.text.isNotEmpty &&
          passwordController.text.length > 8;

      validno = phoneRegex.hasMatch(emailController.text) ||
          emailController.text.isValidEmail;
    });
    print("${_isButtonEnabled}\n${validno}");
  }

  @override
  Widget build(BuildContext context) {
    // var cubit = context.watch<SyncSociomeeCubit>().state;
    return BlocConsumer<SyncSociomeeCubit, SyncSociomeeState>(
      listener: (context, state) {
        if (state.status == SyncSociomeeStatus.loaded &&
            state.isSocimeeAcSynced) {
            context.read<SyncSociomeeCubit>().checkAndAddContact();
          //Navigator.pop(context);
        }else{
          if(state.status == SyncSociomeeStatus.initial){
            context.read<SyncSociomeeCubit>().checkSocimeeCubit();
          }
        }
      },
      builder: (context, state) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.syncResponse.data == null && useotherac == false)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 42, horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      Image.asset(
                        'assets/sync_msg.png',
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'No SocioMee account found with this\nmobile number.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      // CustomButtonWidget(
                      //     height: 40.w,
                      //     title: 'Sync with account credentials',
                      //     color: AppColors.primaryColor,
                      //     ontap: () {
                      //       context
                      //           .read<SyncSociomeeCubit>()
                      //           .checkSocimeeCubit();
                      //       setState(() {
                      //         useotherac = !useotherac;
                      //       });
                      //     }),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              if (state.syncResponse.data != null && useotherac == false)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 42),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      Center(
                          child: Image.asset('assets/sync_msg.png',
                              height: 80, fit: BoxFit.cover)),
                      SizedBox(height: 20),
                      Text('Account found !',
                          style:
                              TextStyle(fontSize: 14, color: AppColors.black)),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          state.checkStatus == CheckSociomeeStatus.loading
                              ? CustomShimmerEffect(
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundColor: AppColors.grey,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 28,
                                  backgroundColor: AppColors.grey,
                                  backgroundImage: NetworkImage(
                                    state.syncResponse.data!.successResult!
                                        .profileImage!,
                                  ),
                                ),
                          SizedBox(width: 10),
                          if (state.checkStatus == CheckSociomeeStatus.loading)
                            CustomShimmerEffect(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 18,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.grey),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 10,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.grey),
                                )
                              ],
                            )),
                          if (state.checkStatus == CheckSociomeeStatus.loaded)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.syncResponse.data!.successResult!
                                      .userName!,
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.black),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "+${state.phone}",
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.grey),
                                )
                              ],
                            )
                        ],
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:
                            // state.status == SyncSociomeeStatus.loading
                            //     ? Container(
                            //         alignment: Alignment.center,
                            //         height: 40.w,
                            //         width: 334.w,
                            //         decoration: BoxDecoration(
                            //             color: AppColors.primaryColor,
                            //             borderRadius: BorderRadius.circular(6),
                            //             border: Border.all(
                            //                 color: AppColors.primaryColor)),
                            //         child: CircularProgressIndicator(
                            //           color: AppColors.white,
                            //         ))
                            //     :
                            CustomButtonWidget(
                                height: 40.w,
                                title: 'Continue',
                                color: AppColors.primaryColor,
                                ontap: () {
                                  context
                                      .read<SyncSociomeeCubit>()
                                      .syncSociomeeAc();
                                  Navigator.pop(context);
                                }),
                      ),
                      SizedBox(height: 20),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: CustomButtonWidget(
                      //       height: 40.w,
                      //       title: 'Other Account',
                      //       color: AppColors.white,
                      //       textColor: AppColors.primaryColor,
                      //       ontap: () {
                      //         setState(() {
                      //           useotherac = true;
                      //         });
                      //       }),
                      // ),
                      // SizedBox(height: 10),
                    ],
                  ),
                ),
              if (useotherac)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 42),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Image.asset(
                            'assets/sync_msg.png',
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Center(
                            child: Text(
                              'Sync your SocioMate in MsgMee by\nemail/mobile number and password.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          controller: emailController,
                          cursorColor: AppColors.primaryColor,
                          validator: (value) {
                            return validateEmailOrPhone(value!);
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: AppColors.lightgrey,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              )),
                              hintText: 'Enter Email/Mobile Number',
                              errorStyle: const TextStyle(
                                fontSize: 10,
                                color: AppColors.errorRedColor,
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF999999),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10)),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: showpassword,
                          cursorColor: AppColors.primaryColor,
                          validator: (value) {
                            return passwordValidator(value);
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: AppColors.lightgrey,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              )),
                              hintText: 'Enter Password',
                              errorStyle: const TextStyle(
                                fontSize: 10,
                                color: AppColors.errorRedColor,
                                fontWeight: FontWeight.bold,
                              ),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showpassword = !showpassword;
                                    });
                                  },
                                  child: showpassword
                                      ? Icon(Icons.visibility_off, size: 18)
                                      : Icon(Icons.visibility, size: 18)),
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF999999),
                              ),
                              suffixIconColor: AppColors.primaryColor,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10)),
                          onChanged: (e) {},
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: CustomButtonWidget(
                              height: 40.w,
                              title: 'Continue',
                              color: !_isButtonEnabled
                                  ? AppColors.primaryColor.withOpacity(.5)
                                  : AppColors.primaryColor,
                              borderColor: !_isButtonEnabled
                                  ? AppColors.primaryColor.withOpacity(.5)
                                  : AppColors.primaryColor,
                              ontap: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .watch<SyncSociomeeCubit>()
                                      .syncSociomeeAc();
                                  Navigator.pop(context);
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
