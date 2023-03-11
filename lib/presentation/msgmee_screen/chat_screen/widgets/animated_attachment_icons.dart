import 'package:flutter/material.dart';
import 'package:msgmee/theme/custom_theme.dart';

const bottomSize = 30.0;

class FlowAnimationWidget extends StatefulWidget {
  const FlowAnimationWidget({super.key});

  @override
  State<FlowAnimationWidget> createState() => _FlowAnimationWidgetState();
}

class _FlowAnimationWidgetState extends State<FlowAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(controller: controller),
      children: [
        'assets/file.png',
        'assets/audio.png',
        'assets/contact.png',
        'assets/gallery.png'
      ].map(buildItem).toList(),
    );
  }

  Widget buildItem(String url) => SizedBox(
        height: bottomSize,
        width: bottomSize,
        child: FloatingActionButton(
            elevation: 0,
            splashColor: CustomTheme.seconderyColor,
            onPressed: () {
              controller.status == AnimationStatus.completed
                  ? controller.reverse()
                  : controller.forward();
            },
            child: Image.asset(url)),
      );
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;

  FlowMenuDelegate({required this.controller}) : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - bottomSize;
    final yStart = size.height - bottomSize;
    for (int i = context.childCount - 1; i >= 0; i--) {
      const margin = 8;
      final childSize = context.getChildSize(i)!.width;
      final dx = (childSize + margin) * i;
      final x = xStart - dx * 0.7 * controller.value;
      final y = yStart - dx * 0.7 * controller.value;
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) => false;
}
