import 'package:flutter/material.dart';

class CornerDecorationPainter extends CustomPainter {
  final Color color;
  final bool isMirrored;
  final bool isFlipped;

  CornerDecorationPainter({
    required this.color,
    this.isMirrored = false,
    this.isFlipped = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    if (!isFlipped) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }

    if (isMirrored) {
      final matrix = Matrix4.identity()
        ..translate(size.width, 0)
        ..scale(-1.0, 1.0);
      path.transform(matrix.storage);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}