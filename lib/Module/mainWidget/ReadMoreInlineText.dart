import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';

class ReadMoreInlineText extends StatefulWidget {
  final String text;
  final int trimLength;

  const ReadMoreInlineText({
    super.key,
    required this.text,
    this.trimLength = 400,
  });

  @override
  State<ReadMoreInlineText> createState() => _ReadMoreInlineTextState();
}

class _ReadMoreInlineTextState extends State<ReadMoreInlineText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    final String fullText = widget.text;
    final bool isLong = fullText.length > widget.trimLength;
    final String visibleText = !_isExpanded && isLong
        ? fullText.substring(0, widget.trimLength)
        : fullText;

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          color: appColors.secondText,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(text: visibleText),
          if (!_isExpanded && isLong)
            TextSpan(
              text: '... Read More',
              style: TextStyle(
                color: appColors.primary,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Details'),
                      content: Text(fullText),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
            ),
        ],
      ),
    );
  }
}

class ReadMoreInlineTextProject extends StatefulWidget {
  final String text;
  final int trimLength;

  const ReadMoreInlineTextProject({
    super.key,
    required this.text,
    this.trimLength = 400,
  });

  @override
  State<ReadMoreInlineTextProject> createState() =>
      _ReadMoreInlineTextProject();
}

class _ReadMoreInlineTextProject extends State<ReadMoreInlineTextProject> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    final String fullText = widget.text;
    final bool isLong = fullText.length > widget.trimLength;
    final String visibleText = !_isExpanded && isLong
        ? fullText.substring(0, widget.trimLength)
        : fullText;

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 13.sp,
          color: appColors.secondText,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(text: visibleText),
          if (!_isExpanded && isLong)
            TextSpan(
              text: '... Read More',
              style: TextStyle(
                color: appColors.primary,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Details'),
                      content: Text(fullText),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
            ),
        ],
      ),
    );
  }
}
