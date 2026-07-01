import 'package:flutter/material.dart';

class ImagePopWidget extends StatelessWidget {
  final VoidCallback? onTapGallery, onTapCamera;

  const ImagePopWidget({
    super.key,
    this.onTapGallery,
    this.onTapCamera,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: onTapGallery,
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: onTapCamera,
            ),
          ],
        ),
      ),
    );
  }
}