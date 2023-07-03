import 'package:flutter/material.dart';
import 'package:msgmee/domain/models/chat_theme_model.dart';
import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/chat_theme_gradient_container.dart';

import '../../../../../theme/colors.dart';

class ChatThemePage extends StatefulWidget {
  const ChatThemePage({super.key});

  @override
  State<ChatThemePage> createState() => _ChatThemePageState();
}

class _ChatThemePageState extends State<ChatThemePage> {
  int selectedindex = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            )),
        title: Text(
          'Chat Theme',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Colors & Gradients',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: themes.length,
              itemBuilder: (context, index) {
                return index == 4
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 22),
                            child: Row(
                              children: [
                                GradientColorContainer(
                                  leftColor: AppColors.berryGradientLight,
                                  rightColor: AppColors.berryGradientDeep,
                                ),
                                Text(
                                  themes[index].name,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedindex = index;
                                    });
                                  },
                                  child: Container(
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            color: selectedindex == index
                                                ? AppColors.darkgreen
                                                : AppColors.grey,
                                            width: selectedindex == index
                                                ? 15
                                                : 2)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: Color.fromARGB(255, 225, 225, 225),
                            thickness: 1,
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 22),
                            child: Row(
                              children: [
                                ChatThemeColorContainer(
                                  leftColor: themes[index].leftColor,
                                  rightColor: themes[index].rightColor,
                                ),
                                Text(
                                  themes[index].name,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedindex = index;
                                    });
                                  },
                                  child: Container(
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            color: selectedindex == index
                                                ? AppColors.darkgreen
                                                : AppColors.grey,
                                            width: selectedindex == index
                                                ? 15
                                                : 2)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: Color.fromARGB(255, 225, 225, 225),
                            thickness: 1,
                          )
                        ],
                      );
              })
        ],
      ),
    );
  }
}
