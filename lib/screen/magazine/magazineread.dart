import 'dart:developer';
import 'package:dhanshirisapp/res/colors.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:sizer/sizer.dart';

import '../../common/common_app_bar.dart';

class ReadMagazine extends StatefulWidget {
  final magazinePdf;
  ReadMagazine({required this.magazinePdf});
  @override
  State<ReadMagazine> createState() => _ReadMagazineState();
}

class _ReadMagazineState extends State<ReadMagazine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        height: 6.5.h,
        title: LocaleKeys.magazine.tr(),
      ),
      // appBar: AppBar(
      //   backgroundColor: AppColorFactory.appPrimaryColor,
      //   elevation: 0,
      //   title: Text(
      //       // widget.magazinePdf
      //       LocaleKeys.magazine.tr()),
      // ),
      body: const PDF().fromUrl(
        widget.magazinePdf,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
