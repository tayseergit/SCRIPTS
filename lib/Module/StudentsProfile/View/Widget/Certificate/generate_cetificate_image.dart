import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/StudentsProfile/Model/CertificatesModel.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// Load template image
Future<ui.Image> loadImage(String path) async {
  final ByteData data = await rootBundle.load(path);
  final Uint8List bytes = data.buffer.asUint8List();
  final ui.Codec codec = await ui.instantiateImageCodec(bytes);
  final ui.FrameInfo fi = await codec.getNextFrame();
  return fi.image;
}

/// Generate the certificate as an in-memory image
Future<Uint8List> generateCertificateImage({
  required String title,
  required String date,
  required String studentName,
}) async {
  final ui.Image template = await loadImage(Images.certificate_templet);

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint();

  // Draw the template
  canvas.drawImage(template, Offset.zero, paint);
//// draw name

  final namePainter = TextPainter(
    text: TextSpan(
      text: studentName,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    ),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );
  namePainter.layout(maxWidth: template.width.toDouble());
  namePainter.paint(
    canvas,
    Offset((template.width - namePainter.width) / 2,
        template.height * 0.46), // adjust Y
  );
  // Draw title text
  final titlePainter = TextPainter(
    text: TextSpan(
      text: title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
    ),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );
  titlePainter.layout(maxWidth: template.width.toDouble());
  titlePainter.paint(
    canvas,
    Offset((template.width - titlePainter.width) / 2,
        template.height * 0.61), // adjust Y
  );

  // Draw date text
  final datePainter = TextPainter(
    text: TextSpan(
      text: date,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    ),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );
  datePainter.layout(maxWidth: template.width.toDouble());
  datePainter.paint(
    canvas,
    Offset((template.width - datePainter.width) / 2,
        template.height * 0.8), // adjust Y
  );

  final picture = recorder.endRecording();
  final img = await picture.toImage(template.width, template.height);
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}

/// Show dialog with the certificate preview
void showCertificateDialog(
  BuildContext context,
  String title,
  String obtainDate,
  String studentName,
) async {
  final Uint8List imageBytes = await generateCertificateImage(
      title: title, date: obtainDate, studentName: studentName);
  Future<void> saveImageToGallery(Uint8List imageBytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = await File(
      '${tempDir.path}/certificate_${DateTime.now().millisecondsSinceEpoch}.png',
    ).writeAsBytes(imageBytes);

    await GallerySaver.saveImage(file.path);
  }

  Future<bool> requestGalleryPermission() async {
    var status = await Permission.photos
        .request(); // Use Permission.storage for Android pre-13
    if (status.isGranted) {
      return status.isGranted;
    } else if (status.isDenied) {
      return status.isDenied;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return status.isGranted;
  }

  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InteractiveViewer(
            minScale: 0.8,
            maxScale: 2.0,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.memory(imageBytes, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () async {
                  if (!await requestGalleryPermission()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Permission denied')),
                    );
                    return;
                  }
                  await saveImageToGallery(imageBytes);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saved to gallery')),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text('Save'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
