import 'package:flutter/material.dart';
import '../../../../../theme/colors.dart';

class CommonGroupsWidget extends StatelessWidget {
  const CommonGroupsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Common Groups (3)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.grey,
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=1600'),
              ),
              title: Text('College Group'),
              subtitle: Text('Harsh, Sagar, David and 5 others'),
            ),
          ),
          Divider(color: AppColors.grey),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.grey,
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=1600'),
              ),
              title: Text('College Group'),
              subtitle: Text('Harsh, Sagar, David and 5 others'),
            ),
          ),
          Divider(color: AppColors.grey),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.grey,
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=1600'),
              ),
              title: Text('College Group'),
              subtitle: Text('Harsh, Sagar, David and 5 others'),
            ),
          ),
          Divider(color: AppColors.grey),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.grey,
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=1600'),
              ),
              title: Text('College Group'),
              subtitle: Text('Harsh, Sagar, David and 5 others'),
            ),
          ),
          Divider(color: AppColors.grey),
        ],
      ),
    );
  }
}
