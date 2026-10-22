import 'package:flutter/material.dart';

import '../../app/app_colors.dart';

enum BtnVariant { primary, ghost, danger }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = BtnVariant.primary,
  });

  final String label;
  final VoidCallback onPressed;
  final BtnVariant variant;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, side) = switch (variant) {
      BtnVariant.primary => (AppColors.primary, Colors.white, BorderSide.none),
      BtnVariant.ghost => (
        AppColors.surface2,
        AppColors.text,
        const BorderSide(color: AppColors.border),
      ),
      BtnVariant.danger => (
        AppColors.redSoft,
        AppColors.primary,
        BorderSide.none,
      ),
    };
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: side,
        ),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      child: Text(label),
    );
  }
}
