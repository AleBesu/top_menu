import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/providers/restaurant_provider.dart';

import '../../app/app_colors.dart';

class SectionHeader extends ConsumerWidget {
  final Widget? actionBotton;
  final String title;
  const SectionHeader(this.title, {super.key, this.actionBotton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),

      // decoration: const BoxDecoration(
      //   // border: Border(bottom: BorderSide(color: AppColors.border)),
      // ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: ref.watch(menuConfigProvider).primaryColor,
                  letterSpacing: 1.3,
                ),
              ),

              Spacer(),
              ?actionBotton,
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1, indent: 8, endIndent: 8),
          ),
        ],
      ),
    );
  }
}
