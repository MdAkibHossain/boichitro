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

import '../../screen/about page/aboutpage.dart';
import '../../screen/setting/setting.dart';

class SomogroDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
