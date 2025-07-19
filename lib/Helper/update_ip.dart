import 'dart:io';

void main() async {
  final result = await Process.run('ipconfig', []);

  if (result.exitCode != 0) {
    print('❌ Failed to run ipconfig: ${result.stderr}');
    return;
  }

  final ipRegex = RegExp(r'IPv4 Address[.\s]*:\s*(\d{1,3}(?:\.\d{1,3}){3})');
  final matches = ipRegex.allMatches(result.stdout.toString());

  String? selectedIp;

  for (var match in matches) {
    final ip = match.group(1);
    if (ip != null && ip.startsWith('192.168.')) {
      selectedIp = ip;
      break;
    }
  }

  if (selectedIp == null) {
    print('⚠️ No local IP (192.168.x.x) found.');
    return;
  }

  print('✅ Found IP: $selectedIp');
//// ---------------  path of the dio file (class) ----------------
  final dioFile = File('lib/Helper/dio_helper.dart');  

  if (!dioFile.existsSync()) {
    print('❌ dio_helper.dart not found!');
    return;
  }

  String content = await dioFile.readAsString();

  final updatedContent = content.replaceAllMapped(
    RegExp(r'http://192\.168\.\d{1,3}\.\d{1,3}'),
    (match) => 'http://$selectedIp',
  );

  await dioFile.writeAsString(updatedContent);
  print('✅ Replaced IP in dio_helper.dart → http://$selectedIp');
}
