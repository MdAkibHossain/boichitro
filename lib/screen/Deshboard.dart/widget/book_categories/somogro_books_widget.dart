import 'package:dhanshirisapp/screen/Deshboard.dart/widget/titlename_withbutton.dart';
import 'package:dhanshirisapp/screen/book_categories_list/book_categorires_list.dart';
import 'package:dhanshirisapp/screen/book_screen/book_cart.dart';
import 'package:dhanshirisapp/translations/locale_keys.g.dart';
import 'package:dhanshirisapp/widget/no_data_available.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../provider/deshboard.dart';
import '../../../../widget/shimmer.dart';

class SomogroBook extends StatefulWidget {
  const SomogroBook({super.key});

  @override
  State<SomogroBook> createState() => _SomogroBookState();
}

class _SomogroBookState extends State<SomogroBook> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleNameWithButton(
          title: LocaleKeys.somogro.tr(),
          ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BooksCategoriesList(
                          category: 'Somogro',
                          search: '',
                          sort_name: "বইয়ের নাম",
                        )));
          },
        ),

        //Listview Builder
        Container(
          alignment: Alignment.topLeft,
          height: 27.0.h,
          margin: EdgeInsets.only(left: 01.0.w, bottom: 0.5.h),
          child: Consumer<CategoryProvider>(
            child: BookCartShimmer(),
            builder: (context, modal, child) {
              return modal.isLoadingAudioBookInfo
                  ? child as Widget
                  : modal.somogro!.length == 0
                      ? NodataAvailableClass('No Book Available', 25.0.h)
                      : ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: modal.somogro!.length,
                          itemBuilder: (context, index) {
                            final somogrodetails = modal.somogro![index];
                            return BookCart(
                              bookdetails: somogrodetails,
                            );
                          });
            },
          ),
        ),
      ],
    );
    ;
  }
}
