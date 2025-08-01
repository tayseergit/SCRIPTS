import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImageFromGallery(BuildContext context) async {
    // Request permission
    final status = await Permission.photos.request();

    if (status.isGranted) {
      // Pick image
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return null;

      // Compress the picked image
      XFile? compressedFile = await _compressImage(File(pickedFile.path));

      if (compressedFile == null) {
        // Compression failed, fallback to original
        return XFile(pickedFile.path);
      }
      return compressedFile;
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gallery permission denied')),
      );
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Optional: open app settings if permanently denied
    }

    return null;
  }

  Future<XFile?> _compressImage(File file) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final targetPath = path.join(tempDir.path, 'compressed_${path.basename(file.path)}');

      var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 10, // Adjust quality between 0 and 100 as needed
      );

      return result;
    } catch (e) {
      print('Image compression error: $e');
      return null;
    }
  }
}
