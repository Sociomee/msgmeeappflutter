import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../common_widgets/checkbox_widget.dart';

class BlockUserPopupWidget extends StatefulWidget {
  const BlockUserPopupWidget({super.key});

  @override
  State<BlockUserPopupWidget> createState() => _BlockUserPopupWidgetState();
}

class _BlockUserPopupWidgetState extends State<BlockUserPopupWidget> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: EdgeInsets.symmetric(horizontal: 21.w),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                  'You are going to block this contact. You cannot call and chats to this contact after blocking.',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400)),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  SizedBox(
                      width: 16,
                      child: CheckBoxWidget(
                        selected: selected,
                        onChange: (e) {
                          setState(() {
                            selected = !selected;
                          });
                        },
                      )),
                  SizedBox(width: 8),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: Text('Report contact',
                          style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300)))
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel',
                        style: TextStyle(
                            color: Color(0xFF368C4E),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500))),
                SizedBox(width: 42),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text('Block',
                          style: TextStyle(
                              color: Color(0xFF368C4E),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
