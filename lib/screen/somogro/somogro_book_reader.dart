import 'package:dhanshirisapp/model/shomogro_books_read.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/screen/History/history_page.dart';
import 'package:dhanshirisapp/screen/about_app.dart';
import 'package:dhanshirisapp/screen/book_request/book_requested_screen.dart';
import 'package:dhanshirisapp/screen/wishlist/my_wishlist.dart';
import 'package:dhanshirisapp/screen/auth/login_screen.dart';
import 'package:dhanshirisapp/screen/setting.dart';
import 'package:dhanshirisapp/screen/user/user_profile.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/drower_customer/drawer_list_box.dart';
import 'package:dhanshirisapp/widget/drower_customer/line_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../common/common_app_bar.dart';
import '../../screen/about page/aboutpage.dart';
import '../../screen/setting/setting.dart';

class SomogroReadBook extends StatefulWidget {
  List<SomogroBooksRead>? bookdetails;
  int bookcount;
  SomogroReadBook(this.bookdetails, this.bookcount);

  @override
  State<SomogroReadBook> createState() => _SomogroReadBookState();
}

class _SomogroReadBookState extends State<SomogroReadBook> {
// bookdetails![1].part_name.toString()

  // Your book content goes here
  final PageController _pageController = PageController();

  int _currentPage = 0;
  int booknumber = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final List<String> pages = _splitContentIntoPages(widget
        .bookdetails![booknumber].content
        .toString()
        .replaceAll("\n", ""));

    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(
        height: 6.5.h,
        title: '${widget.bookdetails![booknumber].part_name.toString()}',
        isHomeActive: true,
      ),
      // appBar: AppBar(
      //   backgroundColor: Color(0xffc60e13),
      //   title: Text(
      //     widget.bookdetails![booknumber].part_name.toString(),
      //     style: TextStyle(fontSize: 14.sp),
      //   ),
      // ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 12.h,
              child: DrawerHeader(
                child: Text(
                  'Books Name',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffc60e13),
                ),
              ),
            ),
            Container(
              height: double.maxFinite,
              child: ListView.builder(
                  itemCount: widget.bookcount,
                  itemBuilder: (context, index) {
                    final booknames = widget.bookdetails![index].part_name;
                    return ListTile(
                      title: Text(booknames.toString()),
                      onTap: () {
                        setState(() {
                          if (_scaffoldKey.currentState!.isDrawerOpen) {
                            _scaffoldKey.currentState!.openEndDrawer();
                          } else {
                            _scaffoldKey.currentState!.openDrawer();
                          }
                          booknumber = index;
                        });
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    pages[index],
                    style: TextStyle(fontSize: 16.0),
                  ),
                );
              },
            ),
          ),
          Text(
            'Page ${_currentPage + 1} of ${pages.length}',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  List<String> _splitContentIntoPages(String content) {
    const int maxCharsPerPage =
        1150; // Adjust this value to change the page size

    List<String> pages = [];
    String currentPage = '';

    final List<String> words = content.split(' ');

    for (int i = 0; i < words.length; i++) {
      if ((currentPage + ' ' + words[i]).length <= maxCharsPerPage) {
        currentPage += ' ' + words[i];
      } else {
        pages.add(currentPage.trim());
        currentPage = words[i];
      }
    }

    if (currentPage.isNotEmpty) {
      pages.add(currentPage.trim());
    }

    return pages;
  }
}
