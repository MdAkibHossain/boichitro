import 'package:dhanshirisapp/screen/book_screen/about_book.dart';
import 'package:dhanshirisapp/screen/book_screen/book_review.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

class MagazineTabBar extends StatefulWidget {
  final bookdetails;
  late String aboutNote;
  MagazineTabBar({required this.aboutNote, required this.bookdetails});

  @override
  State<MagazineTabBar> createState() => _MagazineTabBarState();
}

class _MagazineTabBarState extends State<MagazineTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51.0.h,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //  SizedBox(height: 20.0),
            DefaultTabController(
                length: 2, // length of tabs
                initialIndex: 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 2.0.h),
                          child: Text(
                            LocaleKeys.aboutmagazine.tr(),
                            style: TextStyle(
                                fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: 44.0.h,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: Container(
                            child: AboutBook(
                          aboutNote: widget.aboutNote,
                        )),
                      )
                    ])),
          ]),
    );
  }
}
