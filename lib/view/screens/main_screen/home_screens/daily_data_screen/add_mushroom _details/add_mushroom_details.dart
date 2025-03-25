import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/controller/local_modals/add_mushroom_post_model.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_dropdown.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_input_fields.dart';
import 'package:leenas_mushrooms/core/common_widgets/custom_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/custom_validators.dart';
import 'package:leenas_mushrooms/core/common_widgets/date_picker.dart';
import 'package:leenas_mushrooms/core/common_widgets/main_button.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/core/common_widgets/snakbars.dart';
import 'package:leenas_mushrooms/core/common_widgets/textfield_with_quantity.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';
import 'package:leenas_mushrooms/view/bloc/bloc/add_mushroom_details_bloc.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/main_screen.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/widgets/inputfield_data_model.dart';

class AddMushroomDetailsScreen extends StatefulWidget {
  const AddMushroomDetailsScreen({super.key});

  @override
  State<AddMushroomDetailsScreen> createState() =>
      _AddMushroomDetailsScreenState();
}

class _AddMushroomDetailsScreenState extends State<AddMushroomDetailsScreen> {
  late final TextEditingController quantityController;
  late final TextEditingController damageController;
  late final TextEditingController remarksController;
  String timeController = 'Morning'; // Default value
  String dateController = DateFormat('dd/MM/yyyy').format(DateTime.now());
  late List<InputfieldsDataModel> inputfields;
  final _formKey = GlobalKey<FormState>(); // For form validation

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
          fieldName: 'Quantity',
          quantity: true,
          hintText: 'Enter quantity'),
      InputfieldsDataModel(
          maxlines: 1,
          enabled: true,
          fillColor: AppColors.white,
          prefixIcon: null,
          controller: damageController,
          fieldName: 'Damage',
          hintText: 'Enter damage'),
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
      final details = AddMushroomDetailsPostModel(
        date: dateController,
        harvestTime: timeController,
        quantity: quantityController.text,
        damage: damageController.text,
        remarks: remarksController.text,
      );

      context
          .read<AddMushroomDetailsBloc>()
          .add(AddMushroomDetailsButtonPressEvent(details: details));
    }
  }

  // Enhanced Validation Functions
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
      // Optional: Add max limit
      return 'Quantity cannot exceed 10,000';
    }
    return null;
  }

  String? _validateDamage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Damage is required';
    }
    final parsedValue = double.tryParse(value);
    if (parsedValue == null) {
      return 'Please enter a valid number';
    }
    if (parsedValue < 0) {
      return 'Damage cannot be negative';
    }
    if (parsedValue > double.parse(quantityController.text)) {
      return 'Damage cannot exceed quantity';
    }
    return null;
  }

  String? _validateRemarks(String? value) {
    if (value != null && value.length > 500) {
      // Optional: Max length for remarks
      return 'Remarks cannot exceed 500 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => AddMushroomDetailsBloc(
        repo: context.read<DataVerseRepository>(),
      ),
      child: Scaffold(
        appBar: const CommonAppBar(iconNeeded: false),
        backgroundColor: AppColors.cardcolor,
        body: BlocConsumer<AddMushroomDetailsBloc, AddMushroomDetailsState>(
          listener: (context, state) {
            if (state is AddMushroomDetailsSuccess) {
              successSnakbar(context, "Mushroom details added successfully");
              quantityController.clear();
              damageController.clear();
              remarksController.clear();
              setState(() {
                dateController =
                    DateFormat('dd/MM/yyyy').format(DateTime.now());
                timeController = 'Morning';
              });
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(builder: (context) => MainScreen()),
              );
            } else if (state is AddMushroomDetailsFailure) {
              failedSnakbar(context, "Failed to add details: ${state.message}");
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  ScreenRouteTitle(
                    title: 'Add Mushroom Details',
                    action: () => Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (C) => MainScreen()),
                    ),
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
                                    child: BlocBuilder<AddMushroomDetailsBloc,
                                        AddMushroomDetailsState>(
                                      builder: (context, state) {
                                        if (state
                                            is AddMushroomDetailsLoading) {
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
                                        fillColor: inputfields[index].fillColor,
                                        validator: _validateQuantity,
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
                                                'Damage'
                                            ? _validateDamage
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
