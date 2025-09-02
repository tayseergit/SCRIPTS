import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class YellowProgressLine extends StatelessWidget {
  final double progress; // from 0.0 to 1.0
  final double height;
  final double radius;

  const YellowProgressLine({
    Key? key,
    required this.progress,
    this.height = 8,
    this.radius = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: height,
      percent: progress.clamp(0.0, 1.0),
      backgroundColor: Colors.grey.shade300,
      progressColor: Colors.yellow,
      barRadius: Radius.circular(radius),
      animation: true,
      animationDuration: 600,
    );
  }
}
