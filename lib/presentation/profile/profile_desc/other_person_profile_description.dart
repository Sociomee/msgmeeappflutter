import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/colors.dart';
import '../../msgmee_screen/media_doc_screen/widget/doc_tab.dart';
import '../../msgmee_screen/media_doc_screen/widget/links_tab.dart';
import 'media_tab/media_tab.dart';
import 'widgets/options_button_widget.dart';
import 'widgets/profile_bottom_sheet.dart';

class OtherPersonProfileDescription extends StatelessWidget {
  const OtherPersonProfileDescription(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.isOnline});
  final String imageUrl;
  final String name;
  final bool isOnline;
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
            actions: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return ProfileBottomModelSheet();
                        });
                  },
                  icon: Icon(Icons.more_vert, color: AppColors.black))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                            radius: 80,
                            backgroundColor: AppColors.grey,
                            backgroundImage: NetworkImage(imageUrl)),
                        isOnline
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(100)),
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
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  ),
                                  SizedBox(width: 5),
                                  Text('offline',
                                      style: TextStyle(
                                          color: AppColors.primaryColor))
                                ],
                              ),
                        Text('Henna Akhtar', style: TextStyle(fontSize: 18)),
                        Text('819-745-875', style: TextStyle(fontSize: 18))
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  OptionsButtomWidgets(),
                  Divider(color: AppColors.grey),
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Text(
                      'Shared media',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.0),
                      border: const Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.8)),
                    ),
                    child: TabBar(
                      indicatorWeight: 3,
                      indicatorColor: AppColors.primaryColor,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: AppColors.grey,
                      tabs: [
                        Tab(
                          icon: Text(
                            'Media',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Tab(
                          icon: Text(
                            'Docs',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Tab(
                          icon: Text(
                            'Links',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 640.h,
                    child: TabBarView(children: [
                      ProfileMediaTab(),
                      DocTabScreen(),
                      LinksTabScreen(),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
