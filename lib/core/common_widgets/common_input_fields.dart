import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
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
    this.suffix,
    this.sufixOntap,
    this.prefixOntap,
    this.suffixWidget,
    required this.fieldName,
    this.prefixwidget,
    required this.controller,
    this.fillColor,
    this.results,
    this.keytext,
  });

  final int maxlines;
  final String? sufixText;
  final Map<String, dynamic>? results;
  final String? keytext;
  final String? dependentData;
  final String? prefixText;
  final String fieldName;
  final Widget? prefixwidget;
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
                    HeadingRequestPage(title: widget.fieldName),
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
              // Corrected prefixIcon GestureDetector
              prefixIcon: widget.prefixwidget != null
                  ? GestureDetector(
                      onTap: widget.prefixOntap, // Correct onTap call
                      child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 5, top: 13.5, bottom: 13.5),
                          child: widget.prefixwidget),
                    )
                  : null,
              // Corrected suffixIcon GestureDetector
              suffixIcon: widget.sufixText != null
                  ? GestureDetector(
                      onTap: widget.sufixOntap, // Correct onTap call
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

class CommonDropdown extends StatefulWidget {
  CommonDropdown({
    super.key,
    required this.results,
    required this.fieldName,
    required this.hintText,
    this.fillColor,
    required this.options,
  });

  String results;
  final List<String> options;
  final String hintText;
  final Color? fillColor;
  final String fieldName;

  @override
  State<CommonDropdown> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> {
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.hintText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
      child: Column(
        children: [
          HeadingRequestPage(title: widget.fieldName),
          h10,
          Container(
            height: 55.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.dropdownBorderColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                menuMaxHeight: 250.h,
                borderRadius: BorderRadius.circular(10.r),
                value:
                    selectedStatus == widget.hintText ? null : selectedStatus,
                hint: Text(
                  widget.hintText,
                  style: TextStyle(
                    color: AppColors.textfieldTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                isExpanded: true,
                icon: Icon(CupertinoIcons.chevron_down,
                    size: 20.w, color: AppColors.black15),
                dropdownColor: Colors.white,
                items: widget.options
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: AppColors.textfieldTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                    widget.results = value.toString();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
