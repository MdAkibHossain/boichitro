import 'package:dhanshirisapp/screen/first_loadingscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateChecker extends StatefulWidget {
  @override
  State<UpdateChecker> createState() => _UpdateCheckerState();
}

class _UpdateCheckerState extends State<UpdateChecker> {
  // String currentVersion = '';
  // String latestVersion = '2.1.0';
  @override
  void initState() {
    super.initState();

    // getCurrentAppVersion();
    // // Perform a check for the latest version
    // checkForUpdate();
  }

  // Future<void> getCurrentAppVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   final cv = packageInfo.version;
  //   setState(() {
  //     currentVersion = cv;
  //     print('cccccccvvvv' + currentVersion);
  //   });
  // }

  // Future<void> checkForUpdate() async {
  //   // final url = 'ddd';
  //   // print('AAAAAEEEEE' +
  //   //     currentVersion +
  //   //     'AAAAAAAAAAAAAAAPPPPPPPPPPPPVVVVVVVVVVVVVVVVV');

  //   // try {
  //   //   final response = await http.get(Uri.parse(url));
  //   //   if (response.statusCode == 200) {
  //   //     // Parse the HTML to get the latest version
  //   //     // final latestVersion = response.body;
  //   //     log('AAAAAAAAAAAAAAAPPPPPPPPPPPPVVVVVVVVVVVVVVVVV');
  //   //     print(currentVersion + 'AAAAAAAAAAAAAAAPPPPPPPPPPPPVVVVVVVVVVVVVVVVV');
  //   //     setState(() {
  //   //       latestVersion = response.body.toString();
  //   //     });

  //   if (latestVersion != currentVersion) {
  //     // A newer version is available, show a Snackbar
  //     print('version available');
  //     // showUpdateSnackbar();
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => SplashScreen()));
  //     // print('version checked');
  //   } else {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => SplashScreen()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Available'),
      content: Text(
          'A new version of the app is available. Please update to the latest version.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Dismiss the dialog
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SplashScreen()));
          },
          child: Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            // Execute the update logic
            // onUpdatePressed();
            redirectToPlayStore();
          },
          child: Text('UPDATE'),
        ),
      ],
    );
  }

  void redirectToPlayStore() async {
    final url =
        'https://play.google.com/store/apps/details?id=com.dhansiri.communicationltm.boichitro&pcampaignid=web_share';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void showUpdateSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('A new version is available. Please update your app.'),
        action: SnackBarAction(
          label: 'UPDATE',
          onPressed: () {
            // Logic to redirect the user to the Play Store
            // Replace 'com.yourapp.package' with your app's package name
            final url =
                'https://play.google.com/store/apps/details?id=com.yourapp.package';
            // Launch the Play Store URL
            // You might need to use the url_launcher package for this
            print('Redirect user to update the app');
          },
        ),
      ),
    );
  }
}
