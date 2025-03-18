import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/controller/local_modals/call_details_post_model.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_dropdown.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_input_fields.dart';
import 'package:leenas_mushrooms/core/common_widgets/custom_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/custom_validators.dart';
import 'package:leenas_mushrooms/core/common_widgets/date_picker.dart';
import 'package:leenas_mushrooms/core/common_widgets/main_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/core/common_widgets/snakbars.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/bloc/add_call_details/add_call_details_bloc.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/main_screen.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/inputfield_data_model.dart';

class CallDetailsScreen extends StatefulWidget {
  const CallDetailsScreen({super.key});

  @override
  State<CallDetailsScreen> createState() => _CallDetailsScreenState();
}

final nameController = TextEditingController();
final phoneNumberController = TextEditingController();
final purposeController = TextEditingController();
final addCallDetailsFormKey = GlobalKey<FormState>();
final currentStatusController = TextEditingController();
String dateController = "";
String callTypeController = '';

class _CallDetailsScreenState extends State<CallDetailsScreen> {
  String currentDate = "";
  String selectedCustomerType = '';

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
        controller: purposeController,
        fieldName: 'Purpose',
        hintText: 'Enter purpose'),
    InputfieldsDataModel(
        maxlines: 1,
        enabled: true,
        fillColor: AppColors.white,
        prefixIcon: null,
        controller: currentStatusController,
        fieldName: 'Current status',
        hintText: 'Enter current status')
  ];

  @override
  void initState() {
    currentDate = DateFormat('MM/dd/yyyy').format(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<AddCallDetailsBloc, AddCallDetailsState>(
      listener: (context, state) {
        if (state is AddCallDetailsSuccess) {
          successSnakbar(context, "Call Details added Sucessfully");
          currentDate = DateFormat('MM/dd/yyyy').format(DateTime.now());
          selectedCustomerType = '';
          nameController.text = "";
          phoneNumberController.text = "";
          purposeController.text = "";
          currentStatusController.text = "";
          dateController = "";
          callTypeController = '';
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.cardcolor,
        body: Column(children: [
          ScreenRouteTitle(
            title: 'Call Details',
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
                      child: Form(
                    key: addCallDetailsFormKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonDatePicker(
                              onDateChanged: (value) {
                                dateController = value;
                              },
                              hint: currentDate,
                              startDateHeading: 'Date',
                              selectedItem: dateController),
                          CommonDropdown(
                              onChanged: (value) {
                                callTypeController = value;
                              },
                              results: callTypeController,
                              fieldName: "Call Type",
                              hintText: 'Select call type',
                              options: const [
                                "Seed Customer",
                                "Bed Customer",
                                "Farm Consultancy Customer",
                                "Need Callback (office)",
                                "Need Callback (Jithu)"
                              ]),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: inputfields.length + 1,
                            itemBuilder: (context, index) {
                              if (index == inputfields.length) {
                                return Column(
                                  children: [
                                    h20,
                                    BlocBuilder<AddCallDetailsBloc,
                                            AddCallDetailsState>(
                                        builder: (context, state) {
                                      if (state is AddCallDetailsLoading) {
                                        return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: loadingButton(
                                                media: size,
                                                onPressed: () {},
                                                color: AppColors.black));
                                      }
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        child: GestureDetector(
                                            onTap: () {
                                              if (addCallDetailsFormKey
                                                  .currentState!
                                                  .validate()) {
                                                final data = CallDetailsPostModel(
                                                    date: dateController
                                                            .isNotEmpty
                                                        ? dateController
                                                        : currentDate,
                                                    callType:
                                                        callTypeController,
                                                    name: nameController.text,
                                                    phoneNumber:
                                                        phoneNumberController
                                                            .text,
                                                    purpose:
                                                        purposeController.text,
                                                    currentStatus:
                                                        currentStatusController
                                                            .text);
                                                context
                                                    .read<AddCallDetailsBloc>()
                                                    .add(
                                                        AddCallDetailsButtonPressEvent(
                                                            details: data));
                                                successSnakbar(
                                                  context,
                                                  "Form Submitted Sucessfully",
                                                );
                                              } else {
                                                warningSnakbar(
                                                  context,
                                                  "Please fill the fields",
                                                );
                                              }
                                            },
                                            child: const MainButton(
                                                buttonText: 'Add details')),
                                      );
                                    }),
                                    h20,
                                  ],
                                );
                              }

                              return CommonTextformField(
                                  fillColor: inputfields[index].fillColor,
                                  maxlines: inputfields[index].maxlines,
                                  hintText: inputfields[index].hintText,
                                  validator: validateNotNull,
                                  enabled: inputfields[index].enabled == true
                                      ? true
                                      : false,
                                  fieldName: inputfields[index].fieldName,
                                  controller: inputfields[index].controller);
                            },
                          ),
                        ]),
                  ))))
        ]),
      ),
    );
  }
}
