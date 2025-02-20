import 'package:flutter/material.dart';

class InputfieldsDataModel {
  final int maxlines;
  final bool? enabled;
  final Color fillColor;
  final String fieldName;
  final String hintText;
  final bool? isRemarkNeed;
  bool? quantity = false;
  final List<String>? options;
  final Icon? prefixIcon;
  final TextEditingController controller;
  final bool isDropdown; // Added for dropdown support

  InputfieldsDataModel({
    required this.maxlines,
    required this.hintText,
    this.quantity,
    this.isRemarkNeed,
    this.options,
    required this.fieldName,
    this.enabled,
    required this.fillColor,
    this.prefixIcon,
    required this.controller,
    this.isDropdown = false, // Default to false if not provided
  });
}
