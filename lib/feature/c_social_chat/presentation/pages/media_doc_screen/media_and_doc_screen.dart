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
            profilename,
            style: TextStyle(color: AppColors.black),
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
