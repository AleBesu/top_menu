import 'package:flutter/material.dart';

Future<void> showLoadingDialog(
  BuildContext context, {
  String text = "Cargando...",
}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [CircularProgressIndicator(), Text(text)],
          ),
        ),
      ),
    ),
  );
}
