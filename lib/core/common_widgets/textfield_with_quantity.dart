import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_input_fields.dart';
import 'package:leenas_mushrooms/core/common_widgets/custom_validators.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';

class TextfieldWithQuantity extends StatefulWidget {
  const TextfieldWithQuantity({
    super.key,
    required this.maxlines,
    required this.hintText,
    required this.fillColor,
    required this.enabled,
    required this.validator,
    required this.fieldName,
    required this.controller,
  });

  final int maxlines;
  final String hintText;
  final Color fillColor;
  final validator;
  final bool enabled;
  final String fieldName;
  final TextEditingController controller;

  @override
  State<TextfieldWithQuantity> createState() => _TextfieldWithQuantityState();
}

class _TextfieldWithQuantityState extends State<TextfieldWithQuantity> {
  String quantity = "Kg";

  void toggleQuantity() {
    setState(() {
      quantity = (quantity == "Kg") ? "Nos" : "Kg";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonTextformField(
            validator: validateNotNull,
            maxlines: widget.maxlines,
            fillColor: Colors.white,
            hintText: widget.hintText,
            enabled: widget.enabled,
            fieldName: widget.fieldName,
            controller: widget.controller,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              "Unit",
              style: AppFonts.getAppFont(
                context: context,
                color: AppColors.black,
                size: 16.sp,
                weight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5.h),
            GestureDetector(
              onTap: toggleQuantity,
              child: Padding(
                padding: EdgeInsetsDirectional.only(end: 20.w),
                child: Container(
                  width: 55.w,
                  height: 55.5.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.dropdownBorderColor),
                  ),
                  child: Center(
                    child: Text(
                      quantity,
                      style: AppFonts.getAppFont(
                        color: AppColors.textfieldTextColor,
                        context: context,
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
