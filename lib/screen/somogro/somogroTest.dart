import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class SSS extends StatefulWidget {
  String? bookname;
  String? book;
  SSS(@required this.bookname, @required this.book);

  @override
  State<SSS> createState() => _SSSState();
}

class _SSSState extends State<SSS> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0.h,
      width: 50.0.w,
      color: Colors.amberAccent,
      child: Center(
        child: Column(
          children: [
            Text(widget.bookname.toString()),
            Text(widget.book.toString()),
          ],
        ),
      ),
    );
  }
}
