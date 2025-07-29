import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // تحميل ملف .env
  await dotenv.load(fileName: '.env');

  final ip = dotenv.env['API_IP'];

  if (ip == null || ip.isEmpty) {
    print('❌ IP not found in .env');
    return;
  }

  final selectedIp = 'http://$ip';

  print('✅ Loaded IP from .env: $selectedIp');

  // ---------------  path of the dio file (class) ----------------
  final dioFile = File('lib/Helper/dio_helper.dart');

  if (!dioFile.existsSync()) {
    print('❌ dio_helper.dart not found!');
    return;
  }

  String content = await dioFile.readAsString();

  // استبدال أي IP قديم بـ الجديد
  final updatedContent = content.replaceAllMapped(
    RegExp(r'http://192\.168\.\d{1,3}\.\d{1,3}'),
    (match) => selectedIp,
  );

  await dioFile.writeAsString(updatedContent);
  print('✅ Replaced IP in dio_helper.dart → $selectedIp');
}
