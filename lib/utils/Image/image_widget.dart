import 'dart:io';
import 'package:flutter/material.dart';
import 'enlarge_widge.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool isRequired;
  final VoidCallback onPressed;

  const ImageWidget({
    super.key,
    required this.imagePath,
    required this.title,
    this.isRequired = false,
    required this.onPressed,
  });

  /// ✅ Better network detection
  bool _isNetworkPath(String path) {
    final uri = Uri.tryParse(path);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }

  /// ✅ Normalize file:// → real file path
  String _normalizePath(String path) {
    if (path.startsWith('file://')) {
      return path.replaceFirst('file://', '');
    }
    return path;
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imagePath.isNotEmpty;
    final bool isNetwork = _isNetworkPath(imagePath);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.15,
      child: InkWell(
        onTap: onPressed,
        child: hasImage
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              _buildImage(isNetwork),

              /// 🔍 Zoom Button
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (!hasImage) return;

                    final fixedPath = _normalizePath(imagePath);

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.black,
                      builder: (_) => EnlargeWidget(
                        file: isNetwork ? null : File(fixedPath),
                        imageUrl: isNetwork ? imagePath : null,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.zoom_out_map,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
            : _emptyCard(),
      ),
    );
  }

  /// 🖼 Image Builder
  Widget _buildImage(bool isNetwork) {
    if (isNetwork) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (_, __, ___) => _emptyCard(),
      );
    } else {
      final fixedPath = _normalizePath(imagePath);

      return Image.file(
        File(fixedPath),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => _emptyCard(),
      );
    }
  }

  /// 📭 Empty State
  Widget _emptyCard() {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_a_photo),
            const SizedBox(height: 4),

            if (isRequired)
              const Text(
                "*",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),

            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}