import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../theme/colors.dart';

class CountryCodeModel {
  final String flagUrl;
  final String countryName;
  final String countryCode;

  CountryCodeModel(this.flagUrl, this.countryName, this.countryCode);
}

List<CountryCodeModel> codeList = [
  CountryCodeModel(
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
    "India",
    "+91",
  ),
  CountryCodeModel(
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
    "Australia",
    "+61",
  ),
  CountryCodeModel(
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
    "Argentina",
    "+54",
  ),
  CountryCodeModel(
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
    "Bangladesh",
    "+880",
  ),
  CountryCodeModel(
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
    "Belarus",
    "+375",
  ),
  CountryCodeModel(
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
    "Canada",
    "+1",
  ),
  CountryCodeModel(
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
    "Cyprus",
    "+357",
  ),
  CountryCodeModel(
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
    "Denmark",
    "+45",
  ),
  CountryCodeModel(
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
    "Dominica",
    "+1-767",
  ),
  CountryCodeModel(
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
    "Estonia",
    "+372",
  ),
  CountryCodeModel(
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
    "Ethiopia",
    "+251",
  ),
];

class CountryCodeWidget extends StatelessWidget {
  const CountryCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          context: context,
          builder: (context) => ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Container(
              height: 530.h,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    // height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: AppColors.lightgrey,
                            blurRadius: 15.0,
                            offset: Offset(0.0, 0.75))
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 24),
                          color: AppColors.white,
                          child: Center(
                            child: Text(
                              'Change Country Code',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search country name or telecode...',
                            hintStyle: TextStyle(
                                color: AppColors.hintTextColor, fontSize: 13),
                            focusColor: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: codeList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0,
                                    color: AppColors.seconderyColor),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Image.network(
                                    codeList[index].flagUrl,
                                    width: 28,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    codeList[index].countryName,
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        color: AppColors.black, fontSize: 14),
                                  ),
                                  Spacer(),
                                  Text(
                                    codeList[index].countryCode,
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        color: AppColors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        height: 40,
        width: 90,
        padding: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                textScaleFactor: 1.0,
                '+91',
                style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(width: 6),
            Image.network(
              'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png',
              height: 15,
            ),
            // const SizedBox(width: 5),
            const Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }
}
