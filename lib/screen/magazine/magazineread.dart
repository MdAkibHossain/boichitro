import 'dart:developer';
import 'package:dhanshirisapp/res/colors.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ReadMagazine extends StatefulWidget {
  final magazinePdf;
  ReadMagazine({required this.magazinePdf});

  @override
  State<ReadMagazine> createState() => _ReadMagazineState();
}

class _ReadMagazineState extends State<ReadMagazine> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorFactory.appPrimaryColor,
        elevation: 0,
        title: Text(LocaleKeys.magazine.tr()),
      ),
      body: const PDF().fromUrl(
        'https://boichitro.com.bd/media/magazines/1971_by_Humayum_Ahmed_LgK344Y.PDF',
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
