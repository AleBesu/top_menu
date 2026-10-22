import 'package:flutter/material.dart';
import '../core/app_colors.dart';

/// Imagen de red que rellena su contenedor, con placeholder si falla o está vacía.
class NetImage extends StatelessWidget {
  const NetImage(this.url, {super.key, this.fit = BoxFit.cover});
  final String url;
  final BoxFit fit;

  Widget get _placeholder => Container(
        color: AppColors.surface2,
        alignment: Alignment.center,
        child: const Icon(Icons.image_outlined, color: AppColors.muted),
      );

  @override
  Widget build(BuildContext context) {
    if (url.trim().isEmpty) return _placeholder;
    return Image.network(
      url,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => _placeholder,
      loadingBuilder: (_, child, progress) =>
          progress == null ? child : _placeholder,
    );
  }
}
