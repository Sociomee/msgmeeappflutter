import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../theme/custom_theme.dart';

class LanguageChangeOptionWidget extends StatelessWidget {
  const LanguageChangeOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> languages = [
      'English',
      'Deutsch',
      'Spanish',
      'Language 4 (native)',
      'Башҡортса',
      'Українська',
      'Yorùbá',
      '中文',
      'Кыргызча',
      'Português'
    ];
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
                  color: CustomTheme.white,
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
                            color: CustomTheme.grey,
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
                          color: CustomTheme.white,
                          child: Center(
                            child: Text(
                              'Change Language',
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
                              borderSide: BorderSide(color: CustomTheme.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: CustomTheme.grey),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: CustomTheme.grey),
                            ),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                color: CustomTheme.grey, fontSize: 17),
                            focusColor: CustomTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: languages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 2.0, color: CustomTheme.grey),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                languages[index],
                                textScaleFactor: 1.0,
                                style: const TextStyle(
                                    color: CustomTheme.black, fontSize: 17),
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Fontisto.world_o,
            size: 17,
            color: CustomTheme.black,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            textScaleFactor: 1.0,
            'English',
            style: TextStyle(
              color: CustomTheme.black,
              fontSize: 17,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: CustomTheme.black,
          )
        ],
      ),
    );
  }
}
