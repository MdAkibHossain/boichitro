import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhanshirisapp/screen/book_api_call.dart';
import 'package:dhanshirisapp/screen/ign/ign_api_call.dart';
import 'package:dhanshirisapp/screen/ign/ign_details.dart';
import 'package:dhanshirisapp/screen/ign/ign_player.dart';
import 'package:dhanshirisapp/screen/magazine/magazine_details.dart';
import 'package:dhanshirisapp/screen/magazine/magazineread.dart';
import 'package:dhanshirisapp/screen/user/user_profile_edit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/auth.dart';
import '../../provider/theme_provider.dart';
import '../../translations/locale_keys.g.dart';
import '../book_screen/book_details.dart';

class IGN_cart extends StatefulWidget {
  final igndetails;
  IGN_cart({@required this.igndetails});

  @override
  State<IGN_cart> createState() => _IGN_cartState();
}

class _IGN_cartState extends State<IGN_cart> {
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'http://abc.com',
        chooserTitle: 'Example Chooser Title');
  }

  build(BuildContext context) {
    Uint8List _bytesImage;
    // _bytesImage =
    //     Base64Decoder().convert(widget.bookdetails.cover_image.toString());
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        // _showModalBottomSheet(widget.bookdetails, _bytesImage, themeProvider);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IGNDetails(
                      recentlist: widget.igndetails,
                      bytesImage: widget.igndetails.cover_image.toString(),
                    )));
      },
      child: Container(
          margin: EdgeInsets.only(top: 1.0.h, bottom: 1.0.h, left: 2.30.w),
          height: 25.0.h,
          width: 36.0.w,
          decoration: BoxDecoration(
              color: themeProvider.isDarkMode
                  ? Colors.grey.shade900
                  : Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset.zero)
              ]),
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://res.cloudinary.com/boichitro/${widget.igndetails.cover_image.toString()}",
                  imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(05),
                              topRight: Radius.circular(05)),
                          image: DecorationImage(
                              image: imageProvider,
                              // MemoryImage(_bytesImage),
                              fit: BoxFit.fill))),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              // SizedBox(height: 0.5.h),
              Expanded(
                flex: 2,
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      left: 02.0.w,
                      right: 02.0.w,
                    ),
                    child: Text(widget.igndetails.bookname,
                        //overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 1.2.h,
                          // color: Colors.black
                        ))),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 6,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                left: 02.0.w,
                              ),
                              child: AutoSizeText(
                                widget.igndetails.author.toString(),
                                style: TextStyle(
                                    // color: Colors.black,
                                    ),
                                maxLines: 1,
                                minFontSize: 9,
                              ))),
                      Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Center(
                                    child: Icon(
                                      Icons.star_outline_outlined,
                                      color: Colors.orange,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                    margin: EdgeInsets.only(right: 1.0.w),
                                    child: Center(
                                        child: AutoSizeText(
                                            widget.igndetails.rating ?? ' ',
                                            style: TextStyle(
                                                //color: Colors.black

                                                )))),
                              )
                            ],
                          ))
                    ],
                  )),
              widget.igndetails.is_paid == true
                  ? Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onDoubleTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 2.0.w, bottom: 0.5.h, top: 0.4.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                    color: themeProvider.isDarkMode
                                        ? Colors.grey.shade900
                                        : Colors.white,
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color(0xffb8242a),
                                    )),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 0.5.h, left: .50.w, bottom: 0.5.h),
                                  child: Center(
                                      child: Text(
                                    LocaleKeys.subscription.tr(),
                                    style: TextStyle(fontSize: 1.0.h),
                                  )),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                //_showMyDialog(context);

                                //---------------- Subcription ---------------
                                if (authProvider.userInfodata!.email != '' &&
                                    (authProvider.userInfodata!.phone != '') &&
                                    authProvider.userInfodata!.full_name !=
                                        '' &&
                                    (authProvider.userInfodata!.gender ==
                                            "Male" ||
                                        authProvider.userInfodata!.gender ==
                                            "Female")) {
                                  print('i have a info');
                                  print(authProvider.userInfodata!.email);
                                  print(authProvider.userInfodata!.full_name);
                                  print(authProvider.userInfodata!.phone);

                                  // String hosturl =
                                  //     widget.magazinedetails.magazine_file;
                                  // String newurl = hosturl.replaceAll(
                                  //     'http://127.0.0.1:8000/',
                                  //     'https://boichitro.com.bd/');

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => IGNApiCall(
                                              book_id: widget.igndetails.pk)));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserProfileEdit(
                                                profiledata: authProvider,
                                                checkdata: 1,
                                                bookid: widget.igndetails.pk,
                                                bookname: widget
                                                    .igndetails.bookname
                                                    .toString(),
                                              )));
                                }
                                //  _createPlayer();
                                // WidgetsBinding.instance!.addPostFrameCallback((_) {
                                //   _showMyDialog(_);
                                // });
                                // var sheetController = _scaffoldKey.currentState
                                //     ?.showBottomSheet(
                                //         (context) => _showMyDialog(context));
                                // print(sheetController);
                                // sheetController?.closed.then((value) {
                                //   print("Bottom Sheet Closed");
                                //   // print(value);
                                //   // if (value == 1) {
                                //   setState(() {
                                //     print('i am working');
                                //   });
                                //   // }
                                // });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 0.5.h, top: 0.4.h, right: 1.0.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(2),
                                          bottomRight: Radius.circular(2)),
                                      color: Color(0xffb8242a),
                                      border: Border.all(
                                        width: 1.5,
                                        color: Color(0xffb8242a),
                                      )),
                                  child: Center(
                                    child: AutoSizeText(LocaleKeys.readnow.tr(),
                                        //readnow,
                                        minFontSize: 3,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal)),
                                  )),
                            ),
                          )
                        ],
                      ))
                  :
                  //------------------------ispain = false
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                //_showMyDialog(context);

                                //---------------- Subcription ---------------
                                if (authProvider.userInfodata!.email != '' &&
                                    (authProvider.userInfodata!.phone != '') &&
                                    authProvider.userInfodata!.full_name !=
                                        '' &&
                                    (authProvider.userInfodata!.gender ==
                                            "Male" ||
                                        authProvider.userInfodata!.gender ==
                                            "Female")) {
                                  // String hosturl =
                                  //     widget.magazinedetails.magazine_file;
                                  // String newurl = hosturl.replaceAll(
                                  //     'http://127.0.0.1:8000/',
                                  //     'https://boichitro.com.bd/');

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => IGNApiCall(
                                                book_id: widget.igndetails.pk,
                                              )));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserProfileEdit(
                                                profiledata: authProvider,
                                                checkdata: 1,
                                                bookid: widget.igndetails.pk,
                                                bookname: widget
                                                    .igndetails.bookname
                                                    .toString(),
                                              )));
                                }
                              },
                              child: Container(
                                  margin: EdgeInsets.only(
                                    top: 0.2.h,
                                    //bottom: .6.h,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5)),
                                      color: Color(0xffb8242a),
                                      border: Border.all(
                                        width: 1.5,
                                        color: Color(0xffb8242a),
                                      )),
                                  child: Center(
                                    child: AutoSizeText(LocaleKeys.readnow.tr(),
                                        //readnow,
                                        minFontSize: 3,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal)),
                                  )),
                            ),
                          )
                        ],
                      ))
            ],
          )),
    );
  }
}
