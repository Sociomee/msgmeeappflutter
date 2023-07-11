import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class MediaTab extends StatelessWidget {
  const MediaTab({super.key});

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
                      const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
                  child: Text('RECENT'),
                ),
                Image.network(
                  'https://images.pexels.com/photos/5586512/pexels-photo-5586512.jpeg?auto=compress&cs=tinysrgb&w=1600',
                  width: 90.w,
                  height: 103,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 10, bottom: 3),
                  child: Text('LAST WEEK'),
                ),
                GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    children: List.generate(images.length, (index) {
                      return Container(
                        height: 103,
                        width: 103,
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    })),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 30, bottom: 3),
                  child: Text('LAST MONTH'),
                ),
                GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    children: List.generate(images.length, (index) {
                      return Container(
                        height: 103,
                        width: 103,
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    })),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: Text('NOVEMBER'),
                ),
                GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    children: List.generate(images.length, (index) {
                      return Container(
                        height: 103,
                        width: 103,
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
