import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msgmee/theme/colors.dart';

import '../../../../../data/model/locations_model.dart';

class AttachLocationPage extends StatelessWidget {
  const AttachLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
        ),
        title: Text(
          'Send Location',
          style: TextStyle(color: AppColors.black),
        ),
        actions: [
          Icon(
            Icons.search,
            color: AppColors.black,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 200,
            width: double.infinity,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(border: Border.all(color: AppColors.black)),
            child: Text('Map Area'),
          ),
          SizedBox(height: 20),
          Text(
            'Share Live Location',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.darkgreen),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/share_location.svg'),
                Text(
                  'Share your live location',
                  style: TextStyle(color: AppColors.white),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: AppColors.grey, thickness: 1),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(5),
                color: AppColors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.my_location_outlined,
                  color: Colors.blue,
                  size: 18,
                ),
                SizedBox(width: 5),
                Text(
                  'Share your current location',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text('Popular Nearby Locations'),
          ),
          ListView.separated(
              shrinkWrap: true,
              itemCount: locations.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.white,
                          border: Border.all(color: AppColors.black)),
                      child: Icon(Icons.location_on),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locations[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(locations[index].subtitle),
                      ],
                    )
                  ],
                );
              })
        ]),
      ),
    );
  }
}