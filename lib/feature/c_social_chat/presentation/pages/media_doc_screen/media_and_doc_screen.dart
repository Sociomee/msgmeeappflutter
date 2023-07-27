import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../theme/colors.dart';
import 'widget/doc_tab.dart';
import 'widget/links_tab.dart';
import 'widget/media_tab.dart';

class MediaAndDocScreen extends StatelessWidget {
  const MediaAndDocScreen({super.key, required this.profilename});
  final String profilename;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 40,
          titleSpacing: 5,
          leading: Padding(
            padding: EdgeInsets.only(left: 5),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size: 20,
                )),
          ),
          title: Text(
            profilename,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        'Docs',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        'Links',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 570.h,
                child: TabBarView(children: [
                  MediaTab(),
                  DocTabScreen(),
                  LinksTabScreen(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
