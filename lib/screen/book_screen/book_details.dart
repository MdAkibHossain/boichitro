import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/provider/auth.dart';
import 'package:dhanshirisapp/provider/deshboard.dart';
import 'package:dhanshirisapp/provider/favourit_list.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/screen/book_api_call.dart';
import 'package:dhanshirisapp/screen/book_screen/landscope/modal_tab_bar.dart';
import 'package:dhanshirisapp/screen/magazine/magazineread.dart';
import 'package:dhanshirisapp/screen/user/user_profile_edit.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dhanshirisapp/screen/book_screen/modal_tab_bar.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/popup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../common/common_app_bar.dart';
import '../../res/colors.dart';

class BookDetails extends StatefulWidget {
  final recentlist;
  final bytesImage;

  BookDetails(
    this.recentlist,
    this.bytesImage,
  );

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Boichitro App',
        text: widget.recentlist.bookname.toString(),
        linkUrl: widget.recentlist.book_image_url,
        chooserTitle: 'Boichitro App');
  }

  @override
  Widget build(BuildContext context) {
    Uint8List _bytesImage;
    // _bytesImage =
    //     Base64Decoder().convert(widget.recentlist.cover_image.toString());
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColorFactory.appPrimaryColor,
      // appBar: AppBar(
      //   backgroundColor: AppColorFactory.appPrimaryColor,
      //   elevation: 0,
      //   title: Text(LocaleKeys.book_details.tr()),
      // ),
      appBar: CommonAppBar(
        height: 6.5.h,
        title: LocaleKeys.book_details.tr(),
      ),
      body: Container(
        child: OrientationBuilder(builder: (context, orientation) {
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            print('i am protrait');
            return buildProtraits(themeProvider, authProvider);
          } else {
            print('i am landscape');
            return buildLandscapes(themeProvider, authProvider);
          }
        }),
      ),
    );
  }

  Widget buildProtraits(themeProvider, authProvider) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffD3B6B6),
                Color(0xffFFFFFF),
              ],
            ),
            //themeProvider.isDarkMode ? Colors.white : Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        //  height: 90.0.h,
        child: Container(
          height: 88.5.h,
          width: 100.0.w,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color:
                themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 5.0,
              ),
            ],
          ),
          // height: 60.0.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 33.0.h,
                  width: 100.0.w,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (authProvider.userInfodata!.email != '' &&
                                  authProvider.userInfodata!.phone != '' &&
                                  authProvider.userInfodata!.full_name != '') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookApiCall(
                                              book_id: widget.recentlist.pk,
                                              book_name: widget
                                                  .recentlist.bookname
                                                  .toString(),
                                              is_pdf: widget.recentlist.is_pdf,
                                            )));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserProfileEdit(
                                              profiledata: authProvider,
                                              checkdata: 1,
                                              bookid: widget.recentlist.pk,
                                              bookname: widget
                                                  .recentlist.bookname
                                                  .toString(),
                                            )));
                              }
                            },
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://res.cloudinary.com/boichitro/${widget.recentlist.cover_image.toString()}",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 18.0.h,
                                margin: EdgeInsets.only(
                                  top: 2.5.h,
                                  left: 5.0.w,
                                  right: 3.0.w,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        //MemoryImage(_bytesImage),
                                        fit: BoxFit.fill),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 2,
                                          spreadRadius: 3,
                                          color: Colors.black12,
                                          offset: Offset.zero)
                                    ]),
                                width: 30.0.w,
                              ),
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          // if subcription is available then it show
                          widget.recentlist.is_paid == true
                              ? Container(
                                  height: 3.5.h,
                                  width: 34.0.w,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: GestureDetector(
                                          onDoubleTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 2.0.w,
                                                bottom: 0.5.h,
                                                top: 0.4.h),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5)),
                                                color: themeProvider.isDarkMode
                                                    ? Colors.grey.shade900
                                                    : Colors.white,
                                                border: Border.all(
                                                  width: 1.5,
                                                  color: Color(0xffb8242a),
                                                )),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: 0.5.h,
                                                  left: .50.w,
                                                  bottom: 0.5.h),
                                              child: Center(
                                                  child: Text(
                                                'Subcription',
                                                style:
                                                    TextStyle(fontSize: 1.0.h),
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

                                            log("Testeddddddddddddddddddddddddddddddddd");

                                            //---------------- Subcription ---------------
                                            if (authProvider.userInfodata!.email != '' &&
                                                authProvider
                                                        .userInfodata!.phone !=
                                                    '' &&
                                                authProvider.userInfodata!
                                                        .full_name !=
                                                    '') {
                                              if (widget.recentlist.book_type ==
                                                  'ebook') {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookApiCall(
                                                              book_id: widget
                                                                  .recentlist
                                                                  .pk,
                                                              book_name: widget
                                                                  .recentlist
                                                                  .bookname
                                                                  .toString(),
                                                              is_pdf: widget
                                                                  .recentlist
                                                                  .is_pdf,
                                                            )));
                                              } else {
                                                // ReadPdf(magazinePdf: widget.recentlist,);
                                              }
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserProfileEdit(
                                                            profiledata:
                                                                authProvider,
                                                            checkdata: 1,
                                                            bookid: widget
                                                                .recentlist.pk,
                                                            bookname: widget
                                                                .recentlist
                                                                .bookname
                                                                .toString(),
                                                          )));
                                            }
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 0.5.h,
                                                  top: 0.4.h,
                                                  right: 1.0.w),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight: Radius
                                                              .circular(2),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  2)),
                                                  color: Color(0xffb8242a),
                                                  border: Border.all(
                                                    width: 1.5,
                                                    color: Color(0xffb8242a),
                                                  )),
                                              child: Center(
                                                child: AutoSizeText(
                                                    LocaleKeys.readnow.tr(),
                                                    //readnow,
                                                    minFontSize: 3,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              )),
                                        ),
                                      )
                                    ],
                                  ))
                              : Container(),

                          // is there have na subcription
                          widget.recentlist.is_paid == false
                              ? Container(
                                  height: 3.5.h,
                                  width: 34.0.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      //_showMyDialog(context);

                                      //---------------- Subcription ---------------
                                      if (authProvider.userInfodata!.email != '' &&
                                          authProvider.userInfodata!.phone !=
                                              '' &&
                                          authProvider
                                                  .userInfodata!.full_name !=
                                              '') {
                                        if (widget.recentlist.book_type ==
                                            'ebook') {
                                          log("Its wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookApiCall(
                                                        book_id: widget
                                                            .recentlist.pk,
                                                        book_name: widget
                                                            .recentlist.bookname
                                                            .toString(),
                                                        is_pdf: widget
                                                            .recentlist.is_pdf,
                                                      )));
                                        } else {
                                          String hosturl = widget.recentlist;
                                          String newurl =
                                              'https://boichitro.com.bd' +
                                                  hosturl;
                                          log(newurl);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReadMagazine(
                                                          magazinePdf:
                                                              newurl)));
                                        }
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserProfileEdit(
                                                      profiledata: authProvider,
                                                      checkdata: 1,
                                                      bookid:
                                                          widget.recentlist.pk,
                                                      bookname: widget
                                                          .recentlist.bookname
                                                          .toString(),
                                                    )));
                                      }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: 3.0.w,
                                            bottom: 0.5.h,
                                            // top: 0.4.h,
                                            right: 1.0.w),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(5),
                                                bottomRight:
                                                    Radius.circular(5)),
                                            color: Color(0xffb8242a),
                                            border: Border.all(
                                              width: 1.5,
                                              color: Color(0xffb8242a),
                                            )),
                                        child: Center(
                                          child: AutoSizeText(
                                              LocaleKeys.readnow.tr(),
                                              //readnow,
                                              minFontSize: 3,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        )),
                                  ))
                              : Container(),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(top: 2.0.h, left: 5.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  bottom: 0.50.w,
                                ),
                                // height: 2.5.h,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      //  height: 3.2.h,
                                      width: 40.0.w,
                                      child: Text(
                                        widget.recentlist.bookname.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 1.8.h),
                                      ),
                                    ),
                                    Consumer<FavouriteProviderModel>(
                                      builder: (context, model, child) {
                                        return Container(
                                          height: 2.50.h,
                                          width: 8.0.w,
                                          child: Align(
                                            child: Center(
                                              child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: Icon(
                                                    model.cartBooks.contains(
                                                            widget.recentlist
                                                                .bookname)
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_border_outlined,
                                                    size: 2.5.h,
                                                  ),
                                                  onPressed: () async {
                                                    Map<String, dynamic>?
                                                        authdata = await model
                                                            .toggleProductFavoriteStatus(
                                                                id: widget
                                                                    .recentlist
                                                                    .pk);
                                                    print('i am working');
                                                    model.fatchfavouriteList();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            duration: Duration(
                                                                seconds: 2),
                                                            backgroundColor:
                                                                Color(
                                                                    0xffc60e13),
                                                            content: Text(
                                                                authdata![
                                                                    'message'],
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        1.8.h,
                                                                    color: Colors
                                                                        .white))));

                                                    print(authdata);
                                                  }),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.0.h,
                              ),
                              // PopUpScreen(
                              //   //   name: "Name",
                              //   name: LocaleKeys.name.tr(),
                              //   title: recentlist.bookname.toString(),
                              // ),

                              PopUpScreen(
                                // name: "Writer Name",
                                name: LocaleKeys.writername.tr(),
                                title: widget.recentlist.author.toString(),
                              ),
                              PopUpScreen(
                                //name: "Publications",
                                name: LocaleKeys.publicaions.tr(),
                                title: widget.recentlist.publisher.toString(),
                              ),
                              PopUpScreen(
                                //  name: "Version",
                                name: LocaleKeys.version.tr(),
                                title: widget.recentlist.edition.toString(),
                              ),
                              PopUpScreen(
                                name: "ISBN",
                                title: widget.recentlist.isbn.toString(),
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 3.1.h,
                                      width: 25.0.w,
                                      child: Text(
                                        LocaleKeys.rating.tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 1.5.h),
                                      ),
                                    ),
                                    Container(
                                        height: 2.5.h,
                                        width: 30.0.w,
                                        margin: EdgeInsets.only(bottom: 1.4.h),
                                        child: RatingBarIndicator(
                                            rating: double.parse(widget
                                                .recentlist.rating
                                                .toString()),
                                            itemBuilder: (context, index) =>
                                                Icon(
                                                  Icons.star,
                                                  // color: Colors.amber,
                                                ),
                                            itemCount: 5,
                                            itemSize: 17.0,
                                            direction: Axis.horizontal)),
                                  ]),

                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 3.1.h,
                                      width: 25.0.w,
                                      child: Text(
                                        LocaleKeys.share.tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 1.5.h),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await share();
                                      },
                                      child: Container(
                                          height: 4.5.h,
                                          width: 30.0.w,
                                          //  margin: EdgeInsets.only(top: .50.h),
                                          child: Center(
                                            child: Icon(
                                              Icons.share,
                                              color: Colors.red,
                                              size: 25,
                                            ),
                                          )),
                                    ),
                                  ])
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ModalTabBar(
                  aboutNote: widget.recentlist.cover_note.toString(),
                  bookdetails: widget.recentlist,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 00.00.h),
                  child: Container(
                    // height: 15.0.h,
                    width: 100.0.w,
                    child: Image(
                      image: AssetImage(
                        'assets/sriti_shoudho2.png',
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Padding(
        //   padding: EdgeInsets.only(top: 0.00.h),
        //   child: Container(
        //     height: 13.0.h,
        //     width: 100.0.w,
        //     child: Image(
        //       image: AssetImage(
        //         'assets/sriti_shoudho2.png',
        //       ),
        //       fit: BoxFit.fitWidth,
        //     ),
        //   ),
        // ),
      ),
    );
  }

  //------------------------Landscape --------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------
  //------------------------Landscape --------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------
  Widget buildLandscapes(themeProvider, authProvider) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 5.0,
            ),
          ],
        ),
        // height: 60.0.h,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30.0.h,
                child: Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (authProvider.userInfodata!.email != '' &&
                                authProvider.userInfodata!.phone != '' &&
                                authProvider.userInfodata!.full_name != '') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookApiCall(
                                            book_id: widget.recentlist.pk,
                                            book_name: widget
                                                .recentlist.bookname
                                                .toString(),
                                            is_pdf: widget.recentlist.is_pdf,
                                          )));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserProfileEdit(
                                            profiledata: authProvider,
                                            checkdata: 1,
                                            bookid: widget.recentlist.pk,
                                            bookname: widget.recentlist.bookname
                                                .toString(),
                                          )));
                            }
                          },
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://res.cloudinary.com/boichitro/${widget.recentlist.cover_image.toString()}",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 22.0.h,
                              width: 40.0.w,
                              margin: EdgeInsets.only(
                                top: 2.5.h,
                                left: 5.0.w,
                                right: 3.0.w,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      //MemoryImage(_bytesImage),
                                      fit: BoxFit.fill),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 3,
                                        color: Colors.black12,
                                        offset: Offset.zero)
                                  ]),
                            ),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),

                        widget.recentlist.is_paid == true
                            ? Container(
                                height: 3.5.h,
                                width: 45.0.w,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: GestureDetector(
                                        onDoubleTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            left: 2.0.w,
                                            bottom: 0.5.h,
                                            //   top: 0.4.h
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5)),
                                              color: themeProvider.isDarkMode
                                                  ? Colors.grey.shade900
                                                  : Colors.white,
                                              border: Border.all(
                                                width: 1.5,
                                                color: Color(0xffb8242a),
                                              )),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 0.5.h,
                                                left: .50.w,
                                                bottom: 0.5.h),
                                            child: Center(
                                                child: Text(
                                              'Subcription',
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
                                              authProvider
                                                      .userInfodata!.phone !=
                                                  '' &&
                                              authProvider.userInfodata!
                                                      .full_name !=
                                                  '') {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookApiCall(
                                                          book_id: widget
                                                              .recentlist.pk,
                                                          book_name: widget
                                                              .recentlist
                                                              .bookname
                                                              .toString(),
                                                          is_pdf: widget
                                                              .recentlist
                                                              .is_pdf,
                                                        )));
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserProfileEdit(
                                                          profiledata:
                                                              authProvider,
                                                          checkdata: 1,
                                                          bookid: widget
                                                              .recentlist.pk,
                                                          bookname: widget
                                                              .recentlist
                                                              .bookname
                                                              .toString(),
                                                        )));
                                          }
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: 0.5.h,
                                                top: 0.4.h,
                                                right: 1.0.w),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(2),
                                                    bottomRight:
                                                        Radius.circular(2)),
                                                color: Color(0xffb8242a),
                                                border: Border.all(
                                                  width: 1.5,
                                                  color: Color(0xffb8242a),
                                                )),
                                            child: Center(
                                              child: AutoSizeText(
                                                  LocaleKeys.readnow.tr(),
                                                  //readnow,
                                                  minFontSize: 3,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            )),
                                      ),
                                    )
                                  ],
                                ))
                            : Container(),
                        // is there have no subcription
                        widget.recentlist.is_paid == false
                            ? Container(
                                height: 3.5.h,
                                width: 45.0.w,
                                margin: EdgeInsets.only(
                                  left: 5.0.w,
                                  right: 3.0.w,
                                ),
                                decoration: BoxDecoration(),
                                child: GestureDetector(
                                  onTap: () {
                                    //_showMyDialog(context);

                                    //---------------- Subcription ---------------
                                    if (authProvider.userInfodata!.email != '' &&
                                        authProvider.userInfodata!.phone !=
                                            '' &&
                                        authProvider.userInfodata!.full_name !=
                                            '') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BookApiCall(
                                                    book_id:
                                                        widget.recentlist.pk,
                                                    book_name: widget
                                                        .recentlist.bookname
                                                        .toString(),
                                                    is_pdf: widget
                                                        .recentlist.is_pdf,
                                                  )));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserProfileEdit(
                                                    profiledata: authProvider,
                                                    checkdata: 1,
                                                    bookid:
                                                        widget.recentlist.pk,
                                                    bookname: widget
                                                        .recentlist.bookname
                                                        .toString(),
                                                  )));
                                    }
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 2.5.w,
                                          bottom: 0.5.h,
                                          // top: 0.4.h,
                                          right: 2.5.w),
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
                                        child: AutoSizeText(
                                            LocaleKeys.readnow.tr(),
                                            //readnow,
                                            minFontSize: 3,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal)),
                                      )),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2.0.h, left: 5.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              bottom: 0.50.w,
                            ),
                            // height: 2.5.h,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  //height: 2.0.h,
                                  width: 90.0.w,
                                  child: Text(
                                    widget.recentlist.bookname.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 1.8.h),
                                  ),
                                ),
                                Consumer<FavouriteProviderModel>(
                                  builder: (context, model, child) {
                                    return Container(
                                      height: 2.50.h,
                                      width: 8.0.w,
                                      child: Align(
                                        child: Center(
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: Icon(Icons.favorite,
                                                size: 2.5.h),
                                            onPressed: () async {
                                              Map<String, dynamic>? authdata =
                                                  await model
                                                      .toggleProductFavoriteStatus(
                                                          id: widget
                                                              .recentlist.pk);
                                              print('i am working');

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      duration:
                                                          Duration(seconds: 2),
                                                      backgroundColor:
                                                          Color(0xffc60e13),
                                                      content: Text(
                                                          authdata!['message'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 1.8.h,
                                                              color: Colors
                                                                  .white))));

                                              print(authdata);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          // PopUpScreen(
                          //   //   name: "Name",
                          //   name: LocaleKeys.name.tr(),
                          //   title: recentlist.bookname.toString(),
                          // ),

                          PopUpScreen(
                            // name: "Writer Name",
                            name: LocaleKeys.writername.tr(),
                            title: widget.recentlist.author.toString(),
                          ),
                          PopUpScreen(
                            //name: "Publications",
                            name: LocaleKeys.publicaions.tr(),
                            title: widget.recentlist.publisher.toString(),
                          ),
                          PopUpScreen(
                            //  name: "Version",
                            name: LocaleKeys.version.tr(),
                            title: widget.recentlist.edition.toString(),
                          ),
                          PopUpScreen(
                            name: "ISBN",
                            title: widget.recentlist.isbn.toString(),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 3.1.h,
                                  width: 25.0.w,
                                  child: Text(
                                    LocaleKeys.rating.tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 1.5.h),
                                  ),
                                ),
                                Container(
                                    height: 2.5.h,
                                    width: 30.0.w,
                                    margin: EdgeInsets.only(bottom: 1.4.h),
                                    child: RatingBarIndicator(
                                        rating: double.parse(widget
                                            .recentlist.rating
                                            .toString()),
                                        itemBuilder: (context, index) => Icon(
                                              Icons.star,
                                              // color: Colors.amber,
                                            ),
                                        itemCount: 5,
                                        itemSize: 17.0,
                                        direction: Axis.horizontal)),
                              ]),

                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 3.1.h,
                                  width: 25.0.w,
                                  child: Text(
                                    LocaleKeys.share.tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 1.5.h),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await share();
                                  },
                                  child: Container(
                                      height: 4.5.h,
                                      width: 30.0.w,
                                      //  margin: EdgeInsets.only(top: .50.h),
                                      child: Center(
                                        child: Icon(
                                          Icons.share,
                                          color: Colors.red,
                                          size: 25,
                                        ),
                                      )),
                                ),
                              ])
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ModalTabBarLandscape(
                aboutNote: widget.recentlist.cover_note.toString(),
                bookdetails: widget.recentlist,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
