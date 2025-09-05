import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  // Max size in bytes (512 KB)
  final int maxSize = 512 * 1024;

  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      final file = File(image.path);
      if (await file.length() > maxSize) {
        final compressed = await _compressImage(file);
        if (compressed != null) return XFile(compressed.path);
        return null; // Image too large and compression failed
      }

      return image;
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }

  Future<XFile?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return null;

      final file = File(image.path);
      if (await file.length() > maxSize) {
        final compressed = await _compressImage(file);
        if (compressed != null) return XFile(compressed.path);
        return null;
      }

      return image;
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }

  // Compress image to reduce size
  Future<XFile?> _compressImage(File file) async {
    final targetPath = file.path.replaceFirst('.jpg', '_compressed.jpg');
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,
    );

    if (result != null && await result.length() <= maxSize) {
      return result;
    } else {
      print("Compression failed or still too large");
      return null;
    }
  }
}
