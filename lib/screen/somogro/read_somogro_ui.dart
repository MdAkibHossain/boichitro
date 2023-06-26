import 'package:dhanshirisapp/model/shomogro_books_read.dart';
import 'package:dhanshirisapp/provider/book_read.dart';
import 'package:dhanshirisapp/screen/somogro/somogroTest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class ReadSUI extends StatefulWidget {
  List<SomogroBooksRead>? somogroMap;
  int bookcount;

  ReadSUI({required this.somogroMap, required this.bookcount});

  @override
  State<ReadSUI> createState() => _ReadSUIState();
}

class _ReadSUIState extends State<ReadSUI> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.bookcount,
        itemBuilder: (context, index) {
          final somogrodetails = widget.somogroMap![index];
          return SSS(somogrodetails.part_name, somogrodetails.content);
        });
  }
}
