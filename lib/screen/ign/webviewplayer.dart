import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../res/colors.dart';

class WebViewVideo extends StatefulWidget {
  const WebViewVideo({required this.videoUrl});
  final String videoUrl;
  @override
  State<WebViewVideo> createState() => _WebViewVideoState();
}

class _WebViewVideoState extends State<WebViewVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColorFactory.appPrimaryColor,
        elevation: 0,
        title: Text('Watch IGN'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 3.0.h),
        child: Container(
          child: WebView(
            initialUrl: widget.videoUrl,
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
