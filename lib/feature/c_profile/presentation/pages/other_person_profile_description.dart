import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:msgmee/helper/navigator_function.dart';
import '../widgets/common_groups.dart';
import '../../../../theme/colors.dart';
import 'media_tab.dart';
import '../widgets/options_button_widget.dart';
import '../../../c_social_chat/presentation/pages/media_doc_screen/media_and_doc_screen.dart';

class OtherPersonProfileDescription extends StatefulWidget {
  const OtherPersonProfileDescription(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.isOnline});
  final String imageUrl;
  final String name;
  final bool isOnline;

  @override
  State<OtherPersonProfileDescription> createState() =>
      _OtherPersonProfileDescriptionState();
}

class _OtherPersonProfileDescriptionState
    extends State<OtherPersonProfileDescription> {
  bool mute = false;
  bool notification = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: AppColors.black)),
            leadingWidth: 40,
            titleSpacing: 5,
            title: Text(
              widget.name,
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Hero(
                        tag: widget.imageUrl,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: AppColors.grey,
                            backgroundImage: NetworkImage(widget.imageUrl)),
                      ),
                      SizedBox(height: 10),
                      widget.isOnline
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                SizedBox(width: 5),
                                Text('online',
                                    style: TextStyle(
                                        color: AppColors.primaryColor))
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                      color: AppColors.grey,
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                SizedBox(width: 5),
                                Text('offline',
                                    style: TextStyle(
                                        color: AppColors.primaryColor))
                              ],
                            ),
                      SizedBox(height: 10),
                      Text(widget.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 6),
                      Text('+91 819-745-8750', style: TextStyle(fontSize: 14))
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Center(child: OptionsButtomWidgets()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/draft.svg'),
                      SizedBox(width: 5),
                      Text('Bio',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Norem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit.',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                      color: AppColors.grey.withOpacity(.3), thickness: 5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        'Media, Docs, Links',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          animatedScreenNavigator(
                              context,
                              MediaAndDocScreen(
                                profilename: widget.name,
                              ));
                        },
                        child: Text(
                          '248',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 15)
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 24, bottom: 10),
                  child: Text(
                    'Recent media',
                    style: TextStyle(
                      color: Color(0xFF4E4E4E),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                    height: 103,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 103,
                            width: 103,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                      color: AppColors.grey.withOpacity(.3), thickness: 5),
                ),
                CommonGroupsWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                      color: AppColors.grey.withOpacity(.3), thickness: 5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Report ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Anna More',
                          style: TextStyle(
                            color: Color(0xFF81C14B),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Block ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Anna More',
                          style: TextStyle(
                            color: Color(0xFF81C14B),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Mute Notifications',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Text(
                        notification ? 'On' : 'Off',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 10),
                      FlutterSwitch(
                        switchBorder: Border.all(
                          color: AppColors.primaryColor,
                          width: 2.0.w,
                        ),
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.white,
                        inactiveToggleColor: AppColors.primaryColor,
                        width: 41.0.w,
                        height: 20.0.h,
                        toggleSize: 18.0.sp,
                        value: notification,
                        borderRadius: 30.0,
                        padding: 2.0,
                        onToggle: (val) {
                          setState(() {
                            notification = !notification;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Mute Status',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Text(
                        mute ? 'On' : 'Off',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 10),
                      FlutterSwitch(
                        switchBorder: Border.all(
                          color: AppColors.primaryColor,
                          width: 2.0.w,
                        ),
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.white,
                        inactiveToggleColor: AppColors.primaryColor,
                        width: 41.0.w,
                        height: 20.0.h,
                        toggleSize: 18.0.sp,
                        value: mute,
                        borderRadius: 30.0,
                        padding: 2.0,
                        onToggle: (val) {
                          setState(() {
                            mute = !mute;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
