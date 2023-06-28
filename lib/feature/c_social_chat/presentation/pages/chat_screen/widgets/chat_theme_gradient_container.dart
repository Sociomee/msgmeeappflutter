// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;
    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2),
        clockwise: clockwise);
    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;
  HalfCircleClipper({
    required this.side,
  });
  @override
  getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class ChatThemeColorContainer extends StatelessWidget {
  const ChatThemeColorContainer(
      {super.key, required this.leftColor, required this.rightColor});
  final Color leftColor;
  final Color rightColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipPath(
          clipper: HalfCircleClipper(side: CircleSide.left),
          child: Container(
            height: 36,
            width: 36,
            color: leftColor,
          ),
        ),
        ClipPath(
          clipper: HalfCircleClipper(side: CircleSide.right),
          child: Container(
            height: 36,
            width: 36,
            color: rightColor,
          ),
        )
      ],
    );
  }
}

class GradientColorContainer extends StatelessWidget {
  const GradientColorContainer(
      {super.key, required this.leftColor, required this.rightColor});
  final List<Color> leftColor;
  final List<Color> rightColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipPath(
          clipper: HalfCircleClipper(side: CircleSide.left),
          child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: leftColor)),
          ),
        ),
        ClipPath(
          clipper: HalfCircleClipper(side: CircleSide.right),
          child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: rightColor)),
          ),
        )
      ],
    );
  }
}
