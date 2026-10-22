import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/core/models/menu_category.dart';

import '../../../app/app_colors.dart';
import '../../providers/restaurant_provider.dart';
import '../../widgets/category_card.dart';
import '../../widgets/section_header.dart';

class MenuTab extends ConsumerWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(
      restaurantProvider.select((c) => c.categories),
    );

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        SectionHeader('Carta — ${categories.length} categorías'),
        for (final c in categories)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CategoryCard(key: ValueKey(c.id), category: c),
          ),
        OutlinedButton(
          onPressed: () async {
            final newCategory = await showAddCategorySheet(context);
            if (newCategory != null) {
              ref.read(restaurantProvider.notifier).addCategory(newCategory);
            }
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.muted,
            side: const BorderSide(color: AppColors.border),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            '+ Nueva categoría',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  static Future<MenuCategory?> showAddCategorySheet(
    BuildContext context,
  ) async {
    final nameController = TextEditingController();

    return await showModalBottomSheet<MenuCategory>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nueva categoría',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la categoría',
                  hintText: 'Ej. Hamburguesas',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.restaurant_menu,
                    color: Colors.white60,
                  ),
                ),
                onSubmitted: (value) {
                  final name = value.trim();

                  if (name.isEmpty) return;

                  Navigator.pop(context, MenuCategory(name: name));
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () {
                    final name = nameController.text.trim();

                    if (name.isEmpty) return;

                    Navigator.pop(context, MenuCategory(name: name));
                  },
                  child: const Text(
                    'Crear categoría',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
