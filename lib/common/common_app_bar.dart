import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../screen/Deshboard.dart/Dashboard.dart';

// ignore: must_be_immutable
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  //void Function()? onPressed;
  //void Function() filterPressed;
  final String title;
  final String? formPage;
  final bool? isHomeActive;
  const CommonAppBar({
    required this.height,
    // required this.onPressed,
    // required this.filterPressed,
    Key? key,
    required this.title,
    this.formPage = 'home',
    this.isHomeActive = false,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _appbar(context);
  }

  Widget _appbar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color(0xffc60e13),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(title,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16.5.sp)),
      // backgroundColor: AppColors.white,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),

      actions: [
        isHomeActive == true
            ? GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 2.5.w),
                  child: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
              )
            : SizedBox(),
      ],
      // actions: [
      //   GestureDetector(
      //     onTap: () {
      //       filterPressed();
      //       //   Navigator.pushNamed(context, RouteName.filterScreen);
      //       print("object");
      //     },
      //     child: const SizedBox(
      //       child: Icon(
      //         Icons.filter_alt,
      //         // color: AppColors.primaryColor,
      //       ),
      //     ),
      //   ),
      //   const SizedBox(
      //     width: 16,
      //   ),
      // ],
    );
  }
}
