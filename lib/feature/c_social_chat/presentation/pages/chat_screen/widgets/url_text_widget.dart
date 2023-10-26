import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlTextWidget extends StatelessWidget {
  const UrlTextWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    int currentIndex = 0;
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
              fontSize: 14), // Change the color to your desired color
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              log('clicking link..');
              if (!await launchUrl(Uri.parse(url!))) {
                throw Exception('Could not launch $url');
              }
              // await launchUrlString(url!);
              // if (await canLaunch(url!)) {
              //   await launch(url);
              // } else {
              //   print('Could not launch $url');
              // }
              // Handle URL click (e.g., open the link)
              // You can use a package like url_launcher to open the link.
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

    return RichText(text: TextSpan(children: textSpans));
  }
}
