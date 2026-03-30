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

  bool _isNetworkPath(String path) =>
      path.startsWith('http://') || path.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imagePath.isNotEmpty;
    final bool isNetwork = _isNetworkPath(imagePath);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        /// 🔴 Title with required *
        Text.rich(
          TextSpan(
            children: [
              if (isRequired) TextSpan(text: "* ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              TextSpan(text: title, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800)),
            ],
          ),
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.001),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.12,
          child: InkWell(
              onTap: onPressed,
              child: hasImage
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    _buildImage(isNetwork),
          
                    /// Zoom Button
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (!hasImage) return;
          
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.black,
                            builder: (_) => EnlargeWidget(
                              file: isNetwork
                                  ? null
                                  : File(imagePath),
                              imageUrl:
                              isNetwork ? imagePath : null,
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
        ),

      ],
    );
  }

  /// Image Builder
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
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
  }

  /// Empty State
  Widget _emptyCard() {
    return const Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo),
            SizedBox(height: 4),
            Text(
              "Tap to add photo",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 7),
            ),
          ],
        ),
      ),
    );
  }
}