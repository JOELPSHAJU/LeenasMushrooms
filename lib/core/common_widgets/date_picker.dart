import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/heading_input_fields.dart';

// ignore: must_be_immutable
class CommonDatePicker extends StatefulWidget {
  String? fieldName;
  final String hint;
  String? dependentData;
  String selectedItem;
  final String startDateHeading;
  final ValueChanged<String> onDateChanged; // Callback to update parent

  CommonDatePicker({
    super.key,
    this.dependentData,
    this.fieldName,
    required this.hint,
    required this.startDateHeading,
    required this.selectedItem,
    required this.onDateChanged,
  });

  @override
  _CommonDatePickerState createState() => _CommonDatePickerState();
}

class _CommonDatePickerState extends State<CommonDatePicker> {
  late String selectedStartDate;
  Color dropdownBorderColor = AppColors.dropdownBorderColor;

  @override
  void initState() {
    super.initState();
    selectedStartDate = widget.selectedItem.isNotEmpty
        ? widget.selectedItem
        : widget.dependentData ?? _getCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.startDateHeading.isNotEmpty) ...[
              SizedBox(height: 20.h),
              HeadingRequestPage(title: widget.startDateHeading),
              SizedBox(height: 10.h),
            ],
            FormField<String>(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialValue: selectedStartDate,
              validator: (value) {
                if (selectedStartDate.isEmpty) {
                  dropdownBorderColor = Colors.redAccent;
                  return 'Please select a date';
                } else {
                  dropdownBorderColor = Colors.black.withOpacity(0.08);
                }
                return null;
              },
              builder: (FormFieldState<String> state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _selectStartDate(context),
                      child: Container(
                        height: 55.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: dropdownBorderColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedStartDate.isEmpty
                                  ? widget.hint
                                  : selectedStartDate,
                              style: AppFonts.getAppFont(
                                context: context,
                                color: AppColors.textfieldTextColor,
                                size: 14.sp,
                                weight: FontWeight.w400,
                              ),
                            ),
                            loadAssetPic(ImagePathProvider.calenderIcon,
                                color: AppColors.textfieldTextColor, width: 15)
                          ],
                        ),
                      ),
                    ),
                    if (state.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          state.errorText ?? '',
                          style: AppFonts.getAppFont(
                            color: Colors.redAccent,
                            context: context,
                            size: 12.sp,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }

  void _selectStartDate(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 280.h,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                color: AppColors.primaryColor,
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                  child: Text(
                    'Select',
                    style: AppFonts.getAppFont(
                      color: AppColors.white,
                      context: context,
                      size: 18.sp,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    widget.onDateChanged(selectedStartDate); // Notify parent
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: 200.h,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    selectedStartDate =
                        '${newDateTime.month}/${newDateTime.day}/${newDateTime.year}';
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    return '${now.month}/${now.day}/${now.year}';
  }
}