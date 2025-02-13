import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_input_fields.dart';
import 'package:leenas_mushrooms/core/common_widgets/date_picker.dart';
import 'package:leenas_mushrooms/core/common_widgets/main_button.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/heading_input_fields.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/inputfield_data_model.dart';

class IncomeExpenseScreen extends StatefulWidget {
  const IncomeExpenseScreen({super.key});

  @override
  State<IncomeExpenseScreen> createState() => _IncomeExpenseScreenState();
}

final incomeUserdetailsController = TextEditingController();
final expenseTypeController = TextEditingController();
final expenseAmountController = TextEditingController();
final expenseUserdetailsController = TextEditingController();
final sourceController = TextEditingController();
final incomeAmountController = TextEditingController();
bool isIncome = true;
String dateController ="";


class _IncomeExpenseScreenState extends State<IncomeExpenseScreen> {
  String currentDate = "";
  List<InputfieldsDataModel> incomeInputFields = [
    InputfieldsDataModel(
        maxlines: 3,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: incomeUserdetailsController,
        fieldName: 'User Details',
        hintText: 'Enter user details'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: sourceController,
        fieldName: 'Source',
        hintText: 'Enter source'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: incomeAmountController,
        fieldName: 'Amount',
        hintText: 'Enter amount'),
  ];
  List<InputfieldsDataModel> expenseInputFields = [
    InputfieldsDataModel(
        maxlines: 3,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: expenseTypeController,
        fieldName: 'User Details',
        hintText: 'Enter user details'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: expenseAmountController,
        fieldName: 'Expense Type',
        hintText: 'Enter expense type'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: expenseAmountController,
        fieldName: 'Amount',
        hintText: 'Enter amount'),
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
              CircleAvatar(
                radius: 25.r,
                backgroundColor: AppColors.white,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                  'Income & Expense Details',
                  style: AppFonts.getAppFont(
                      context: context,
                      color: AppColors.black,
                      weight: FontWeight.w500,
                      size: 21.sp)),
            ],
          ),
        ),
        isIncome
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColors.white,
                    ),
                    height: 55.h,
                    width: size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 53.h,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColors.black,
                          ),
                          child: Center(
                            child: Text(
                              'Income',
                              style: AppFonts.getAppFont(
                                color: AppColors.white,
                                context: context,
                                size: 14,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isIncome = false;
                                });
                              },
                              child: Text(
                                'Expense',
                                style: AppFonts.getAppFont(
                                  color: AppColors.black,
                                  context: context,
                                  size: 14,
                                  weight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColors.white,
                    ),
                    height: 55.h,
                    width: size.width * 0.8, // Adjust width dynamically
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isIncome = true;
                                });
                              },
                              child: Text(
                                'Income',
                                style: AppFonts.getAppFont(
                                  color: AppColors.black,
                                  context: context,
                                  size: 14,
                                  weight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 53.h,
                          width: size.width *
                              0.4, // Adjust the expense button width
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColors.black,
                          ),
                          child: Center(
                            child: Text(
                              'Expense',
                              style: AppFonts.getAppFont(
                                color: AppColors.white,
                                context: context,
                                size: 14,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        h20,
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
                          hint: currentDate,
                          startDateHeading: 'Date',
                          selectedItem: dateController),
                           CommonDropdown(
                          results: expenseTypeController.text,
                          fieldName: "Expense Type",
                          hintText: 'Select expense type',
                          options: const ["Petrol", "Saw Dust","Salary","Maintenence","Courier Charge","Electricity","EMI","PP","Maze","Water Charges","Wrap","Tray","Husk","Bran"]),
                     
                      isIncome
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: incomeInputFields.length + 1,
                              itemBuilder: (context, index) {
                                if (index == incomeInputFields.length) {
                                  return const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: MainButton(
                                          buttonText: 'Add Details'));
                                }

                                return CommonTextformField(
                                    fillColor:
                                        incomeInputFields[index].fillColor,
                                    maxlines: incomeInputFields[index].maxlines,
                                    hintText: incomeInputFields[index].hintText,
                                    enabled:
                                        incomeInputFields[index].enabled == true
                                            ? true
                                            : false,
                                    fieldName:
                                        incomeInputFields[index].fieldName,
                                    controller:
                                        incomeInputFields[index].controller);
                              },
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: expenseInputFields.length + 1,
                              itemBuilder: (context, index) {
                                if (index == incomeInputFields.length) {
                                  return const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: MainButton(
                                          buttonText: 'Add Details'));
                                }
                                return CommonTextformField(
                                    fillColor:
                                        expenseInputFields[index].fillColor,
                                    maxlines:
                                        expenseInputFields[index].maxlines,
                                    hintText:
                                        expenseInputFields[index].hintText,
                                    enabled:
                                        expenseInputFields[index].enabled ==
                                                true
                                            ? true
                                            : false,
                                    fieldName:
                                        expenseInputFields[index].fieldName,
                                    controller:
                                        expenseInputFields[index].controller);
                              },
                            ),
                      h10,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.black, // Button background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                              ),
                            ),
                            onPressed: () {
                              // Handle button press
                              if (isIncome) {
                                print("Income details submitted");
                                // Add your submission logic here
                              } else {
                                print("Expense details submitted");
                                // Add your submission logic here
                              }
                            },
                            child: Text(
                              'Submit',
                              style: AppFonts.getAppFont(
                                context: context,
                                color: AppColors.white, // Button text color
                                size: 16,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])))),
      ]),
    );
  }
}
