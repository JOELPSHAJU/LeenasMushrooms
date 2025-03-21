import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/heading_input_fields.dart';

// ignore: must_be_immutable
class CommonTextformField extends StatefulWidget {
  CommonTextformField({
    super.key,
    required this.maxlines,
    required this.hintText,
    this.sufixText,
    required this.enabled,
    this.prefixText,
    this.dependentData,
    this.type,
    this.suffix,
    this.isRemarkNeed,
    this.sufixOntap,
    this.prefixOntap,
    this.suffixWidget,
    required this.fieldName,
    this.prefixwidget,
    required this.controller,
    this.fillColor,
    this.validator,
    this.results,
    this.keytext,
  });

  final int maxlines;
  final String? sufixText;
  final Map<String, dynamic>? results;
  final String? keytext;
  final bool? isRemarkNeed;
  final String? dependentData;
  final String? prefixText;
  final validator;
  final String fieldName;
  final Widget? prefixwidget;
  final TextInputType? type;
  final VoidCallback? sufixOntap;
  final TextEditingController controller;
  final VoidCallback? prefixOntap;
  final bool enabled;

  final String hintText;
  final Icon? suffix;
  final Widget? suffixWidget;
  Color? fillColor = AppColors.white;

  @override
  State<CommonTextformField> createState() => _CommonTextformFieldState();
}

class _CommonTextformFieldState extends State<CommonTextformField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          widget.fieldName.isNotEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    HeadingRequestPage(
                      title: widget.fieldName,
                      isRemarkNeed: widget.isRemarkNeed,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                )
              : SizedBox(
                  height: 20.h,
                ),
          TextFormField(
            initialValue: widget.dependentData,
            enabled: widget.enabled,
            keyboardType:widget. type,
            validator: widget.isRemarkNeed == false ? null : widget.validator,
            style: AppFonts.getAppFont(
              color: AppColors.textfieldTextColor,
              context: context,
              size: 14,
              weight: FontWeight.w400,
            ),
            maxLines: widget.maxlines,
            controller: widget.controller,
            decoration: InputDecoration(
              fillColor: widget.enabled ? widget.fillColor : AppColors.white,
              filled: true,
              prefixIcon: widget.prefixwidget != null
                  ? GestureDetector(
                      onTap: widget.prefixOntap,
                      child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 5, top: 13.5, bottom: 13.5),
                          child: widget.prefixwidget),
                    )
                  : null,
              suffixIcon: widget.sufixText != null
                  ? GestureDetector(
                      onTap: widget.sufixOntap,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: 12,
                          top: 13,
                        ),
                        child: Text(
                          widget.sufixText.toString(),
                          style: AppFonts.getAppFont(
                            color: AppColors.textfieldTextColor,
                            context: context,
                            size: 14,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  : widget.suffixWidget,
              hintText: widget.hintText,
              errorBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red.shade700),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.dropdownBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.dropdownBorderColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.dropdownBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Colors.black.withValues(alpha: .50)),
              ),
              hintStyle: AppFonts.getAppFont(
                color: AppColors.textfieldTextColor,
                context: context,
                size: 14,
                weight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
