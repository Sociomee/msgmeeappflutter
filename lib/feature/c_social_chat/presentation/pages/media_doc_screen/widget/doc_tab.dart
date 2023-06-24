import 'package:flutter/material.dart';

import '../../../../../../theme/colors.dart';

class DocTabScreen extends StatelessWidget {
  const DocTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
                  child: Text('RECENT'),
                ),
                Row(
                  children: [
                    SizedBox(width: 16),
                    Icon(
                      Icons.insert_drive_file_outlined,
                      color: AppColors.primaryColor,
                      size: 40,
                    ),
                    SizedBox(width: 16),
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rural Development.pdf',
                              style: TextStyle(fontSize: 18)),
                          Text('65 page .25 MB .PDF',
                              style: TextStyle(fontSize: 12))
                        ]),
                    Spacer(),
                    Text(
                      '4:28 pm',
                      style: TextStyle(color: AppColors.grey),
                    ),
                    SizedBox(width: 27),
                  ],
                ),
                Divider(
                  color: AppColors.grey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
                  child: Text('LAST WEEK'),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                SizedBox(width: 16),
                                Icon(
                                  Icons.insert_drive_file_outlined,
                                  color: AppColors.primaryColor,
                                  size: 40,
                                ),
                                SizedBox(width: 16),
                                Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Rural Development.pdf',
                                          style: TextStyle(fontSize: 18)),
                                      Text('65 page .25 MB .PDF',
                                          style: TextStyle(fontSize: 12))
                                    ]),
                                Spacer(),
                                Text(
                                  '4:28 pm',
                                  style: TextStyle(color: AppColors.grey),
                                ),
                                SizedBox(width: 27),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.grey,
                          ),
                        ],
                      );
                    }),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
                  child: Text('LAST WEEK'),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                SizedBox(width: 16),
                                Icon(
                                  Icons.insert_drive_file_outlined,
                                  color: AppColors.primaryColor,
                                  size: 40,
                                ),
                                SizedBox(width: 16),
                                Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Rural Development.pdf',
                                          style: TextStyle(fontSize: 18)),
                                      Text('65 page .25 MB .PDF',
                                          style: TextStyle(fontSize: 12))
                                    ]),
                                Spacer(),
                                Text(
                                  '30/12/2021',
                                  style: TextStyle(color: AppColors.grey),
                                ),
                                SizedBox(width: 27),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.grey,
                          ),
                        ],
                      );
                    }),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
                  child: Text('LAST MONTH'),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                SizedBox(width: 16),
                                Icon(
                                  Icons.insert_drive_file_outlined,
                                  color: AppColors.primaryColor,
                                  size: 40,
                                ),
                                SizedBox(width: 16),
                                Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Rural Development.pdf',
                                          style: TextStyle(fontSize: 18)),
                                      Text('65 page .25 MB .PDF',
                                          style: TextStyle(fontSize: 12))
                                    ]),
                                Spacer(),
                                Text(
                                  '25/11/2021',
                                  style: TextStyle(color: AppColors.grey),
                                ),
                                SizedBox(width: 27),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.grey,
                          ),
                        ],
                      );
                    }),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
                  child: Text('DECEMBER'),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                SizedBox(width: 16),
                                Icon(
                                  Icons.insert_drive_file_outlined,
                                  color: AppColors.primaryColor,
                                  size: 40,
                                ),
                                SizedBox(width: 16),
                                Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Rural Development.pdf',
                                          style: TextStyle(fontSize: 18)),
                                      Text('65 page .25 MB .PDF',
                                          style: TextStyle(fontSize: 12))
                                    ]),
                                Spacer(),
                                Text(
                                  '4:28 pm',
                                  style: TextStyle(color: AppColors.grey),
                                ),
                                SizedBox(width: 27),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.grey,
                          ),
                        ],
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
