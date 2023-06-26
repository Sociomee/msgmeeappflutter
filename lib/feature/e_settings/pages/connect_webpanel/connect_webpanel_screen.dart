import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';

class ConncetWenPanelScreen extends StatelessWidget {
  const ConncetWenPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Scan QR code',
            style: TextStyle(color: AppColors.black),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: AppColors.black.withOpacity(0.6)),
          child: Column(children: [
            Image.asset('assets/qr.png'),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 47, left: 47, right: 47),
              child: Text(
                'Open web.sociomee.com, desktop app, or other devices.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: AppColors.white),
              ),
            )
          ]),
        ));
  }
}
