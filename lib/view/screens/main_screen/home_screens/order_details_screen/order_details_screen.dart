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

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String currentDate = "";
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final pinCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final catalogueController = TextEditingController();
  final quantityController = TextEditingController();
  final courierDataController = TextEditingController();
  final trackingStatusController = TextEditingController();

  List<InputfieldsDataModel> inputFields = [];

  @override
  void initState() {
    currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    inputFields = [
      InputfieldsDataModel(
          maxlines: 1,
          enabled: true,
          fillColor: AppColors.white,
          // prefixIcon: Icons.person,
          controller: nameController,
          fieldName: 'Name',
          hintText: 'Enter name'),
      InputfieldsDataModel(
          maxlines: 1,
          enabled: true,
          fillColor: AppColors.white,
          // prefixIcon: Icons.location_on,
          controller: addressController,
          fieldName: 'Address',
          hintText: 'Enter address'),
      InputfieldsDataModel(
          maxlines: 1,
          enabled: true,
          fillColor: AppColors.white,
          // prefixIcon: Icons.pin_drop,
          controller: pinCodeController,
          fieldName: 'Pin code',
          hintText: 'Enter pincode'),
      InputfieldsDataModel(
          maxlines: 1,
          enabled: true,
          fillColor: AppColors.white,
          // prefixIcon: Icons.phone,
          controller: phoneNumberController,
          fieldName: 'Phone Number',
          hintText: 'Enter phone number'),
      InputfieldsDataModel(
          maxlines: 1,
          enabled: true,
          fillColor: AppColors.white,
          // prefixIcon: Icons.shopping_cart,
          controller: catalogueController,
          fieldName: 'Catalogue',
          hintText: 'Item catalogue'),
      InputfieldsDataModel(
          maxlines: 1,
          enabled: true,
          fillColor: AppColors.white,
          // prefixIcon: Icons.format_list_numbered,
          controller: quantityController,
          fieldName: 'Quantity',
          hintText: 'Quantity'),
      InputfieldsDataModel(
          maxlines: 1,
          enabled: true,
          fillColor: AppColors.white,
          // prefixIcon: Icons.local_shipping,
          controller: courierDataController,
          fieldName: 'Courier Data',
          hintText: 'Courier data'),
      InputfieldsDataModel(
          maxlines: 1,
          enabled: true,
          fillColor: AppColors.white,
          // prefixIcon: Icons.location_on_outlined,
          controller: trackingStatusController,
          fieldName: 'Tracking Status',
          hintText: 'Tracking status'),
    ];
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
              CircleAvatar(
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
              w10,
              Text(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  'Add Order Details',
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
                      Column(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: inputFields.length + 1,
                            itemBuilder: (context, index) {
                              if (index == inputFields.length) {
                                return const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child:
                                        MainButton(buttonText: 'Add Details'));
                              }
                              return CommonTextformField(
                                  fillColor: inputFields[index].fillColor,
                                  maxlines: inputFields[index].maxlines,
                                  hintText: inputFields[index].hintText,
                                  enabled: inputFields[index].enabled == true
                                      ? true
                                      : false,
                                  // prefixIcon: inputFields[index].prefixIcon,
                                  fieldName: inputFields[index].fieldName,
                                  controller: inputFields[index].controller);
                            },
                          ),
                        ],
                      ),
                    ]))))
      ]),
    );
  }
}
