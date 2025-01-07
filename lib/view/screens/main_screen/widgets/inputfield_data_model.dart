

import 'dart:ui';

import 'package:flutter/material.dart';

class InputfieldsDataModel{
final int maxlines;
final bool? enabled;
final Color fillColor;
final String fieldName;
final String hintText;
final Icon? prefixIcon;
final TextEditingController controller;

  InputfieldsDataModel({required this.maxlines,required this.hintText,required this.fieldName,   this.enabled, required this.fillColor,  this.prefixIcon, required this.controller});

}
