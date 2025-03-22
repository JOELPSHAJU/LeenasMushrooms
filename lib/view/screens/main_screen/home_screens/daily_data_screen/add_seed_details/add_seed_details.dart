import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/controller/local_modals/sed_details_post_post_model.dart';
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
import 'package:leenas_mushrooms/view/bloc/seed_details/seed_details_bloc.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/inputfield_data_model.dart';

class AddSedDetailsScreen extends StatefulWidget {
  const AddSedDetailsScreen({super.key});

  @override
  State<AddSedDetailsScreen> createState() => _AddSedDetailsScreenState();
}

class _AddSedDetailsScreenState extends State<AddSedDetailsScreen> {
  late final TextEditingController quantityController;
  late final TextEditingController damageController;
  late final TextEditingController remarksController;
  String timeController = 'Morning'; // Default value
  String dateController = DateFormat('MM/dd/yyyy').format(DateTime.now());
  late List<InputfieldsDataModel> inputfields;
  final _formKey = GlobalKey<FormState>(); // Added for form validation

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
          controller: quantityController,
          quantity: true,
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
      final details = SedHarvestDetailsPostModel(
        date: dateController,
        harvestTime: timeController,
        quantity: quantityController.text,
        noOfPackets: damageController.text,
        remarks: remarksController.text,
      );

      context
          .read<SeedDetailsBloc>()
          .add(SeedDetailsButtonPressEvent(details: details));
    }
  }

  // Validation Functions
  String? _validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Quantity is required';
    }
    final parsedValue = double.tryParse(value);
    if (parsedValue == null) {
      return 'Please enter a valid number';
    }
    if (parsedValue <= 0) {
      return 'Quantity must be greater than 0';
    }
    if (parsedValue > 10000) {
      // Optional max limit
      return 'Quantity cannot exceed 10,000';
    }
    return null;
  }

  String? _validateNoOfPackets(String? value) {
    if (value == null || value.isEmpty) {
      return 'Number of packets is required';
    }
    final parsedValue = int.tryParse(value);
    if (parsedValue == null) {
      return 'Please enter a valid integer';
    }
    if (parsedValue < 0) {
      return 'Number of packets cannot be negative';
    }
    if (parsedValue > 1000) {
      // Optional max limit
      return 'Number of packets cannot exceed 1,000';
    }
    return null;
  }

  String? _validateRemarks(String? value) {
    if (value != null && value.length > 500) {
      // Optional max length
      return 'Remarks cannot exceed 500 characters';
    }
    return null; // Remarks can be optional
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) =>
          SeedDetailsBloc(repo: context.read<DataVerseRepository>()),
      child: Scaffold(
        appBar: const CommonAppBar(iconNeeded: false),
        backgroundColor: AppColors.cardcolor,
        body: BlocConsumer<SeedDetailsBloc, SeedDetailsState>(
          listener: (context, state) {
            if (state is SeedDetailsSuccess) {
              successSnakbar(context, "Details added successfully");
              quantityController.clear();
              damageController.clear();
              remarksController.clear();
              setState(() {
                dateController =
                    DateFormat('MM/dd/yyyy').format(DateTime.now());
                timeController = 'Morning';
              });
              Navigator.pop(context);
            } else if (state is SeedDetailsFailure) {
              failedSnakbar(context, "Failed to add details: ${state.message}");
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  ScreenRouteTitle(title: 'Add Seed Details'),
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
                                  dateController = DateFormat('MM/dd/yyyy')
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
                              fieldName: "Harvest Time",
                              hintText: 'Select harvest time',
                              options: const ["Morning", "Evening"],
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
                                    child: BlocBuilder<SeedDetailsBloc,
                                        SeedDetailsState>(
                                      builder: (context, state) {
                                        if (state is SeedDetailsLoading) {
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
                                        fillColor: inputfields[index].fillColor,
                                        maxlines: inputfields[index].maxlines,
                                        hintText: inputfields[index].hintText,
                                        isRemarkNeed:
                                            inputfields[index].isRemarkNeed,
                                        enabled:
                                            inputfields[index].enabled == true,
                                        fieldName: inputfields[index].fieldName,
                                        controller:
                                            inputfields[index].controller,
                                        validator: inputfields[index]
                                                    .fieldName ==
                                                'No. Of Packets'
                                            ? _validateNoOfPackets
                                            : (inputfields[index].fieldName ==
                                                    'Remarks'
                                                ? _validateRemarks
                                                : null),
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
