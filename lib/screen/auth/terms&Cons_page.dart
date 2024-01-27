import 'package:dhanshirisapp/screen/auth/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../res/colors.dart';

class TermsandCons extends StatefulWidget {
  const TermsandCons({required this.termsandconsUrl});
  final String termsandconsUrl;
  @override
  State<TermsandCons> createState() => _TermsandConsState();
}

class _TermsandConsState extends State<TermsandCons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          },
        ),
        backgroundColor: AppColorFactory.appPrimaryColor,
        elevation: 0,
        title: Text('Terms & Conditions'),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 3.0.h),
          child: Container(
            height: 80.0.h,
            width: double.maxFinite,
            child: WebView(
              initialUrl: widget.termsandconsUrl.toString(),

              // initialUrl:
              // 'https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/1210938040&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {},
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
              gestureNavigationEnabled: true,
            ),
          )
          // Container(
          //   child: WebView(
          //     initialUrl: widget.termsandconsUrl,
          //     javascriptMode: JavascriptMode.unrestricted,
          //     initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
          //     allowsInlineMediaPlayback: true,
          //     gestureRecognizers: Set()
          //       ..add(Factory<VerticalDragGestureRecognizer>(
          //           () => VerticalDragGestureRecognizer())),
          //   ),
          // ),
          ),
    );
  }
}
