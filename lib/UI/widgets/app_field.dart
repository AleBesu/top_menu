import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/providers/restaurant_provider.dart';

import '../../app/app_colors.dart';

class FieldTitle extends ConsumerWidget {
  const FieldTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Text(
    text.toUpperCase(),
    style: TextStyle(
      color: ref.watch(menuConfigProvider).primaryColor,
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
        ),
      ],
    );
  }
}

class TimeField extends StatelessWidget {
  final String label;
  final String? value;
  final ValueChanged<String> onChanged;
  const TimeField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  Future<void> _pick(BuildContext context) async {
    final parts = value!.split(':');
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
          color: Theme.of(context).inputDecorationTheme.fillColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.muted),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => _pick(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value ?? '12:00',
                      style: const TextStyle(fontSize: 14),
                    ),
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
