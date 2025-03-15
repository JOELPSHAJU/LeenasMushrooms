import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/heading_input_fields.dart';

class CommonDropdown extends StatefulWidget {
  CommonDropdown({
    super.key,
    required this.results,
    required this.fieldName,
    required this.hintText,
    this.fillColor,
    required this.options,
    required this.onChanged, // Callback to update parent
  });

  String results;
  final List<String> options;
  final String hintText;
  final Color? fillColor;
  final String fieldName;
  final ValueChanged<String> onChanged;

  @override
  State<CommonDropdown> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> {
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.results.isNotEmpty ? widget.results : null;
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
                value: selectedStatus,
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
                    widget.onChanged(value!); // Notify parent
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