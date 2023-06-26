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

import '../../screen/about page/aboutpage.dart';
import '../../screen/setting/setting.dart';

class SomogroDrawer extends StatelessWidget {

  
  List<SomogroBooksRead>? booknames;
  SomogroDrawer(this.booknames);
  
  void addOrUpdateNote() async {
    // final isValid = _formKey.currentState!.validate();
    // notes = await NotesDatabase.instance.readAllNotes();
    // print('-----notes-----');
    // for (int i = 0; i < notes.length; i++) {
    //   if (notes[i].book_id == widget.book_id!) {
    //     notedata = notes[i];
    //   } else {
    //     notedata = null;
    //   }
    //   print(notes[i].book_id);
    }






  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return new Drawer(
      backgroundColor: Color(0xffd3b6b6),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 8.0.h,
            ),

            Container(
              height: 75.0.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 3.0.h,
                  ),
                  DrawerListBox(
                    // title: "My Profile",
                    title: LocaleKeys.myprofile.tr(),
                    image: 'assets/profile.png',
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfileInfo.routeName);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ProfileInfo()));
                    },
                  ),
                  LineBox(),
                  DrawerListBox(
                    //   title: "Help",
                    title: LocaleKeys.about.tr(),
                    image: 'assets/about.png',
                    onTap: () {
                      Navigator.of(context).pushNamed(AboutPage.routeName);
                      // Navigator.pushNamed(context,
                      //     MaterialPageRoute(builder: (context) => AboutPage.routeName));
                    },
                  ),
                  LineBox(),
                ],
              ),
            ),

            //  Expanded(flex: 7, child: Container()),
          ],
        ),
      ),
    );
  }
}
