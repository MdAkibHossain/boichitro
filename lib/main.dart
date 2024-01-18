import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:dhanshirisapp/components/review_design.dart';
import 'package:dhanshirisapp/provider/auth.dart';
import 'package:dhanshirisapp/provider/book_read.dart';
import 'package:dhanshirisapp/provider/deshboard.dart';
import 'package:dhanshirisapp/provider/categories_product_list.dart';
import 'package:dhanshirisapp/provider/favourit_list.dart';
import 'package:dhanshirisapp/provider/highlight.dart';
import 'package:dhanshirisapp/provider/history.dart';
import 'package:dhanshirisapp/provider/order.dart';
import 'package:dhanshirisapp/provider/profiledata.dart';
import 'package:dhanshirisapp/provider/review.dart';
import 'package:dhanshirisapp/provider/singinmodel.dart';
import 'package:dhanshirisapp/provider/subcription.dart';
import 'package:dhanshirisapp/provider/theme_provider.dart';
import 'package:dhanshirisapp/route_generator.dart';
import 'package:dhanshirisapp/screen/Deshboard.dart/Dashboard.dart';
import 'package:dhanshirisapp/screen/Deshboard.dart/text_lighlighit.dart';
import 'package:dhanshirisapp/screen/about%20page/aboutpage.dart';
import 'package:dhanshirisapp/screen/book_read_page_details.dart';
import 'package:dhanshirisapp/screen/book_request/book_requested_screen.dart';
import 'package:dhanshirisapp/screen/book_screen/about_book.dart';
import 'package:dhanshirisapp/screen/first_loadingscreen.dart';
import 'package:dhanshirisapp/screen/about_app.dart';
import 'package:dhanshirisapp/screen/music_player/music_player.dart';
import 'package:dhanshirisapp/screen/text_audio_file.dart';
import 'package:dhanshirisapp/screen/wishlist/update_Checker.dart';
import 'package:dhanshirisapp/services/push_notification.dart';
import 'package:dhanshirisapp/utill/debug_utils.dart';
import 'package:dhanshirisapp/widget/textfield_demo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'provider/delete_account.dart';
import 'dart:convert';

Future<void> backgroundHandler(RemoteMessage message) async {
  NotificationService.display(message);
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  NotificationService.initialize();
  FirebaseMessaging.instance.getInitialMessage();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
        path: 'assets/translations',
        supportedLocales: [
          Locale('en'),
          Locale('bn'),
        ],
        fallbackLocale: Locale('en'),
        child: Boichitro(),
      ), // Wrap your app
    ),
  );
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

class Boichitro extends StatefulWidget {
  @override
  State<Boichitro> createState() => _BoichitroState();
}

class _BoichitroState extends State<Boichitro> {
  // String currentVersion = '';
  // String staticVersionCode = '25.0.1';

  // // Future<void> getCurrentAppVersion() async {
  // //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // //   final cv = packageInfo.version;
  // //   setState(() {
  // //     currentVersion = cv;
  // //     print('current version' + currentVersion);
  // //   });
  // // }

  // // Future<void> updateDialog(BuildContext context) async {
  // //   await showDialog(
  // //     barrierDismissible: false,
  // //     context: context,
  // //     builder: (BuildContext context) {
  // //       return AlertDialog(
  // //         title: Text('Update New Version!'),
  // //         content: Text('A new version is available.'),
  // //         actions: [
  // //           // TextButton(
  // //           //   onPressed: () {
  // //           //     Navigator.of(context).pop();
  // //           //   },
  // //           //   child: Text('Cancel'),
  // //           // ),
  // //           TextButton(
  // //             onPressed: () async {
  // //               await launchUrl(
  // //                   Uri.parse(
  // //                       'https://play.google.com/store/apps/details?id=com.dhansiri.communicationltm.boichitro&pcampaignid=web_share'),
  // //                   mode: LaunchMode.externalApplication);
  // //             },
  // //             child: Text('Update'),
  // //           ),
  // //         ],
  // //       );
  // //     },
  // //   );
  // // }

  // Future<void> getLatestVersion() async {
  //   var apiUrl = Uri.parse('https://boichitro.com.bd/api/v1/version/android/');
  //   try {
  //     var response = await http.get(apiUrl);
  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body);
  //       print('server version' + data['version']);
  //       currentVersion = data['version'];
  //       logView(currentVersion);
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }

  @override
  void initState() {
    print('i am initState');
    super.initState();
    // getCurrentAppVersion();
    // getLatestVersion();
    FirebaseMessaging.onMessage.listen((message) {
      print('i am message');
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      } else {
        print(message);
      }
      NotificationService.display(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      NotificationService.display(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: SubcriptionModel()),
          ChangeNotifierProvider.value(value: DeleteAccountProvider()),
          ChangeNotifierProvider.value(value: HighlightProvider()),
          ChangeNotifierProvider.value(value: BookReadtModel()),
          ChangeNotifierProvider.value(value: AuthProvider()),
          ChangeNotifierProvider.value(value: CategoryProvider()),
          ChangeNotifierProvider.value(value: Orther()),
          ChangeNotifierProvider.value(value: FavouriteProviderModel()),
          ChangeNotifierProvider.value(value: CategoriesProductListModel()),
          ChangeNotifierProvider.value(value: ThemeProvider()),
          ChangeNotifierProvider.value(value: ReviewProvider()),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return Consumer<ThemeProvider>(
            child: SplashScreen(),
            builder: (context, model, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                locale: context.locale,
                themeMode: model.themeMode,
                theme: MyThemes.lightTheme,
                darkTheme: MyThemes.darkTheme,
                home: child,
                onGenerateRoute: RouteGenerator.generateRoute,
              );
            },
          );
        }));
  }
}
