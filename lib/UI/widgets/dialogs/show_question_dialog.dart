import 'package:flutter/material.dart';

Future<void> showQuestionDialog(
  BuildContext context, {
  required String question,
  String? title,
  Widget? icon,
  VoidCallback? onCancel,
  VoidCallback? onAccept,
}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: title != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[icon, SizedBox(width: 2)],
                Text(title),
              ],
            )
          : null,
      content: Text(question),
      actions: [
        OutlinedButton(onPressed: onCancel, child: Text("Cancelar")),
        SizedBox(width: 10),
        FilledButton(onPressed: onAccept, child: Text("Aceptar")),
      ],
    ),
  );
}
