import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/feature/b_auth/presentation/widgets/language_change_widget.dart';
import 'package:msgmee/feature/b_auth/presentation/widgets/number_confirmation_dialog.dart';
import 'package:msgmee/common_widgets/custom_button_widget.dart';
import 'package:msgmee/theme/colors.dart';
import '../cubit/number_validation/number_validation_cubit.dart';
import '../widgets/country_code_bottomsheet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController numberController;
  bool textFieldclick = false;
  String error = '';
  final _formKey = GlobalKey<FormState>();
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
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            backgroundColor: AppColors.white,
            valueColor: AlwaysStoppedAnimation<Color>(
                context.watch<NumberValidationCubit>().state.isvalid
                    ? AppColors.primaryColor
                    : AppColors.white),
            value: 0.25,
          ),
        ),
        // backgroundColor: CustomTheme.white,
        elevation: 0,
        centerTitle: true,
        title: ChooseLanguage(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0, right: 10),
            child: Text(
              'CONTINUE',
              style: TextStyle(
                  color: context.watch<NumberValidationCubit>().state.isvalid
                      ? AppColors.primaryColor
                      : AppColors.grey),
            ),
          )
        ],
      ),
      // backgroundColor: CustomTheme.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Center(
                  child: Text('Welcome', style: TextStyle(fontSize: 33))),
              const SizedBox(height: 50),
              Row(children: [
                CountryCodeWidget(),
                const SizedBox(width: 5),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: numberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: 5, bottom: 5, left: 15),
                        border: OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColors.primaryColor)),
                        hintText: 'Enter your mobile number',
                      ),
                      onTap: () {
                        setState(() {
                          textFieldclick = true;
                        });
                      },
                      onChanged: (e) {
                        context
                            .read<NumberValidationCubit>()
                            .checkingValidation(e);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            error = 'Please Enter a Number';
                          });
                        } else if (value.length < 10) {
                          setState(() {
                            error = 'Please Enter A Valid Mobile Number';
                          });
                        } else {
                          setState(() {
                            error = '';
                          });
                        }
                        return null;
                      },
                    ),
                  ),
                )
              ]),
              const SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 90),
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
              const SizedBox(height: 30),
              const Text(
                'We at MsgMee want to ensure that you have the best\nexperience possible.\nTo ensure that your mobile number is verified, please enter\nyour country code along with your mobile number.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
              const Spacer(),
              CustomButtonWidget(
                  borderColor:
                      context.watch<NumberValidationCubit>().state.isvalid
                          ? AppColors.primaryColor
                          : AppColors.primaryColor.withOpacity(.5),
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<NumberValidationCubit>().state.isvalid
                          ? showDialog(
                              context: context,
                              builder: (context) {
                                return NumberConfirmationDialog(
                                  inputNumber: numberController.text,
                                );
                              })
                          : null;
                    }
                  },
                  title: 'CONTINUE',
                  color: context.watch<NumberValidationCubit>().state.isvalid
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(.5)),
              const SizedBox(height: 10),
              textFieldclick
                  ? Container()
                  : RichText(
                      text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'By Signing-up, you agree to our ',
                            style: TextStyle(color: AppColors.grey)),
                        TextSpan(
                            text: 'Terms & Conditions.',
                            style: TextStyle(
                                color: AppColors.black,
                                decoration: TextDecoration.underline)),
                      ],
                    )),
              textFieldclick
                  ? Container()
                  : RichText(
                      text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'By Signing-up, you agree to our ',
                            style: TextStyle(color: AppColors.grey)),
                        TextSpan(
                            text: 'Privacy Policy ',
                            style: TextStyle(
                                color: AppColors.black,
                                decoration: TextDecoration.underline)),
                      ],
                    )),
              textFieldclick
                  ? Container()
                  : const Text('and Cookies Policy',
                      style: TextStyle(
                          color: AppColors.black,
                          decoration: TextDecoration.underline)),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
