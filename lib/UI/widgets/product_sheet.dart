import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:top_menu/UI/providers/restaurant_provider.dart';
import 'package:top_menu/core/services/file_handle/file_handle.dart';

import '../../app/app_colors.dart';
import '../../core/utils.dart';
import '../../core/models/product.dart';
import 'app_button.dart';
import 'app_field.dart';
import 'file_image_widget.dart';

/// Abre el formulario de producto. Devuelve el producto guardado o null.
Future<Product?> showProductSheet(BuildContext context, {Product? product}) {
  return showModalBottomSheet<Product>(
    context: context,
    isScrollControlled: true,
    // backgroundColor: AppColors.surface,
    constraints: const BoxConstraints(maxWidth: 480),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _ProductSheet(product: product),
  );
}

class _ProductSheet extends ConsumerStatefulWidget {
  const _ProductSheet({this.product});
  final Product? product;

  @override
  ConsumerState<_ProductSheet> createState() => _ProductSheetState();
}

class _ProductSheetState extends ConsumerState<_ProductSheet> {
  late String? _imagePath = widget.product?.imagePath;
  late final _name = TextEditingController(text: widget.product?.name ?? '');
  late final _desc = TextEditingController(
    text: widget.product?.description ?? '',
  );
  late final _price = TextEditingController(text: widget.product?.price ?? '');
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    _price.dispose();
    super.dispose();
  }

  void _save() {
    setState(() => _submitted = true);
    final name = _name.text.trim();
    final price = _price.text.trim().replaceAll(',', '.');
    if (name.isEmpty || price.isEmpty) return;
    Navigator.pop(
      context,
      Product(
        id: widget.product?.id ?? uid(),
        name: name,
        description: _desc.text.trim(),
        price: price,
        imagePath: _imagePath,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    isEdit ? 'Editar producto' : 'Nuevo producto',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColors.muted),
                ),
              ],
            ),

            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 140,
                child: Stack(
                  children: [
                    FileImageWidget(_imagePath),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton.filled(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          final newImage =
                              await FilesManagerService.pickerImage(
                                copyToAppDirectory: true,
                                // aspectRatio: CropAspectRatio(
                                //   ratioX: 1,
                                //   ratioY: 1,
                                // ),
                              );

                          if (newImage != null) {
                            setState(() {
                              _imagePath = newImage.file.path;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            AppField(
              label: 'Nombre',
              controller: _name,
              hint: 'Ej. Margherita',
              errorText: _submitted && _name.text.trim().isEmpty
                  ? 'Obligatorio'
                  : null,
            ),
            const SizedBox(height: 16),
            AppField(
              label: 'Descripción',
              controller: _desc,
              hint: 'Ingredientes, preparación...',
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            AppField(
              label: 'Precio (\$)',
              controller: _price,
              hint: '0.00',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              errorText: _submitted && _price.text.trim().isEmpty
                  ? 'Obligatorio'
                  : null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                AppButton(
                  label: 'Cancelar',
                  variant: BtnVariant.ghost,
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppButton(label: 'Guardar producto', onPressed: _save),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
