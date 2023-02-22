import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msgmee/presentation/authentication/cubit/cubit/number_validation_cubit.dart';
import 'package:msgmee/presentation/widgets/custom_button_widget.dart';
import 'package:msgmee/theme/custom_theme.dart';
import 'widget/language_change_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController numberController;

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
        backgroundColor: CustomTheme.white,
        elevation: 0,
        centerTitle: true,
        title: const LanguageChangeOptionWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0, right: 10),
            child: Text(
              'CONTINUE',
              style: TextStyle(
                  color: context.watch<NumberValidationCubit>().state.isvalid
                      ? CustomTheme.primaryColor
                      : CustomTheme.grey),
            ),
          )
        ],
      ),
      backgroundColor: CustomTheme.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const SizedBox(width: 50),
            //     const Center(child: LanguageChangeOptionWidget()),
            //     Text(
            //       'CONTINUE',
            //       style: TextStyle(
            //           color:
            //               context.watch<NumberValidationCubit>().state.isvalid
            //                   ? CustomTheme.primaryColor
            //                   : CustomTheme.grey),
            //     )
            //   ],
            // ),
            const SizedBox(height: 100),
            const Center(
                child: Text('Welcome', style: TextStyle(fontSize: 33))),
            const SizedBox(height: 50),
            Row(children: [
              Container(
                height: 40,
                width: 110,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: CustomTheme.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        textScaleFactor: 1.0,
                        '+91',
                        style: TextStyle(color: Colors.grey, fontSize: 17)),
                    const SizedBox(width: 10),
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
                      height: 20,
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: numberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 5),
                      border: OutlineInputBorder(),
                      hintText: 'Enter your mobile number',
                    ),
                    onChanged: (e) {
                      context
                          .read<NumberValidationCubit>()
                          .checkingValidation(e);
                    },
                  ),
                ),
              )
            ]),
            const SizedBox(height: 30),
            const Text(
              'When you click on continue,  you will receive a verification\n code on the mobile number that you have entered.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            const Spacer(),
            CustomButtonWidget(
                title: 'continue',
                color: context.watch<NumberValidationCubit>().state.isvalid
                    ? CustomTheme.primaryColor
                    : CustomTheme.seconderyColor),
            const SizedBox(
              height: 10,
            ),
            RichText(
                text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'By Signing-up, you agree to our ',
                    style: TextStyle(color: CustomTheme.grey)),
                TextSpan(
                    text: 'Terms & Conditions.',
                    style: TextStyle(
                      color: CustomTheme.black,
                    )),
              ],
            )),
            RichText(
                text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'By Signing-up, you agree to our ',
                    style: TextStyle(color: CustomTheme.grey)),
                TextSpan(
                    text: 'Privacy Policy ',
                    style: TextStyle(color: CustomTheme.black)),
              ],
            )),
            const Text('and Cookies Policy',
                style: TextStyle(color: CustomTheme.black)),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
