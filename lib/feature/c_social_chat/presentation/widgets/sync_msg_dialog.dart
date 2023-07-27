import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/social_tab/cubit/sync_msg/sync_msg_cubit.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';
import 'package:msgmee/theme/colors.dart';

class SyncDialogWidget extends StatefulWidget {
  const SyncDialogWidget({super.key});

  @override
  State<SyncDialogWidget> createState() => _SyncDialogWidgetState();
}

class _SyncDialogWidgetState extends State<SyncDialogWidget> {
  bool accountfound = false;
  bool useotherac = false;
  bool showpassword = true;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: accountfound
          ? Column(
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
                Text(
                  'Account found !',
                  style: TextStyle(fontSize: 14, color: AppColors.black),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.grey,
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1600'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '@shreya_singh012',
                          style:
                              TextStyle(fontSize: 13, color: AppColors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '+ 91 8954543151',
                          style: TextStyle(fontSize: 13, color: AppColors.grey),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButtonWidget(
                      title: 'Continue',
                      color: AppColors.primaryColor,
                      ontap: () {
                        context.read<SyncMsgCubit>().syncmsg();
                        Navigator.pop(context);
                      }),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButtonWidget(
                      title: 'Other Account',
                      color: AppColors.white,
                      textColor: AppColors.primaryColor,
                      ontap: () {
                        setState(() {
                          useotherac = true;
                          accountfound = false;
                        });
                      }),
                ),
                SizedBox(height: 10),
              ],
            )
          : useotherac
              ? Form(
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
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            )),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            )),
                            hintText: 'Enter Email/Mobile Number',
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10)),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: showpassword,
                        cursorColor: AppColors.primaryColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            )),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            )),
                            hintText: 'Enter Password',
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showpassword = !showpassword;
                                  });
                                },
                                child: showpassword
                                    ? Icon(Icons.visibility_off, size: 18)
                                    : Icon(Icons.visibility, size: 18)),
                            hintStyle: TextStyle(fontSize: 12),
                            suffixIconColor: AppColors.primaryColor,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10)),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: CustomButtonWidget(
                            title: 'Continue',
                            color: emailController.text.isEmpty &
                                    passwordController.text.isEmpty
                                ? AppColors.primaryColor.withOpacity(.5)
                                : AppColors.primaryColor,
                            borderColor: emailController.text.isEmpty &
                                    passwordController.text.isEmpty
                                ? AppColors.primaryColor.withOpacity(.5)
                                : AppColors.primaryColor,
                            ontap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<SyncMsgCubit>().syncmsg();
                                Navigator.pop(context);
                              }
                            }),
                      ),
                    ],
                  ),
                )
              : Column(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomButtonWidget(
                          title: 'Sync with account credentials',
                          color: AppColors.primaryColor,
                          ontap: () {
                            setState(() {
                              accountfound = true;
                            });
                          }),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
    );
  }
}
