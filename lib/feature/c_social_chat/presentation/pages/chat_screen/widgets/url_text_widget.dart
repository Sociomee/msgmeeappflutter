// import 'dart:developer';

// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class UrlTextWidget extends StatelessWidget {
//   const UrlTextWidget({super.key, required this.text});
//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     List<TextSpan> textSpans = [];
//     int currentIndex = 0;
//     RegExp urlRegExp = RegExp(
//       r"https?://[^\s]+",
//       caseSensitive: false,
//     );
//     urlRegExp.allMatches(text).forEach((match) {
//       final url = match.group(0);
//       final preMatch = text.substring(currentIndex, match.start);
//       textSpans.add(
//         TextSpan(text: preMatch),
//       );
//       textSpans.add(
//         TextSpan(
//           text: url,
//           style: TextStyle(
//               color: Color.fromARGB(255, 127, 197, 255),
//               fontSize: 14), // Change the color to your desired color
//           recognizer: TapGestureRecognizer()
//             ..onTap = () async {
//               log('clicking link..');

//               if (!await launchUrl(Uri.parse(url!))) {
//                 throw BotToast.showText(text: "could not launch this url!");
//               }
//             },
//         ),
//       );
//       currentIndex = match.end;
//     });

//     if (currentIndex < text.length) {
//       textSpans.add(
//         TextSpan(text: text.substring(currentIndex)),
//       );
//     }

//     return RichText(text: TextSpan(children: textSpans));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:msgmee/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlTextWidget extends StatefulWidget {
  final String text;
  final int maxLines;

  UrlTextWidget({Key? key, required this.text, this.maxLines = 11})
      : super(key: key);

  @override
  _UrlTextWidgetState createState() => _UrlTextWidgetState();
}

class _UrlTextWidgetState extends State<UrlTextWidget> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    int currentIndex = 0;
    final text = widget.text;

    RegExp urlRegExp = RegExp(
      r"https?://[^\s]+",
      caseSensitive: false,
    );

    urlRegExp.allMatches(text).forEach((match) {
      final url = match.group(0);
      final preMatch = text.substring(currentIndex, match.start);
      textSpans.add(
        TextSpan(text: preMatch),
      );
      textSpans.add(
        TextSpan(
          text: url,
          style: TextStyle(
            color: Color.fromARGB(255, 127, 197, 255),
            fontSize: 14,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              print('clicking link..');

              if (!await canLaunch(url!)) {
                throw Exception("Could not launch this URL: $url");
              }

              await launch(url);
            },
        ),
      );
      currentIndex = match.end;
    });

    if (currentIndex < text.length) {
      textSpans.add(
        TextSpan(text: text.substring(currentIndex)),
      );
    }

    final richText = RichText(
      text: TextSpan(children: textSpans),
      maxLines: showMore ? null : widget.maxLines,
      overflow: TextOverflow.clip,
    );

    final isTextOverflowed =
        richText.text.toPlainText().split('\n').length > widget.maxLines;

    return Column(
      children: [
        richText,
        if (isTextOverflowed && !showMore)
          Row(
            children: [
              Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    showMore = true;
                  });
                },
                child: Text(
                  '...See More',
                  style: TextStyle(color: AppColors.white, fontSize: 12),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
