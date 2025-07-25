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
import '../../provider/book_read.dart';
import '../../provider/order.dart';

class ReadPdf extends StatefulWidget {
  String? book_details;

  ReadPdf({
    required this.book_details,
  });

  @override
  State<ReadPdf> createState() => _ReadPdfState();
}

class _ReadPdfState extends State<ReadPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColorFactory.appPrimaryColor,
      //   elevation: 0,
      //   title: Text(
      //       // widget.magazinePdf
      //       LocaleKeys.pdf_book.tr()),
      // ),
      appBar: CommonAppBar(
        height: 6.5.h,
        title: LocaleKeys.pdf_book.tr(),
      ),
      body: const PDF().fromUrl(
        'https://boichitro.com.bd/' + widget.book_details.toString(),
        // widget.bookpagemodel.BookPage.toString()
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
