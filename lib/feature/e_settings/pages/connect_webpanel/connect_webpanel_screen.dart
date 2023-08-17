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
                icon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.black,
                    size: 17,
                  ),
                )),
            leadingWidth: 40,
            titleSpacing: 0,
            title: Text(
              'Scan QR',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            )),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: AppColors.black.withOpacity(0.6)),
          child: Column(children: [
            Image.asset('assets/qr.png'),
            Spacer(),
            Padding(
                padding: const EdgeInsets.only(bottom: 47, left: 30, right: 30),
                child: Text(
                  'Open web.sociomee.com, desktop app, or other devices.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ))
          ]),
        ));
  }
}
