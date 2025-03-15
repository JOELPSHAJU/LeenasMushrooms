import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_dropdown.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_input_fields.dart';
import 'package:leenas_mushrooms/core/common_widgets/date_picker.dart';
import 'package:leenas_mushrooms/core/common_widgets/main_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/core/common_widgets/textfield_with_quantity.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/main_screen.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/inputfield_data_model.dart';

class AddBedDetailsScreen extends StatefulWidget {
  const AddBedDetailsScreen({super.key});

  @override
  State<AddBedDetailsScreen> createState() => _AddBedDetailsScreenState();
}

final quantityController = TextEditingController();
final damageController = TextEditingController();
final remarksController = TextEditingController();
String timecontroller = '';
String currentDate = "";

class _AddBedDetailsScreenState extends State<AddBedDetailsScreen> {
  String selectedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  String selectedHarvestTime = 'Morning';
  String dateController = "";

  List<InputfieldsDataModel> inputfields = [
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        quantity: true,
        controller: quantityController,
        fieldName: 'Quantity',
        hintText: 'Enter quantity'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: damageController,
        fieldName: 'No. Of Packets',
        hintText: 'Number of packets (nos)'),
    InputfieldsDataModel(
        maxlines: 4,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        isRemarkNeed: false,
        controller: remarksController,
        fieldName: 'Remarks',
        hintText: 'Enter remarks'),
  ];

  @override
  void initState() {
    currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CommonAppBar(iconNeeded: false),
      backgroundColor: AppColors.cardcolor,
      body: Column(children: [
        ScreenRouteTitle(
          title: 'Add Bed Details',
          action: () => Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (C) => MainScreen())),
        ),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r)),
                ),
                width: size.width,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      CommonDatePicker(
                         onDateChanged: (value) {
                              dateController= value;
                            },
                          hint: currentDate,
                          startDateHeading: 'Date',
                          selectedItem: dateController),
                      // Harvest Time Selection
                      CommonDropdown(
                           onChanged:(value) {
                          timecontroller = value;
                        },
                          results: timecontroller,
                          fieldName: 'Harvest Time',
                          hintText: 'Select harvest time',
                          options: const [
                            'Morning',
                            'Evening',
                          ]),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: inputfields.length + 1,
                        itemBuilder: (context, index) {
                          if (index == inputfields.length) {
                            return const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: MainButton(buttonText: 'Add Details'));
                          }

                          return inputfields[index].quantity == true
                              ? TextfieldWithQuantity(
                                  fillColor: inputfields[index].fillColor,
                                  maxlines: inputfields[index].maxlines,
                                  hintText: inputfields[index].hintText,
                                  enabled: inputfields[index].enabled == true
                                      ? true
                                      : false,
                                  fieldName: inputfields[index].fieldName,
                                  controller: inputfields[index].controller)
                              : CommonTextformField(
                                  fillColor: inputfields[index].fillColor,
                                  maxlines: inputfields[index].maxlines,
                                  isRemarkNeed: inputfields[index].isRemarkNeed,
                                  hintText: inputfields[index].hintText,
                                  enabled: inputfields[index].enabled == true
                                      ? true
                                      : false,
                                  fieldName: inputfields[index].fieldName,
                                  controller: inputfields[index].controller);
                        },
                      ),
                    ]))))
      ]),
    );
  }
}
