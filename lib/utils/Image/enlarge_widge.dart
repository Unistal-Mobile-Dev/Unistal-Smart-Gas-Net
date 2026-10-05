import 'dart:io';
import 'package:flutter/material.dart';

class EnlargeWidget extends StatelessWidget {
  final File? file;
  final String? imageUrl;

  const EnlargeWidget({
    super.key,
    this.file,
    this.imageUrl,
  });

  bool _isNetwork(String path) {
    final uri = Uri.tryParse(path);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }

  String _normalizePath(String path) {
    if (path.startsWith('file://')) {
      return path.replaceFirst('file://', '');
    }
    return path;
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    /// PRIORITY 1: File (safest)
    if (file != null) {
      imageWidget = Image.file(
        file!,
        fit: BoxFit.contain,
      );
    }

    /// PRIORITY 2: URL (network OR file:// handled properly)
    else if (imageUrl != null && imageUrl!.isNotEmpty) {
      if (_isNetwork(imageUrl!)) {
        imageWidget = Image.network(
          imageUrl!,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (_, __, ___) =>
          const Icon(Icons.error, color: Colors.white),
        );
      } else {
        final fixedPath = _normalizePath(imageUrl!);

        imageWidget = Image.file(
          File(fixedPath),
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
          const Icon(Icons.error, color: Colors.white),
        );
      }
    }

    /// FALLBACK
    else {
      imageWidget = const Icon(Icons.error, color: Colors.white);
    }

    return Stack(
      children: [
        Container(color: Colors.black),

        Center(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4,
            child: imageWidget,
          ),
        ),

        Positioned(
          top: 50,
          right: 10,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 4),
                ],
              ),
              child: const Icon(
                Icons.close,
                color: Colors.red,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}