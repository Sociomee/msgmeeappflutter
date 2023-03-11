import 'package:flutter/material.dart';
import 'package:msgmee/presentation/profile/profile_desc/media_tab/widgets/common_groups.dart';
import 'package:msgmee/theme/custom_theme.dart';

List<String> images = [
  'https://images.pexels.com/photos/1226721/pexels-photo-1226721.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/185933/pexels-photo-185933.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/1008000/pexels-photo-1008000.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/2422255/pexels-photo-2422255.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/707915/pexels-photo-707915.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/5077039/pexels-photo-5077039.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/3550651/pexels-photo-3550651.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/5586512/pexels-photo-5586512.jpeg?auto=compress&cs=tinysrgb&w=1600',
  'https://images.pexels.com/photos/1226721/pexels-photo-1226721.jpeg?auto=compress&cs=tinysrgb&w=1600',
];

List<String> options = [
  'Notification',
  'Create Group chat',
  'Create Group chat',
  'Report',
  'Block',
  'Search in conversations',
  'Search in conversations'
];

class ProfileMediaTab extends StatelessWidget {
  const ProfileMediaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
                  child: Text('RECENT'),
                ),
                SizedBox(
                  height: 103,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 103,
                          width: 103,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                ),
                CommonGroupsWidget(),
                Container(
                  height: 50 * options.length.toDouble(),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                options[index],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 36,
                                width: 36,
                                color: CustomTheme.lightgrey,
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
