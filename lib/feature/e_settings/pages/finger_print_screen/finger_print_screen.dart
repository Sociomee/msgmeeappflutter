import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../theme/colors.dart';

enum TimeDuration { immediatly, onemin, thirtymin }

class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({super.key});

  @override
  State<FingerPrintScreen> createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  bool fingerprinteneble = false;
  bool notification = false;
  TimeDuration? groupvalue = TimeDuration.immediatly;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 2,
          titleSpacing: 0,
          leadingWidth: 50,
          shadowColor: AppColors.lightgrey1,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.arrow_back_ios,
                    color: AppColors.black, size: 20),
              )),
          title: Text('Fingerprint Lock',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enable fingerprint unlock',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "You have to use your fingerprint to open the\nMsgMee. You can't access MsgMee features\nwithout unlocking it.",
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 41,
                child: FlutterSwitch(
                  switchBorder: Border.all(
                    color: fingerprinteneble
                        ? AppColors.primaryColor
                        : AppColors.lightgrey,
                  ),
                  activeColor: AppColors.primaryColor,
                  inactiveColor: AppColors.white,
                  inactiveToggleColor: AppColors.lightgrey,
                  width: 41.0,
                  height: 25,
                  toggleSize: 23,
                  value: fingerprinteneble,
                  borderRadius: 30.0,
                  padding: 0.0,
                  onToggle: (val) {
                    setState(() {
                      fingerprinteneble = !fingerprinteneble;
                    });
                  },
                ),
              ),
            ],
          ),
          Divider(
            color: AppColors.lightgrey1,
            height: 48,
            thickness: 1,
          ),
          Opacity(
            opacity: fingerprinteneble ? 1 : 0.50,
            child: Text(
              'Your mobile will automatically lock',
              style: TextStyle(
                color: Color(0xFF575757),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.50,
              ),
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Immediatly',
                style: TextStyle(
                  color: fingerprinteneble ? AppColors.black : AppColors.grey,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Radio<TimeDuration>(
                  fillColor: MaterialStateColor.resolveWith((states) =>
                      fingerprinteneble && groupvalue == TimeDuration.immediatly
                          ? AppColors.primaryColor
                          : AppColors.lightgrey),
                  activeColor: fingerprinteneble
                      ? AppColors.primaryColor
                      : AppColors.lightgrey,
                  value: TimeDuration.immediatly,
                  groupValue: groupvalue,
                  onChanged: (TimeDuration? e) {
                    setState(() {
                      groupvalue = e;
                    });
                  })
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'After 1 minute',
                style: TextStyle(
                  color: fingerprinteneble ? AppColors.black : AppColors.grey,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Radio<TimeDuration>(
                  fillColor: MaterialStateColor.resolveWith((states) =>
                      fingerprinteneble && groupvalue == TimeDuration.onemin
                          ? AppColors.primaryColor
                          : AppColors.lightgrey),
                  activeColor: fingerprinteneble
                      ? AppColors.primaryColor
                      : AppColors.lightgrey,
                  value: TimeDuration.onemin,
                  groupValue: groupvalue,
                  onChanged: (TimeDuration? e) {
                    setState(() {
                      groupvalue = e;
                    });
                  })
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'After 30 minute',
                style: TextStyle(
                  color: fingerprinteneble ? AppColors.black : AppColors.grey,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Radio<TimeDuration>(
                  fillColor: MaterialStateColor.resolveWith((states) =>
                      fingerprinteneble && groupvalue == TimeDuration.thirtymin
                          ? AppColors.primaryColor
                          : AppColors.lightgrey),
                  activeColor: fingerprinteneble
                      ? AppColors.primaryColor
                      : AppColors.lightgrey,
                  value: TimeDuration.thirtymin,
                  groupValue: groupvalue,
                  onChanged: (TimeDuration? e) {
                    setState(() {
                      groupvalue = e;
                    });
                  })
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: notification ? AppColors.black : AppColors.grey,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Enable preview of messages on lock screen.",
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 41,
                child: FlutterSwitch(
                  switchBorder: Border.all(
                    color: notification
                        ? AppColors.primaryColor
                        : AppColors.lightgrey,
                  ),
                  activeColor: AppColors.primaryColor,
                  inactiveColor: AppColors.white,
                  inactiveToggleColor: AppColors.lightgrey,
                  width: 41.0,
                  height: 25,
                  toggleSize: 23,
                  value: notification,
                  borderRadius: 30.0,
                  padding: 0.0,
                  onToggle: (val) {
                    setState(() {
                      notification = !notification;
                    });
                  },
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
