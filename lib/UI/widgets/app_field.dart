import 'package:flutter/material.dart';

import '../../app/app_colors.dart';

class FieldTitle extends StatelessWidget {
  const FieldTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: const TextStyle(
      color: AppColors.muted,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.9,
    ),
  );
}

OutlineInputBorder _border(Color c) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: BorderSide(color: c),
);

class AppField extends StatelessWidget {
  const AppField({
    super.key,
    required this.label,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.errorText,
  });

  final String label;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? hint;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldTitle(label),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14, color: AppColors.text),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.muted),
            errorText: errorText,
            filled: true,
            fillColor: AppColors.surface2,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: _border(AppColors.border),
            enabledBorder: _border(AppColors.border),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(AppColors.primary),
            focusedErrorBorder: _border(AppColors.primary),
          ),
        ),
      ],
    );
  }
}

class TimeField extends StatelessWidget {
  const TimeField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  Future<void> _pick(BuildContext context) async {
    final parts = value.split(':');
    final initial = TimeOfDay(
      hour: int.tryParse(parts.first) ?? 12,
      minute: parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0,
    );
    final t = await showTimePicker(context: context, initialTime: initial);
    if (t != null) {
      onChanged(
        '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldTitle(label),
        const SizedBox(height: 6),
        Material(
          color: AppColors.surface2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.border),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => _pick(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(value, style: const TextStyle(fontSize: 14)),
                  ),
                  const Icon(Icons.schedule, size: 16, color: AppColors.muted),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
