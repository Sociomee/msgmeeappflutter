import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/colors.dart';
import '../cubit/number_validation/number_validation_cubit.dart';

class CountryCodeTextField extends StatefulWidget {
  const CountryCodeTextField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  State<CountryCodeTextField> createState() => _CountryCodeTextFieldState();
}

class _CountryCodeTextFieldState extends State<CountryCodeTextField> {
  String countryCode = '91';
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
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      countryListTheme: CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.white,
                        textStyle:
                            TextStyle(fontSize: 16, color: Colors.blueGrey),
                        bottomSheetHeight: 500,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        inputDecoration: InputDecoration(
                          hintText: 'Search country name or telecode...',
                          focusColor: AppColors.primaryColor,
                          prefixIconColor: AppColors.primaryColor,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor)),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                      onSelect: (Country country) {
                        setState(() {
                          countryCode = country.phoneCode;
                        });
                        print('Select country: ${country.phoneCode}');
                      });
                },
                child: Container(
                  height: 40,
                  width: 20,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          textScaleFactor: 1.0,
                          "+${countryCode}",
                          style:
                              TextStyle(color: AppColors.black, fontSize: 15)),
                      // const Icon(Icons.expand_more, size: 18)
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 6,
            child: SizedBox(
              height: 40,
              child: TextFormField(
                controller: widget.controller,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(3),
                            bottomRight: Radius.circular(3))),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(3),
                            bottomRight: Radius.circular(3)),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.primaryColor)),
                    hintText: 'Enter your mobile number',
                    hintStyle: TextStyle(color: AppColors.inactivegrey)),
                onTap: () {
                  setState(() {
                    textFieldclick = true;
                  });
                },
                onChanged: (e) {
                  context.read<NumberValidationCubit>().checkingValidation(e);
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
          ),
        ],
      ),
    );
  }
}
