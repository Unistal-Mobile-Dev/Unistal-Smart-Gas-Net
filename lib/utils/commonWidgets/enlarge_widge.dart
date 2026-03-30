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

  @override
  Widget build(BuildContext context) {
    final bool isNetwork = imageUrl != null && imageUrl!.isNotEmpty;

    return Stack(
      children: [
        /// Background
        Container(color: Colors.black),

        /// Image Viewer
        Center(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4,
            child: isNetwork
                ? Image.network(
              imageUrl!,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.error, color: Colors.white),
            )
                : file != null
                ? Image.file(
              file!,
              fit: BoxFit.contain,
            )
                : const Icon(Icons.error, color: Colors.white),
          ),
        ),

        /// Close Button
        Positioned(
          top: 50,
          right: 10,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // background color
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                  ),
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