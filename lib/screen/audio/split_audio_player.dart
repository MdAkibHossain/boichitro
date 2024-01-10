import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/db/history_database.dart';
import 'package:dhanshirisapp/db/history_data.dart';
import 'package:dhanshirisapp/model/shomogro_books_read.dart';
import 'package:dhanshirisapp/provider/book_read.dart';
import 'package:dhanshirisapp/provider/highlight.dart';
import 'package:dhanshirisapp/provider/order.dart';
import 'package:dhanshirisapp/screen/audio/split_audio_listener.dart';
import 'package:dhanshirisapp/screen/book_read_page/book_read_page.dart';
import 'package:dhanshirisapp/screen/book_read_page_details.dart';
import 'package:dhanshirisapp/screen/book_read_screen.dart';
import 'package:dhanshirisapp/screen/magazine/magazineread.dart';
import 'package:dhanshirisapp/screen/somogro/somogro_books_widget.dart';
import 'package:dhanshirisapp/screen/somogro/somogro_book_reader.dart';
import 'package:dhanshirisapp/screen/wishlist/pdf_book_read.dart';
import 'package:dhanshirisapp/services/secure_storage_service.dart';
import 'package:dhanshirisapp/widget/drower_customer/add_drower_customer.dart';
import 'package:dhanshirisapp/widget/no_data_available.dart';
import 'package:dhanshirisapp/widget/splash_screen/appdrawerbook.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AudioApiCall extends StatefulWidget {
  final int? id;
  final String? book_name;
  AudioApiCall({
    required this.id,
    required this.book_name,
  });
  @override
  _AudioApiCallState createState() => _AudioApiCallState();
}

class _AudioApiCallState extends State<AudioApiCall> {
  // late List<Note> notes;
  // Note? notesdata;
  String? book_details;
  @override
  void didChangeDependencies() async {
    var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
    // print(token);
    BookReadtModel bookReadtModel =
        Provider.of<BookReadtModel>(context, listen: false);
    HighlightProvider highlightProvider =
        Provider.of<HighlightProvider>(context, listen: false);
    highlightProvider.clean();
    // print('----------------book_id--------------');
    // print(widget.book_name);
    // Map<String, dynamic>? data =
    await bookReadtModel.audiolistenapicall(token, widget.id!);
    // book_details = data!['book_details'];
    // print('ZZZZZZZZZZZZZZZZZZZZZZZZZSS');
    // print(data);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Orther order = Provider.of<Orther>(context);
    return Scaffold(
      body: Container(
          child: Consumer<BookReadtModel>(
              child: Center(child: CircularProgressIndicator()),
              builder: (context, model, child) {
                return model.isloadingmodel
                    ? child as Widget
                    : model.audiopage!.length == 0
                        ? NodataAvailableClass('Book is Empty !', 80.0.h)
                        : AudioListener(
                            model.audiopage, model.audiopage!.length);

                // SomogroReadPage(
                //     pk: widget.pk,
                //     book_details: book_details,
                //     book_id: widget.book_slug,
                //     book_name: widget.book_name,
                //     bookpagemodel: model,
                //     orther: order,
                //   )
                // ;
              })),
    );
  }
}
