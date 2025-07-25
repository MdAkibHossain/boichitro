import 'dart:async';
import 'dart:convert';
import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/provider/delete_account.dart';
import 'package:dhanshirisapp/provider/deshboard.dart';
import 'package:dhanshirisapp/provider/subcription.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/screen/somogro/somogro_books_widget.dart';
import 'package:dhanshirisapp/screen/ign/ign.dart';
import 'package:dhanshirisapp/screen/magazine/magazine.dart';
import 'package:dhanshirisapp/screen/Deshboard.dart/widget/search_widget.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/drower_customer/add_drower_customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/favourit_list.dart';
import '../../utill/debug_utils.dart';
import 'widget/audio_book/audio_book_widget.dart';
import 'widget/book_categories/bangabondhu_books_widget.dart';
import 'widget/book_categories/popular_books_widget.dart';
import 'widget/book_categories/recent_books_widget.dart';
import 'widget/book_categories_widget.dart';
import 'widget/image_slider._widget.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // int _currentPage = 0;
  // final PageController _pageControllers = PageController(initialPage: 0);

  // @override
  // void initState() {
  //   super.initState();
  //   Timer.periodic(Duration(seconds: 5), (Timer timer) {
  //     if (_currentPage < 3) {
  //       _currentPage++;
  //     } else {
  //       _currentPage = 0;
  //     }

  //     _pageController.animateToPage(
  //       _currentPage,
  //       duration: Duration(milliseconds: 300),
  //       curve: Curves.easeIn,
  //     );
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _pageControllers.dispose();
  // }

  // _onPageChanged(int index) {
  //   setState(() {
  //     _currentPage = index;
  //   });
  // }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isPortrait = false;
  // @override
  // void dispose() {
  //   super.dispose();
  //   _pageController.dispose();
  // }

  Future<dynamic> exitDialog() {
    // exit dialog
    return showDialog(
      barrierColor: Colors.white54,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[50],
        title: Text('Are You Sure ?',
            style: TextStyle(
              color: Colors.red,
            )),
        content: Text('Do you want to exit from the App ',
            style: TextStyle(
              color: Colors.black,
            )),
        actions: [
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text('Exit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                )),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                )),
          )
        ],
      ),
    );
  }

  Future _refresh() async {
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);

    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    SubcriptionModel subcriptionModel =
        Provider.of<SubcriptionModel>(context, listen: false);
    DeleteAccountProvider deleteProvider =
        Provider.of<DeleteAccountProvider>(context, listen: false);
    categoryProvider.fetchPreviewBooksImage(token);
    categoryProvider.fetchIGN(token);
    categoryProvider.fetchSomogro(token);
    categoryProvider.fetchmagazine(token);
    categoryProvider.fetcharecent(token);
    categoryProvider.fetchapopular(token);
    categoryProvider.fetchAudiobook(token);
    categoryProvider.fetchCategory(token);
  }

  String? currentVersion;
  String staticVersionCode = '25.0.7';

  // Future<void> getCurrentAppVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   final cv = packageInfo.version;
  //   setState(() {
  //     currentVersion = cv;
  //     print('current version' + currentVersion);
  //   });
  // }

  Future<void> getLatestVersion() async {
    var apiUrl = Uri.parse('https://boichitro.com.bd/api/v1/version/android/');
    try {
      var response = await http.get(apiUrl);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        currentVersion = data['version'];
        print('server version' + data['version']);
        if (currentVersion.toString() != staticVersionCode.toString()) {
          updateDialog(context);
        }
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> updateDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text('Update New Version!'),
            content: Text('A new version is available.'),
            actions: [
              // TextButton(
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              //   child: Text('Cancel'),
              // ),
              TextButton(
                onPressed: () async {
                  await launchUrl(
                      Uri.parse(
                          'https://play.google.com/store/apps/details?id=com.dhansiri.communicationltm.boichitro&pcampaignid=web_share'),
                      mode: LaunchMode.externalApplication);
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

//  @override
//   void dispose() {
//     super.dispose();
//   }
  @override
  void didChangeDependencies() async {
    //------initial call-------
    getLatestVersion();
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
    FavouriteProviderModel favouritebooks =
        Provider.of<FavouriteProviderModel>(context, listen: false);
    await favouritebooks.fatchfavouriteList();
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    DeleteAccountProvider deleteProvider =
        Provider.of<DeleteAccountProvider>(context, listen: false);
    SubcriptionModel subcriptionModel =
        Provider.of<SubcriptionModel>(context, listen: false);
    categoryProvider.fetchPreviewBooksImage(token);
    categoryProvider.fetcharecent(token);
    categoryProvider.fetchIGN(token);
    categoryProvider.fetchSomogro(token);
    categoryProvider.fetchmagazine(token);
    categoryProvider.fetchapopular(token);
    categoryProvider.fetchAudiobook(token);
    categoryProvider.fetchCategory(token);
    subcriptionModel.subcriptionTYPEAPICALL(token);
    //   FavouriteProviderModel favoriteProvider =
    Provider.of<FavouriteProviderModel>(context, listen: false)
        .fatchfavouriteList();
    // favoriteProvider.fatchfavouriteList();

    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   FocusScope.of(context).unfocus();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print('----dashboard------');
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return WillPopScope(
        onWillPop: () async {
          exitDialog();
          return Future.value(false);
        },
        child: Scaffold(
          key: _scaffoldKey,
          drawer: AppDrawerCustomer(),
          endDrawerEnableOpenDragGesture: false,
          body: Container(
            child: OrientationBuilder(builder: (context, orientation) {
              if (MediaQuery.of(context).orientation == Orientation.portrait) {
                print('i am protrait');
                _isPortrait = true;
                return buildProtraits(themeProvider);
              } else {
                print('i am landscape');
                return buildLandscapes(themeProvider);
              }
            }),
          ),
        ));
  }

  Widget buildProtraits(themeProvider) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                height: 18.0.h,
                child: Stack(
                  children: [
                    Container(
                      height: 16.0.h,
                      color: Color(0xffc60e13),
                      margin: EdgeInsets.only(
                        bottom: 5.0.h,
                      ),
                      padding: EdgeInsets.only(top: 2.0.h),
                      alignment: Alignment.center,
                      //  width: MediaQuery.of(context).size.width,
                      child: Text(
                        //     'বইচিত্র',
                        LocaleKeys.boichitro.tr(),
                        // TODO: has to make this a reusable widget
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 2.5.h),
                      ),
                    ),
                    SearchWidget(
                      isPortrait: _isPortrait,
                      scaffoldKey: _scaffoldKey,
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 82.0.h,
              width: 100.0.w,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.white.withOpacity(.9), BlendMode.dstOut),
                          image: new AssetImage(
                            'assets/backgroudImagedeshboard.png',
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ImageSlider(),
                          BookCategories(
                            isPortrait: _isPortrait,
                          ),
                          RecentBookWidget(),
                          BangabondhuBookWidget(),
                          PopularBookWidget(),
                          SomogroBook(),
                          IGNWidget(),
                          MagazineWidget(),
                          AudioBookWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //--------------------------123414-------------
  //1111111--------------------------------------
  //-----------------------------asdfa-------------------------asfaf------------------

  Widget buildLandscapes(themeProvider) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 18.0.h,
            child: Stack(
              children: [
                Container(
                  height: 16.0.h,
                  color: Color(0xffc60e13),
                  margin: EdgeInsets.only(
                    bottom: 5.0.h,
                  ),
                  padding: EdgeInsets.only(top: 2.0.h),
                  alignment: Alignment.center,
                  //  width: MediaQuery.of(context).size.width,
                  child: Text(
                    //     'বইচিত্র',
                    LocaleKeys.boichitro.tr(),
                    // TODO: has to make this a reusable widget
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 2.5.h),
                  ),
                ),
                SearchWidget(
                  isPortrait: _isPortrait,
                  scaffoldKey: _scaffoldKey,
                )
              ],
            ),
          ),
          Container(
            height: 32.0.h,
            child: ListView(
              children: [
                Container(
                  height: 133.0.h,
                  // width: 100.0.w,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.white.withOpacity(.9), BlendMode.dstOut),
                      image: new AssetImage(
                        'assets/backgroudImagedeshboard.png',
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ImageSlider(),
                      BookCategories(isPortrait: _isPortrait),
                      RecentBookWidget(),
                      PopularBookWidget(),
                      MagazineWidget(),
                      IGNWidget(),
                      AudioBookWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
