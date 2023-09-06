import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import '../../../../common_widgets/custom_button_widget.dart';
import '../../../../helper/navigator_function.dart';
import '../../../../theme/colors.dart';
import '../../../c_profile/presentation/pages/setup_profile_screen.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key, required this.phone});
  final String phone;
  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  late TextEditingController nameController;
  bool isValid = false;
  final formKey = GlobalKey<FormState>();
  int maxchar = 64;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            backgroundColor: AppColors.white,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkbtnColor),
            value: 0.75,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 2,
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
                  nameController.text.isNotEmpty) {
                animatedScreenReplaceNavigator(
                    context,
                    SetupProfileScreen(
                      name: nameController.text,
                      phone: widget.phone,
                    ));
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, right: 18),
              child: Text(
                'CONTINUE',
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color:
                        isValid ? AppColors.darkbtnColor : AppColors.lightgrey),
              ),
            ),
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 26),
              Text(
                'Please Provide your \nFull Name.',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Please Provide name for Msgmee account',
                style: TextStyle(
                  color: Color(0xFF828282),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nameController,
                onChanged: (value) {
                  setState(() {
                    maxchar = 64 - nameController.length;
                  });
                  if (value.isNotEmpty) {
                    setState(() {
                      isValid = true;
                    });
                  } else {
                    setState(() {
                      isValid = false;
                    });
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(64),
                ],
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.lightgrey1,
                    hintText: "Full name",
                    hintStyle: TextStyle(
                        color: Color(0xFFABB0BC),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightgrey)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightgrey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightgrey))),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Spacer(),
                  Text(
                    'Max ${maxchar} Characters',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF828282),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const Spacer(),
              CustomButtonWidget(
                  height: 46,
                  borderColor:
                      isValid ? AppColors.darkbtnColor : AppColors.lightgrey,
                  fontsize: 18,
                  ontap: () {
                    if (formKey.currentState!.validate() &&
                        nameController.text.isNotEmpty) {
                      animatedScreenReplaceNavigator(
                          context,
                          SetupProfileScreen(
                            name: nameController.text,
                            phone: widget.phone,
                          ));
                    }
                  },
                  title: 'Continue',
                  color:
                      isValid ? AppColors.darkbtnColor : AppColors.lightgrey),
              SizedBox(height: 104)
            ],
          ),
        ),
      ),
    );
  }
}
