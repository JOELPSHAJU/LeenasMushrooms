import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';

class HeadingRequestPage extends StatelessWidget {
  const HeadingRequestPage({super.key, required this.title, this.isPurchase});

  final bool? isPurchase;
  final String title;

  @override
  Widget build(BuildContext context) {
    return isPurchase == true
        ? SizedBox()
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: title,
                        style: AppFonts.getAppFont(
                          context: context,
                          color: AppColors.black,
                          size: 16.sp,
                          weight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' *',
                        style: AppFonts.getAppFont(
                          context: context,
                          color: Colors.red,
                          size: 16.sp,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}