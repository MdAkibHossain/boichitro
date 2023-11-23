import 'package:audioplayers/audioplayers.dart';
import 'package:dhanshirisapp/model/shomogro_books_read.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/screen/History/history_page.dart';
import 'package:dhanshirisapp/screen/about_app.dart';
import 'package:dhanshirisapp/screen/audio/soundcloud_player.dart';
import 'package:dhanshirisapp/screen/book_request/book_requested_screen.dart';
import 'package:dhanshirisapp/screen/music_player/music_player.dart';
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
import 'package:webview_flutter/webview_flutter.dart';

import '../../model/audio_listener_split.dart';
import '../../screen/about page/aboutpage.dart';
import '../../screen/setting/setting.dart';

class AudioListener extends StatefulWidget {
  List<AudioBooksRead>? bookdetails;
  int bookcount;
  AudioListener(this.bookdetails, this.bookcount);

  @override
  State<AudioListener> createState() => _AudioListenerState();
}

class _AudioListenerState extends State<AudioListener> {
// bookdetails![1].part_name.toString()

  // Your book content goes here

  int booknumber = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final String? audiofile = widget.bookdetails![booknumber].file;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xffc60e13),
        title: Text(
          'Audio Player',
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       Container(
      //         height: 12.h,
      //         child: DrawerHeader(
      //           child: Text(
      //             'Audios',
      //             style:
      //                 TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
      //           ),
      //           decoration: BoxDecoration(
      //             color: Color(0xffc60e13),
      //           ),
      //         ),
      //       ),
      //       Container(
      //         height: double.maxFinite,
      //         child: ListView.builder(
      //             itemCount: widget.bookcount,
      //             itemBuilder: (context, index) {
      //               final booknames = widget.bookdetails![index].part;
      //               return ListTile(
      //                 title: Text('Audio Part: ' + booknames.toString()),
      //                 onTap: () {
      //                   setState(() {
      //                     if (_scaffoldKey.currentState!.isDrawerOpen) {
      //                       _scaffoldKey.currentState!.openEndDrawer();
      //                     } else {
      //                       _scaffoldKey.currentState!.openDrawer();
      //                     }
      //                     booknumber = index;
      //                   });
      //                 },
      //               );
      //             }),
      //       ),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 100.h,
              child: ListView.builder(
                  itemCount: widget.bookcount,
                  itemBuilder: (context, index) {
                    final booknames = widget.bookdetails![index].part;
                    return Padding(
                      padding: EdgeInsets.all(1.0.h),
                      child: Container(
                        height: 20.h,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.0.w,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 1.0.h),
                                child: Text(
                                    'Audio Part: ' + (index + 1).toString()),
                              ),
                            ),
                            // MusicPlayer(
                            //     widget.bookdetails![index].file.toString(),

                            //     ),
                            SoundCloudPlayer(),
                            // Container(
                            //   height: 40.0.h,
                            //   width: double.maxFinite,
                            //   child: WebView(
                            //     initialUrl:
                            //         widget.bookdetails![index].url.toString(),

                            //     // initialUrl:
                            //     //     'https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/1216818949%3Fsecret_token%3Ds-UuOzIxSiZiw&color=%23ff5500&auto_play=true&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true',
                            //     javascriptMode: JavascriptMode.unrestricted,
                            //     onWebViewCreated:
                            //         (WebViewController webViewController) {},
                            //     onPageStarted: (String url) {
                            //       print('Page started loading: $url');
                            //     },
                            //     onPageFinished: (String url) {
                            //       print('Page finished loading: $url');
                            //     },
                            //     gestureNavigationEnabled: true,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
