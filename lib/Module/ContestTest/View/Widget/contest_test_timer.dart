import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContestTestTimer extends StatefulWidget {
  final int secondsLeft; // now passed directly from API (seconds)
  final VoidCallback onTimeFinished;

  const ContestTestTimer({
    super.key,
    required this.secondsLeft,
    required this.onTimeFinished,
  });

  @override
  State<ContestTestTimer> createState() => _ContestTestTimerState();
}

class _ContestTestTimerState extends State<ContestTestTimer> {
  late int remainingSeconds;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.secondsLeft; // already in seconds
    startTimer();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
        widget.onTimeFinished();
      }
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  String formatTime(int totalSeconds) {
    if (totalSeconds >= 60) {
      int minutes = totalSeconds ~/ 60;
      int seconds = totalSeconds % 60;
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return totalSeconds.toString().padLeft(2, '0');
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = remainingSeconds / widget.secondsLeft;

    // Interpolate from green → red
    Color timerColor = Color.lerp(
      Colors.red,
      Colors.green,
      progress,
    )!;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 80.w,
          height: 80.w,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 10,
            color: timerColor,
            backgroundColor: Colors.grey[300],
          ),
        ),
        Text(
          formatTime(remainingSeconds),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: timerColor,
          ),
        ),
      ],
    );
  }
}
