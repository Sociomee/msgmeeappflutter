import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msgmee/theme/custom_theme.dart';

class SingleCallScreen extends StatelessWidget {
  const SingleCallScreen({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 86;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.9675,
              ),
              Positioned(bottom: 0, child: Image.asset('assets/overlay.png')),
              Positioned(
                  top: 76,
                  left: width.w / 2,
                  child: Text(
                    'Anurag',
                    style: TextStyle(
                        color: CustomTheme.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  )),
              Positioned(
                top: 126,
                left: width.w / 2,
                child: Row(
                  children: [
                    Image.asset('assets/call_outgoing.png', height: 20),
                    SizedBox(width: 5),
                    Text(
                      'Ringing...',
                      style: TextStyle(
                        color: CustomTheme.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 86,
                  left: (width / 2).w,
                  // right: width / 2,
                  child: InkWell(
                    splashColor: Colors.red,
                    onTap: () {},
                    child: Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CustomTheme.errorRedColor,
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.phone,
                        color: CustomTheme.white,
                      ),
                    ),
                  ))
            ],
          ),
        ],
      )),
    );
  }
}
