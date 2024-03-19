import 'package:dhanshirisapp/common/common_app_bar.dart';
import 'package:dhanshirisapp/constants/app_constants.dart';
import 'package:dhanshirisapp/db/history_database.dart';
import 'package:dhanshirisapp/db/history_data.dart';
import 'package:dhanshirisapp/provider/book_read.dart';
import 'package:dhanshirisapp/provider/highlight.dart';
import 'package:dhanshirisapp/provider/order.dart';
import 'package:dhanshirisapp/screen/book_read_page/book_read_page.dart';
import 'package:dhanshirisapp/screen/book_read_page_details.dart';
import 'package:dhanshirisapp/screen/book_read_screen.dart';
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

class BookApiCall extends StatefulWidget {
  final int? book_id;
  final String? book_name;
  final bool? is_pdf;
  //final bool is_pdf;
  BookApiCall({
    required this.book_id,
    required this.book_name,
    this.is_pdf,
    // required this.is_pdf
  });
  @override
  _BookApiCallState createState() => _BookApiCallState();
}

class _BookApiCallState extends State<BookApiCall> {
  late List<Note> notes;
  Note? notesdata;
  String? book_details;
  var pdf_book_link;
  var pdf_link;
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
        await bookReadtModel.bookreadapicall(token, widget.book_id!);
    book_details = data!['book_details'];
    pdf_book_link = data['book_details'];
    print('aaaaaaaaaaaaaaaa');
    pdf_link = pdf_book_link.toString().split(":")[1].split('"')[1];
    print('aaaaaaaaaaaaaaaa');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Orther order = Provider.of<Orther>(context);
    return Scaffold(
      // appBar: CommonAppBar(height: 6.5.h, title: 'title'),
      body: Container(
          child: Consumer<BookReadtModel>(
              child: Center(child: CircularProgressIndicator()),
              builder: (context, model, child) {
                return model.isloadingmodel
                    ? child as Widget
                    : model.BookPage!.length == 0
                        ? NodataAvailableClass('Book is Empty !', 80.0.h)
                        : widget.is_pdf == true
                            ? ReadPdf(
                                book_details: pdf_link,
                              )
                            : BookReadPage(
                                book_details: book_details,
                                book_id: widget.book_id,
                                book_name: widget.book_name,
                                bookpagemodel: model,
                                orther: order,
                                is_pdf: widget.is_pdf,
                              );
              })),
    );
  }
}
