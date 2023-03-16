import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/db/history_database.dart';
import 'package:dhanshirisapp/db/history_data.dart';
import 'package:dhanshirisapp/provider/book_read.dart';
import 'package:dhanshirisapp/provider/highlight.dart';
import 'package:dhanshirisapp/provider/order.dart';
import 'package:dhanshirisapp/screen/book_read_page/book_read_page.dart';
import 'package:dhanshirisapp/screen/book_read_page_details.dart';
import 'package:dhanshirisapp/screen/book_read_screen.dart';
import 'package:dhanshirisapp/screen/ign/ign_file_converter.dart';
import 'package:dhanshirisapp/screen/ign/ign_player.dart';
import 'package:dhanshirisapp/screen/ign/webviewplayer.dart';
import 'package:dhanshirisapp/screen/magazine/magazineread.dart';
import 'package:dhanshirisapp/screen/wishlist/pdf_book_read.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/widget/drower_customer/add_drower_customer.dart';
import 'package:dhanshirisapp/widget/no_data_available.dart';
import 'package:dhanshirisapp/widget/splash_screen/appdrawerbook.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/platform_interface.dart';

class IGNApiCall extends StatefulWidget {
  final int? book_id;
  IGNApiCall({
    required this.book_id,
  });
  @override
  _IGNApiCallState createState() => _IGNApiCallState();
}

class _IGNApiCallState extends State<IGNApiCall> {
  var ign_type;
  var ign_url;
  var ign_file;

  @override
  void didChangeDependencies() async {
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
    print(token);
    BookReadtModel bookReadtModel =
        Provider.of<BookReadtModel>(context, listen: false);
    HighlightProvider highlightProvider =
        Provider.of<HighlightProvider>(context, listen: false);
    highlightProvider.clean();
    print('----------------book_id--------------');
    print(widget.book_id);
    Map<String, dynamic>? data =
        await bookReadtModel.ignapicall(token, widget.book_id!);
    ign_url = data!['ign_url'];
    ign_type = data['ign_type'];
    ign_file = data['ign_file'];

    print(
        '----------------iiiiiiiiiiiiiiiiiiiiiigggggggggggggggggnnnnnnnnnnnnnnnn--------------');
    print(ign_type);
    print(ign_file);
    print(ign_url);

    print(ign_url);
    print(widget.book_id);
    print(
        '----------------iiiiiiiiiiiiiiiiiiiiiigggggggggggggggggnnnnnnnnnnnnnnnn--------------');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Consumer<BookReadtModel>(
              child: Center(child: CircularProgressIndicator()),
              builder: (context, model, child) {
                return model.isloadingmodel
                    ? child as Widget
                    : ign_type == 'file'
                        ? IGN_File_Converter(fileUrl: ign_file)
                        : WebViewVideo(
                            videoUrl: ign_url,
                          );
              })),
    );
  }
}
