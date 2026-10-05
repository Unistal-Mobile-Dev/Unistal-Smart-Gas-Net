import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/services/location/location_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonWidgets/snack_bar_error_widget.dart';
import 'package:image_picker/image_picker.dart';

import 'image_stamp_helper.dart';

/// Camera / File pick karta hai aur image par location stamp lagata hai.
class MediaPickerHelper {
  static const _imageExt = ['jpg', 'jpeg', 'png'];
  static const _allowedExt = ['jpg', 'jpeg', 'png', 'pdf', 'doc'];

  // ===========================================================================
  // CAMERA
  // ===========================================================================
  static Future<File?> imagePiker({required BuildContext context}) async {
    try {
      // Camera khulne se PEHLE location confirm karo
      if (!await LocationHelper.ensureLocationReady(context)) {
        _showError(context, "Location is required to take a photo.");
        return null;
      }

      final XFile? photo = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
        maxHeight: 1200,
        maxWidth: 950,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (photo == null) return null;

      if (!context.mounted) return null;
      return await _stampWithLocation(context, File(photo.path));
    } catch (e) {
      if (kDebugMode) print("Camera error: $e");
      return null;
    }
  }

  // ===========================================================================
  // FILE / GALLERY
  // ===========================================================================
  static Future<File?> filePiker({required BuildContext context}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: _allowedExt,
      );
      if (result == null || result.paths.first == null) return null;

      final file = File(result.paths.first!);
      final ext = file.path.split('.').last.toLowerCase();

      if (!_allowedExt.contains(ext)) {
        _showError(context, "Only PNG, JPG, JPEG, DOC, PDF files are allowed.");
        return null;
      }

      // PDF / DOC par stamp nahi lagta
      if (!_imageExt.contains(ext)) return file;

      if (!context.mounted) return null;
      if (!await LocationHelper.ensureLocationReady(context)) {
        _showError(context, "Location is required to add a photo.");
        return null;
      }

      if (!context.mounted) return null;
      return await _stampWithLocation(context, file);
    } catch (e) {
      if (kDebugMode) print("File picker error: $e");
      return null;
    }
  }

  // ===========================================================================
  // LocationHelper se location + address lekar stamp lagao
  // ===========================================================================
  static Future<File?> _stampWithLocation(BuildContext context, File file) async {
    try {
      final location = await LocationHelper.getLocation(context: context);
      final position = LocationHelper.position;

      if (location == null || position == null) {
        _showError(context, "Unable to get location. Please try again.");
        return null;
      }

      // Fake GPS block
      if (position.isMocked) {
        _showError(context,
            "Fake location detected. Please turn off mock location apps.");
        return null;
      }

      return await ImageStampHelper.stamp(
        file: file,
        latitude: position.latitude,
        longitude: position.longitude,
        address: LocationHelper.currentAddress, // LocationHelper ne already nikala
      );
    } catch (e) {
      if (kDebugMode) print("Stamp error: $e");
      _showError(context, "Failed to process image. Please try again.");
      return null;
    }
  }

  static void _showError(BuildContext context, String message) {
    if (context.mounted) {
      SnackBarErrorWidget(context).show(message: message);
    }
  }
}