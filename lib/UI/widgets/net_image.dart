import 'dart:io';

import 'package:flutter/material.dart';

import '../../app/app_colors.dart';

/// Imagen de red que rellena su contenedor, con placeholder si falla o está vacía.
class FileImageWidget extends StatelessWidget {
  const FileImageWidget(this.path, {super.key, this.fit = BoxFit.cover});
  final String? path;
  final BoxFit fit;

  Widget get _placeholder => Container(
    color: AppColors.surface2,
    alignment: Alignment.center,
    child: const Icon(Icons.image_outlined, color: AppColors.muted),
  );

  @override
  Widget build(BuildContext context) {
    if (path?.trim().isEmpty ?? true) return _placeholder;

    return Image.file(
      File(path!),
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, _, _) => _placeholder,
    );
  }
}
