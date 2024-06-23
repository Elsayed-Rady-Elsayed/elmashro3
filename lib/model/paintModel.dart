import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ObjectDetectionPainter extends CustomPainter {
  final List<dynamic> results;
  final int imageWidth;
  final int imageHeight;

  ObjectDetectionPainter(this.results, this.imageWidth, this.imageHeight);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (var result in results) {
      final double x = result['rect']['x'];
      final double y = result['rect']['y'];
      final double width = result['rect']['w'];
      final double height = result['rect']['h'];

      final rect = Rect.fromLTWH(
        x * size.width / imageWidth,
        y * size.height / imageHeight,
        width * size.width / imageWidth,
        height * size.height / imageHeight,
      );

      canvas.drawRect(rect, paint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: result['tag'],
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: size.width);
      textPainter.paint(canvas, Offset(rect.left, rect.top));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
