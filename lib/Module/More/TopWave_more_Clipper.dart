import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopWaveMoreClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var controlPoint1 = Offset(size.width / 4, size.height * 0.10);
    var controlPoint2 = Offset(size.width * 0.75, size.height * 0.75);
    var endPoint1 = Offset(size.width, 0);
    var controlPoint3 = Offset(size.width - 100.w, 0);
    var controlPoint4 = Offset(size.width - 50.w, 20.h);
    var endPoint = Offset(size.width, 10.h);

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
