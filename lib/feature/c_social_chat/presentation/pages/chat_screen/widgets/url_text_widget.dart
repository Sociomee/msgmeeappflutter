import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                throw BotToast.showText(text: "could not launch this url!");
              }
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
