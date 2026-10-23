import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/app_colors.dart';
import '../../core/models/menu_category.dart';
import '../../core/models/product.dart';
import '../providers/restaurant_provider.dart';
import 'net_image.dart';
import 'product_sheet.dart';

class CategoryCard extends ConsumerStatefulWidget {
  const CategoryCard({super.key, required this.category});
  final MenuCategory category;

  @override
  ConsumerState<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends ConsumerState<CategoryCard> {
  bool _editing = false;
  late final _ctrl = TextEditingController(text: widget.category.name);

  RestaurantNotifier get _notifier =>
      ref.read(restaurantConfigProvider.notifier);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _commit() {
    if (!_editing) return;
    final v = _ctrl.text.trim();
    if (v.isEmpty) {
      _ctrl.text = widget.category.name;
    } else {
      _notifier.renameCategory(widget.category.id, v);
    }
    setState(() => _editing = false);
  }

  Future<void> _openSheet([Product? product]) async {
    final result = await showProductSheet(context, product: product);
    if (result != null && mounted) {
      _notifier.saveProduct(widget.category.id, result);
    }
  }

  Future<void> _confirmDelete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Eliminar categoría'),
        content: Text(
          '¿Eliminar "${widget.category.name}" y sus ${widget.category.products.length} platos?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Eliminar',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
    if (ok == true) _notifier.deleteCategory(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    final cat = widget.category;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          // Header
          Container(
            color: AppColors.surface2,
            padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
            child: Row(
              children: [
                Expanded(
                  child: _editing
                      ? TextField(
                          controller: _ctrl,
                          autofocus: true,
                          onSubmitted: (_) => _commit(),
                          onTapOutside: (_) => _commit(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => setState(() => _editing = true),
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              cat.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                ),
                Text(
                  '${cat.products.length} platos',
                  style: const TextStyle(fontSize: 11, color: AppColors.muted),
                ),
                IconButton(
                  onPressed: _confirmDelete,
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
          // Productos
          for (final p in cat.products)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 52,
                      height: 52,
                      child: FileImageWidget(p.imagePath),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          p.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${p.price}€',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _MiniBtn(label: 'Editar', onTap: () => _openSheet(p)),
                          const SizedBox(width: 4),
                          _MiniBtn(
                            label: '✕',
                            danger: true,
                            onTap: () => _notifier.deleteProduct(cat.id, p.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          // Añadir plato
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: cat.products.isEmpty
                  ? null
                  : const Border(top: BorderSide(color: AppColors.border)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _openSheet(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.muted,
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '+ Añadir plato',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniBtn extends StatelessWidget {
  const _MiniBtn({
    required this.label,
    required this.onTap,
    this.danger = false,
  });
  final String label;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: danger ? AppColors.redSoft : AppColors.surface2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: danger
            ? BorderSide.none
            : const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: danger ? AppColors.primary : AppColors.text,
            ),
          ),
        ),
      ),
    );
  }
}
