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
          child: WebView(
            initialUrl: widget.termsandconsUrl,
            javascriptMode: JavascriptMode.unrestricted,
            initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
            allowsInlineMediaPlayback: true,
            gestureRecognizers: Set()
              ..add(Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer())),
          ),
        ),
      ),
    );
  }
}
