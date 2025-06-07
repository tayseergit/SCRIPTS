import 'package:flutter/widgets.dart';

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // ابدأ من أعلى اليسار بارتفاع 55
    path.lineTo(0, 55);

    // من اليسار إلى المنتصف (ارتفاع 61)
    path.quadraticBezierTo(
      size.width * 0.25, 70,       // نقطة تحكم
      size.width * 0.3, 65,        // النقطة العليا
    );

    // من المنتصف إلى اليمين يتراجع حتى 0
    path.quadraticBezierTo(
      size.width * 0.55, 70,       // نقطة تحكم منحنية نزولًا
      size.width,3,               // نهاية عند اليمين صفر
    );

    // إغلاق من اليمين للأعلى
    path.lineTo(size.width, 0);
    path.lineTo(0, 0); // العودة لبداية الخط العلوي
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
