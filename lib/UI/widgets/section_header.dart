import 'package:flutter/material.dart';

import '../../app/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final Widget? actionBotton;
  final String title;
  const SectionHeader(this.title, {super.key, this.actionBotton});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              letterSpacing: 1.3,
            ),
          ),

          Spacer(),
          ?actionBotton,
        ],
      ),
    );
  }
}
