import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';

class AccountDialogWidget extends StatelessWidget {
  const AccountDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/sociomee.png',
            fit: BoxFit.cover,
            height: 44,
          ),
          Text('Choose an account', style: TextStyle(fontSize: 16)),
          Text('to continue with SocioMee', style: TextStyle(fontSize: 10)),
          Divider(color: AppColors.grey),
          ListTile(
            leading: Image.asset(
              'assets/sociomee.png',
            ),
            title: Text('John Xyz'),
            subtitle: Text(
              '@john_xyz',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Center(
            child: Container(
              width: 150,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.grey)),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.grey,
                    size: 20,
                  ),
                  Text('Add account')
                ],
              ),
            ),
          ),
          Divider(color: AppColors.grey),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
                'When you click on continue,  you will receive a\nverification code on the mobile number you have entered.\nLearn how we process your data in our Privacy Policy and Cookies policy.',
                style: TextStyle(fontSize: 10)),
          )
        ],
      ),
    );
  }
}