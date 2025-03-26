import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';

class MainScreenListTile extends StatelessWidget {
  const MainScreenListTile({
    super.key,
    required this.size,
    required this.image,
    required this.text,
  });
  final String image;
  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          width: size.width,
          height: 150.h,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 15.0,
                    offset: const Offset(4, 4),
                    spreadRadius: 1.0),
                const BoxShadow(
                    color: Colors.white,
                    blurRadius: 15.0,
                    offset: Offset(-4, -4),
                    spreadRadius: 1.0),
              ],
              image: DecorationImage(
                  image: AssetImage(
                    image,
                  ),
                  fit: BoxFit.cover,
                  opacity: .5),
              color: Colors.black,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(
            text,
            style: AppFonts.getAppFont(
                context: context,
                size: 28.sp,
                weight: FontWeight.w500,
                color: AppColors.white),
          ))),
    );
  }
}
