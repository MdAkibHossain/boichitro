import 'package:dhanshirisapp/utill/debug_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../provider/deshboard.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../../widget/no_data_available.dart';
import '../../../../widget/shimmer.dart';
import '../../../book_categories_list/book_categorires_list.dart';
import '../../../book_screen/book_cart.dart';
import '../titlename_withbutton.dart';

class BangabondhuBookWidget extends StatefulWidget {
  const BangabondhuBookWidget({Key? key}) : super(key: key);

  @override
  State<BangabondhuBookWidget> createState() => _BangabondhuBookWidgetState();
}

class _BangabondhuBookWidgetState extends State<BangabondhuBookWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleNameWithButton(
          title: LocaleKeys.bongobondhu.tr(),
          ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BooksCategoriesList(
                          category: 'মুক্তিযুদ্ধ',
                          search: '',
                          sort_name: "বইয়ের নাম",
                        )));
          },
        ),
        Container(
          alignment: Alignment.topLeft,
          height: 27.0.h,
          margin: EdgeInsets.only(left: 01.0.w, bottom: 0.5.h, top: 1.0.h),
          child: Consumer<CategoryProvider>(
            // child: Center(child: Text('Loading....')),
            child: BookCartShimmer(),
            builder: (context, model, child) {
              // logView(
              //     'Bongubandhu part:::::::::::::${model.categoryList[0].name}');
              return model.isLoadingBookInfo
                  ? child as Widget
                  : model.recentBooks!.length == 0
                      ? NodataAvailableClass('No Book Available', 25.0.h)
                      : ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: model.recentBooks!.length,
                          itemBuilder: (context, index) {
                            final bookdetails = model.recentBooks![index];
                            return BookCart(
                              bookdetails: bookdetails,
                            );
                          });
            },
          ),
        ),
      ],
    );
  }
}
