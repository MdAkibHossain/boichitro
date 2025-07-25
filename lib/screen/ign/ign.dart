import 'package:dhanshirisapp/screen/Deshboard.dart/widget/titlename_withbutton.dart';
import 'package:dhanshirisapp/screen/audio/audio_card.dart';
import 'package:dhanshirisapp/screen/ign/ign_cart.dart';
import 'package:dhanshirisapp/screen/magazine/magazine_cart.dart';
import 'package:dhanshirisapp/widget/no_data_available.dart';
import 'package:dhanshirisapp/widget/shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/deshboard.dart';
import '../../translations/locale_keys.g.dart';
import '../book_categories_list/book_categorires_list.dart';
import '../book_screen/book_cart.dart';

class IGNWidget extends StatefulWidget {
  const IGNWidget({Key? key}) : super(key: key);

  @override
  State<IGNWidget> createState() => _IGNWidgetState();
}

class _IGNWidgetState extends State<IGNWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleNameWithButton(
          title: LocaleKeys.ign.tr(),
          ontap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => BooksCategoriesList(
            //               category: 'Magazine',
            //               search: '',
            //               sort_name: "বইয়ের নাম",
            //             )));
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
                  : modal.ign!.length == 0
                      ? NodataAvailableClass('No IGN Available', 25.0.h)
                      : ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: modal.ign!.length,
                          itemBuilder: (context, index) {
                            final igndetails = modal.ign![index];
                            return IGN_cart(
                              igndetails: igndetails,
                            );
                          });
            },
          ),
        ),
      ],
    );
  }
}
