import 'dart:developer';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReadMagazine extends StatefulWidget {
  final magazinePdf;
  ReadMagazine({required this.magazinePdf});

  @override
  State<ReadMagazine> createState() => _ReadMagazineState();
}

class _ReadMagazineState extends State<ReadMagazine> {
  bool _isLoading = true;
  late PDFDocument document;

  changePDF(value) async {
    log('ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
    setState(() => _isLoading = true);
    PDFDocument document = await PDFDocument.fromURL(
        'https://boichitro.com.bd/media/magazines/1971_by_Humayum_Ahmed_LgK344Y.PDF');
    // document = await PDFDocument.fromURL(
    //   "https://boichitro.com.bd/media/magazines/1971_by_Humayum_Ahmed_LgK344Y.PDF",);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : PDFViewer(
              document: document,
              zoomSteps: 1,
            ),
    ));
  }
}
