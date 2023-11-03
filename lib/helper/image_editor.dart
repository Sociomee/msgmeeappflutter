import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:msgmee/theme/colors.dart';

class ImageEditor extends StatefulWidget {
  final Uint8List imageData;

  ImageEditor({Key? key, required this.imageData}) : super(key: key);

  @override
  _ImageEditorState createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  ui.Image? _image;
  final Paint _editorPaint = Paint();
  Offset _rectanglePosition =
      Offset(50, 50); // Initial position of the rectangle

  @override
  void initState() {
    super.initState();
    loadAndEditImage();
  }

  Future<void> loadAndEditImage() async {
    final Uint8List imageData = widget.imageData;
    final ui.Codec codec = await ui.instantiateImageCodec(imageData);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    setState(() {
      _image = frameInfo.image;
    });
  }

  void moveRectangle(Offset position) {
    setState(() {
      _rectanglePosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
        ),
        title: Text(
          'Image Editor',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: _image != null
                ? GestureDetector(
                    onPanUpdate: (details) {
                      moveRectangle(_rectanglePosition + details.delta);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomPaint(
                        painter: ImageEditorPainter(
                            image: _image!,
                            editorPaint: _editorPaint,
                            rectanglePosition: _rectanglePosition),
                      ),
                    ),
                  )
                : CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

class ImageEditorPainter extends CustomPainter {
  final ui.Image image;
  final Paint editorPaint;
  final Offset rectanglePosition;

  ImageEditorPainter(
      {required this.image,
      required this.editorPaint,
      required this.rectanglePosition});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, Offset.zero, editorPaint);

    // Draw a red rectangle on the image at the specified position
    editorPaint.color = Colors.red;
    editorPaint.style = PaintingStyle.stroke;
    editorPaint.strokeWidth = 5.0;
    final rect = Rect.fromPoints(rectanglePosition,
        Offset(rectanglePosition.dx + 100, rectanglePosition.dy + 100));
    canvas.drawRect(rect, editorPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
