import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../../theme/colors.dart';
import '../../../e_settings/cubit/choose_language_cubit.dart';

class LanguageOptionBottomSheet extends StatefulWidget {
  const LanguageOptionBottomSheet({super.key});

  @override
  State<LanguageOptionBottomSheet> createState() =>
      _LanguageOptionBottomSheetState();
}

class _LanguageOptionBottomSheetState extends State<LanguageOptionBottomSheet> {
  late TextEditingController controller;
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
  List<String> filterlanguage = [];
  @override
  void initState() {
    controller = TextEditingController();
    filterlanguage = List.from(languages);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: 530.h,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              // height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: AppColors.grey,
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
                        'Choose Language',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: controller,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          filterlanguage = List.from(languages);
                        });
                      } else {
                        setState(() {
                          filterlanguage = filterlanguage
                              .where((e) =>
                                  e.toLowerCase().contains(value.toLowerCase()))
                              .toList();
                        });
                      }
                    },
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
                      hintText: 'Search..',
                      hintStyle: TextStyle(color: AppColors.grey, fontSize: 12),
                      focusColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: filterlanguage.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<ChooseLanguageCubit>()
                            .selectlanguage(filterlanguage[index]);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0,
                                color: AppColors.primaryColor.withOpacity(.2)),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            filterlanguage[index],
                            textScaleFactor: 1.0,
                            style: const TextStyle(
                                color: AppColors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            context: context,
            builder: (context) {
              return LanguageOptionBottomSheet();
            });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Fontisto.world_o,
            size: 17,
            color: AppColors.black,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            textScaleFactor: 1.0,
            'English',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 17,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.black,
          )
        ],
      ),
    );
  }
}
