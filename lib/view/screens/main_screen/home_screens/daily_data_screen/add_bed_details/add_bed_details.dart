import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_dropdown.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_input_fields.dart';
import 'package:leenas_mushrooms/core/common_widgets/custom_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/date_picker.dart';
import 'package:leenas_mushrooms/core/common_widgets/main_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/core/common_widgets/snakbars.dart';
import 'package:leenas_mushrooms/core/common_widgets/textfield_with_quantity.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';
import 'package:leenas_mushrooms/view/bloc/add_bed_details/add_bed_details_bloc.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/main_screen.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/inputfield_data_model.dart';
import 'package:leenas_mushrooms/controller/local_modals/add_bed_details_post_model.dart';

class AddBedDetailsScreen extends StatefulWidget {
  const AddBedDetailsScreen({super.key});

  @override
  State<AddBedDetailsScreen> createState() => _AddBedDetailsScreenState();
}

class _AddBedDetailsScreenState extends State<AddBedDetailsScreen> {
  late final TextEditingController quantityController;
  late final TextEditingController damageController;
  late final TextEditingController remarksController;
  String timeController = 'Morning'; // Default value
  String dateController =
      DateFormat('dd/MM/yyyy').format(DateTime.now()); // Initial date format
  late List<InputfieldsDataModel> inputfields;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    quantityController = TextEditingController();
    damageController = TextEditingController();
    remarksController = TextEditingController();

    inputfields = [
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
  }

  @override
  void dispose() {
    quantityController.dispose();
    damageController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  void _submitDetails(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final details = AddBedDetailsPostModel(
        date: dateController,
        harvestTime: timeController,
        quantity: quantityController.text,
        noOfPackets: damageController.text,
        remarks: remarksController.text,
      );

      context
          .read<AddBedDetailsBloc>()
          .add(AddBedDetailsButtonPressEvent(details: details));
    }
  }

  // Validation functions
  String? _validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter quantity';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    if (double.parse(value) <= 0) {
      return 'Quantity must be greater than 0';
    }
    return null;
  }

  String? _validatePackets(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter number of packets';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    if (int.parse(value) < 0) {
      return 'Number of packets cannot be negative';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) =>
          AddBedDetailsBloc(repo: context.read<DataVerseRepository>()),
      child: Scaffold(
        appBar: const CommonAppBar(iconNeeded: false),
        backgroundColor: AppColors.cardcolor,
        body: BlocConsumer<AddBedDetailsBloc, AddBedDetailsState>(
          listener: (context, state) {
            if (state is AddBedDetailsSuccess) {
              successSnakbar(context, "Bed details added successfully");
              quantityController.clear();
              damageController.clear();
              remarksController.clear();
              setState(() {
                dateController =
                    DateFormat('dd/MM/yyyy').format(DateTime.now());
                timeController = 'Morning';
              });
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => MainScreen()));
            } else if (state is AddBedDetailsFailure) {
              failedSnakbar(context, "Failed to add details: ${state.message}");
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  ScreenRouteTitle(
                    title: 'Add Bed Details',
                    action: () => Navigator.pushReplacement(context,
                        CupertinoPageRoute(builder: (C) => MainScreen())),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      width: size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonDatePicker(
                              onDateChanged: (value) {
                                setState(() {
                                  dateController = DateFormat('dd/MM/yyyy')
                                      .format(DateTime.parse(value));
                                });
                              },
                              hint: dateController,
                              startDateHeading: 'Date',
                              selectedItem: dateController,
                            ),
                            CommonDropdown(
                              onChanged: (value) {
                                setState(() {
                                  timeController = value;
                                });
                              },
                              results: timeController,
                              fieldName: 'Harvest Time',
                              hintText: 'Select harvest time',
                              options: const ['Morning', 'Evening'],
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: inputfields.length + 1,
                              itemBuilder: (context, index) {
                                if (index == inputfields.length) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: BlocBuilder<AddBedDetailsBloc,
                                        AddBedDetailsState>(
                                      builder: (context, state) {
                                        if (state is AddBedDetailsLoading) {
                                          return loadingButton(
                                            media: size,
                                            onPressed: () {},
                                            color: AppColors.black,
                                          );
                                        }
                                        return MainButton(
                                          buttonText: 'Add Details',
                                          onPressed: () =>
                                              _submitDetails(context),
                                        );
                                      },
                                    ),
                                  );
                                }

                                return inputfields[index].quantity == true
                                    ? TextfieldWithQuantity(
                                        validator: _validateQuantity,
                                        fillColor: inputfields[index].fillColor,
                                        maxlines: inputfields[index].maxlines,
                                        hintText: inputfields[index].hintText,
                                        enabled:
                                            inputfields[index].enabled == true,
                                        fieldName: inputfields[index].fieldName,
                                        controller:
                                            inputfields[index].controller,
                                      )
                                    : CommonTextformField(
                                        validator:
                                            inputfields[index].fieldName ==
                                                    'No. Of Packets'
                                                ? _validatePackets
                                                : null,
                                        fillColor: inputfields[index].fillColor,
                                        maxlines: inputfields[index].maxlines,
                                        isRemarkNeed:
                                            inputfields[index].isRemarkNeed,
                                        hintText: inputfields[index].hintText,
                                        enabled:
                                            inputfields[index].enabled == true,
                                        fieldName: inputfields[index].fieldName,
                                        controller:
                                            inputfields[index].controller,
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
