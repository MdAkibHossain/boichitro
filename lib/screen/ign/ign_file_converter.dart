import 'package:dhanshirisapp/screen/ign/ign_player.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class IGN_File_Converter extends StatelessWidget {
  const IGN_File_Converter({required this.fileUrl});
  final String fileUrl;
  @override
  Widget build(BuildContext context) {
    String ign_url = fileUrl.replaceAll(
        'http://127.0.0.1:8000/', 'https://boichitro.com.bd/');
    return IgnPlayer(videoUrl: ign_url);
  }
}
