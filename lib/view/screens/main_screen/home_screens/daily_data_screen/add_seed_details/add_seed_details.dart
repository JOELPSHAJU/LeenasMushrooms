import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/main_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/textformfield.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/heading_input_fields.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/inputfield_data_model.dart';

class AddSeedDetailsScreen extends StatefulWidget {
  const AddSeedDetailsScreen({super.key});

  @override
  State<AddSeedDetailsScreen> createState() => _AddSeedDetailsScreenState();
}

final quantityController = TextEditingController();
final damageController = TextEditingController();
final remarksController = TextEditingController();

class _AddSeedDetailsScreenState extends State<AddSeedDetailsScreen> {
  String selectedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  String selectedHarvestTime = 'Morning';

  List<InputfieldsDataModel> inputfields = [
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: quantityController,
        fieldName: 'Quantity',
        hintText: 'Enter quantity(Kg)'),
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
        controller: remarksController,
        fieldName: 'Remarks',
        hintText: 'Enter remarks'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: AppColors.black),
        centerTitle: true,
        title: loadAssetPic(ImagePathProvider.logoletters, height: 40),
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
      ),
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
                  'Seed',
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
                                selectedDate,
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
                      // Harvest Time Selection
                      Padding(
                        padding: EdgeInsets.only(top: 20.h, left: 20.w),
                        child: const HeadingRequestPage(title: 'Harvest Time'),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
                        child: Column(
                          children: [
                            w40,
                            DropdownButtonFormField<String>(
                              value: selectedHarvestTime,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(
                                        0.3), // Default border color
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(
                                        0.3), // Border color after selection
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(
                                        0.3), // Border color when enabled
                                  ),
                                ),
                              ),
                              dropdownColor: Colors
                                  .white, // Pure white background for the dropdown
                              style: const TextStyle(
                                color:
                                    Color(0xFFA2A2A2), // Consistent text color
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Morning',
                                  child: Text(
                                    'Morning',
                                    style: TextStyle(
                                        color: Color(
                                            0xFFA2A2A2)), // Same text color in dropdown
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Evening',
                                  child: Text(
                                    'Evening',
                                    style: TextStyle(
                                        color: Color(
                                            0xFFA2A2A2)), // Same text color in dropdown
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedHarvestTime = value!;
                                });
                              },
                            )
                          ],
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
                    ]))))
      ]),
    );
  }
}
