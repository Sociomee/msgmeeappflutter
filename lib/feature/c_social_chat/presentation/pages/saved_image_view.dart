import 'package:flutter/material.dart';

class SavedImageView extends StatelessWidget {
  const SavedImageView({super.key, required this.image, required this.caption});
  final String image;
  final String caption;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(image), Text(caption)],
    );
  }
}
