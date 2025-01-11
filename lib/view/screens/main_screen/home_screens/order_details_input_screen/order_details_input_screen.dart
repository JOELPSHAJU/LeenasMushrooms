import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/main_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/textformfield.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/heading_input_fields.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/inputfield_data_model.dart';
import 'package:leenas_mushrooms/view/screens/oder_details_screen/order_details_screen.dart';

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
        fieldName: 'Courier Data',
        hintText: 'Enter courier data'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: trackingStatusController,
        fieldName: 'Tracking Status',
        hintText: 'Enter tracking status')
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
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (c) => const OrderDetailspage())),
                child: CircleAvatar(
                  radius: 25.r,
                  backgroundColor: AppColors.white,
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20.h,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              w10,
              Text(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  'Order Details',
                  style: AppFonts.getAppFont(
                      context: context,
                      color: AppColors.black,
                      weight: FontWeight.w500,
                      size: 21.sp)),
            ],
          ),
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
                      Padding(
                        padding: EdgeInsets.only(top: 20.h, left: 20.w),
                        child: const HeadingRequestPage(title: 'Date'),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black.withOpacity(.30))),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              w10,
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.black.withOpacity(.30),
                              ),
                              w10,
                              Text(
                                currentDate,
                                style: AppFonts.getAppFont(
                                  color: Colors.black.withOpacity(.30),
                                  context: context,
                                  size: 14,
                                  weight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

                          return CommonTextformField(
                              fillColor: inputfields[index].fillColor,
                              maxlines: inputfields[index].maxlines,
                              hintText: inputfields[index].hintText,
                              enabled: inputfields[index].enabled == true
                                  ? true
                                  : false,
                              fieldName: inputfields[index].fieldName,
                              controller: inputfields[index].controller);
                        },
                      ),
                      h50
                    ])))),
      ]),
    );
  }
}
