import 'package:flutter/material.dart';
import 'package:lms/generated/l10n.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    Key? key,
    required this.title,
    required this.content,
    this.cancelText = "Cancel",
    this.confirmText = "Yes",
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(confirmText),
        ),
      ],
    );
  }
}

// طريقة استخدامه من أي صفحة:
void showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
  String ?cancelText ,
  String ?confirmText ,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return ConfirmDialog(
        title: title,
        content: content,
        cancelText: S.of(context).cancel,
        confirmText: S.of(context).confirm,
        onConfirm: onConfirm,
      );
    },
  );
}
