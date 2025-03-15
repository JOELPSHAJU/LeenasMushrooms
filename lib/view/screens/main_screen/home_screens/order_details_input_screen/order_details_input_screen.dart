import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_dropdown.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_input_fields.dart';
import 'package:leenas_mushrooms/core/common_widgets/date_picker.dart';
import 'package:leenas_mushrooms/core/common_widgets/main_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/core/common_widgets/textfield_with_quantity.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/inputfield_data_model.dart';

class OrderDetailsInputScreen extends StatefulWidget {
  const OrderDetailsInputScreen({super.key});

  @override
  State<OrderDetailsInputScreen> createState() =>
      _OrderDetailsInputScreenState();
}

final nameController = TextEditingController();
final addressController = TextEditingController();
final pincodeController = TextEditingController();

final phoneNumberController = TextEditingController();
final catalougeController = TextEditingController();
final quantityController = TextEditingController();
final courierDataController = TextEditingController();

final trackingStatusController = TextEditingController();

class _OrderDetailsInputScreenState extends State<OrderDetailsInputScreen> {
  String currentDate = "";

  String dateController = "";
  String orderTypeController = '';
  List<InputfieldsDataModel> inputfields = [
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: nameController,
        fieldName: 'Name',
        hintText: 'Enter name'),
    InputfieldsDataModel(
        maxlines: 3,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: addressController,
        fieldName: 'Address',
        hintText: 'Enter address'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: pincodeController,
        fieldName: 'Pin Code',
        hintText: 'Enter pin code'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: phoneNumberController,
        fieldName: 'Phone Number',
        hintText: 'Enter phone number'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: catalougeController,
        fieldName: 'Catalouge',
        hintText: 'Enter item catalouge'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        quantity: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: quantityController,
        fieldName: 'Quantity',
        hintText: 'Enter quantity'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: courierDataController,
        fieldName: 'Courier Provider',
        hintText: 'Enter courier provider'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: courierDataController,
        fieldName: 'Courier Reference No.',
        hintText: 'Enter courier reference no.'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        options: ['Dispatched', 'In Transit', 'Delivered', 'Return'],
        controller: trackingStatusController,
        fieldName: 'Tracking Status',
        hintText: 'Select tracking status'),
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
      backgroundColor: AppColors.cardcolor,
      body: Column(children: [
        ScreenRouteTitle(title: 'Order Details'),
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
                      CommonDropdown(
                        onChanged:(value) {
                          orderTypeController = value;
                        },
                          results: orderTypeController,
                          fieldName: 'Order Type',
                          hintText: 'Select order type',
                          options: const [
                            'Seed',
                            'Bed',
                            'Pellets',
                            'Grow Kit'
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
                              : inputfields[index].options != null
                                  ? CommonDropdown(
                                     onChanged:(value) {
                          trackingStatusController.text = value;
                        },
                                      results: trackingStatusController.text,
                                      fieldName: inputfields[index].fieldName,
                                      hintText: inputfields[index].hintText,
                                      options: inputfields[index].options ?? [])
                                  : CommonTextformField(
                                      fillColor: inputfields[index].fillColor,
                                      maxlines: inputfields[index].maxlines,
                                      hintText: inputfields[index].hintText,
                                      enabled:
                                          inputfields[index].enabled == true
                                              ? true
                                              : false,
                                      fieldName: inputfields[index].fieldName,
                                      controller:
                                          inputfields[index].controller);
                        },
                      ),
                      h50
                    ])))),
      ]),
    );
  }
}
