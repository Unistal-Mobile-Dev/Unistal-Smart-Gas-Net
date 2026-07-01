import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/utils/res/environment_config.dart';

class PhotoUploadWidget extends StatelessWidget {
  final File? file;
  final VoidCallback onTap;
  final String? title;
  final bool isRequired;

  const PhotoUploadWidget({
    super.key,
    required this.file,
    required this.onTap,
    this.title,
    this.isRequired = false,
  });

  bool get _hasFile => file != null && file!.path.isNotEmpty;

  bool get _isImage {
    final path = file?.path.toLowerCase() ?? '';
    return path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.png');
  }

  bool get _isPdf => file?.path.toLowerCase().endsWith('.pdf') ?? false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title!.isNotEmpty) ...[
          _titleLabel(context),
          const SizedBox(height: 6),
        ],
        GestureDetector(
          onTap: onTap,
          child: _hasFile ? _previewState(context) : _emptyState(context),
        ),
      ],
    );
  }

  Widget _emptyState(BuildContext context) {
    // ✅ FIX 1: EnvironmentConfig se color leke painter ko pass karo
    //    CustomPainter ke andar context nahi hota
    final primaryColor = EnvironmentConfig.of(context)!.primaryTheme;

    return CustomPaint(
      painter: _DottedBorderPainter(
        color: primaryColor,
        borderRadius: 10,
        dashWidth: 6,
        dashSpace: 4,
      ),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.09,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_camera_outlined,
              size: 28,
              color: Theme.of(context).hintColor,
            ),
            const SizedBox(height: 6),
            Text(
              'Tap to add photo',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _titleLabel(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        children: [
          if (isRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  Widget _previewState(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            _previewContent(context),
            _refreshOverlay(context),
          ],
        ),
        const SizedBox(height: 4),
        _addedBadge(context),
      ],
    );
  }

  Widget _previewContent(BuildContext context) {
    if (_isImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          file!,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.09,
          fit: BoxFit.cover,
        ),
      );
    }
    if (_isPdf) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.picture_as_pdf_outlined,
                size: 32,
                color: EnvironmentConfig.of(context)!.primaryTheme,
              ),
              const SizedBox(height: 6),
              Text(
                file!.path.split('/').last,
                style: TextStyle(
                  fontSize: 11,
                  color: EnvironmentConfig.of(context)!.primaryTheme,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Icon(Icons.insert_drive_file_outlined, size: 32),
      ),
    );
  }

  Widget _refreshOverlay(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(
            Icons.refresh_rounded,
            color: EnvironmentConfig.of(context)!.primaryTheme,
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget _addedBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 13,
            color: EnvironmentConfig.of(context)!.primaryTheme,
          ),
          const SizedBox(width: 4),
          Text(
            'Added',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: EnvironmentConfig.of(context)!.primaryTheme,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Dotted border painter ──────────────────────────────────────────────────

// ✅ FIX 1: color bahar se pass hota hai — context yahan nahi chahiye
class _DottedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  final double dashWidth;
  final double dashSpace;

  _DottedBorderPainter({
    required this.color,
    required this.borderRadius,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_DottedBorderPainter old) =>
      old.color != color ||
          old.dashWidth != dashWidth ||
          old.dashSpace != dashSpace;
}

// ── Bottom sheet picker ────────────────────────────────────────────────────

class MediaPickerSheet extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback? onFile;

  const MediaPickerSheet({
    super.key,
    required this.onCamera,
    required this.onGallery,
    this.onFile,
  });

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onCamera,
    required VoidCallback onGallery,
    VoidCallback? onFile,
  }) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,       // ✅ root navigator use karo
      backgroundColor: Colors.transparent,
      builder: (_) => MediaPickerSheet(
        onCamera: onCamera,
        onGallery: onGallery,
        onFile: onFile,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            _handle(context),
            const SizedBox(height: 8),
            _option(
              context,
              icon: Icons.photo_camera_outlined,
              label: 'Camera',
              onTap: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  onCamera();
                });
              },
            ),
            _divider(context),
            _option(
              context,
              icon: Icons.photo_library_outlined,
              label: 'Gallery',
              onTap: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  onGallery();
                });
              },
            ),
            if (onFile != null) ...[
              _divider(context),
              _option(
                context,
                icon: Icons.insert_drive_file_outlined,
                label: 'Browse files',
                onTap: () {
                 WidgetsBinding.instance.addPostFrameCallback((_) {
                    onFile!();
                  });
                },
              ),
            ],
            _divider(context),
            _cancelButton(context),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _handle(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _option(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Theme.of(context).hintColor),
            const SizedBox(width: 16),
            Text(label, style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Divider(
      height: 0.5,
      thickness: 0.5,
      indent: 20,
      endIndent: 20,
      color: Theme.of(context).dividerColor,
    );
  }

  Widget _cancelButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true).pop(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Center(
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ),
    );
  }
}
