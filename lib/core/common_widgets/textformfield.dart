import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/color.dart';
import 'package:leenas_mushrooms/core/font_style.dart';

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
    return TextFormField(
      initialValue: widget.dependentData,
      enabled: widget.enabled,
      style: AppFonts.getAppFont(
        color: AppColors.black,
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
                      color: AppColors.black,
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
          borderSide: BorderSide(color: Colors.black.withOpacity(.50)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black.withOpacity(.50)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black.withOpacity(.50)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.black),
        ),
        hintStyle: AppFonts.getAppFont(
          color: Colors.black.withOpacity(.50),
          context: context,
          size: 14,
          weight: FontWeight.w400,
        ),
      ),
    );
  }
}
