import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';

class PersonDetailsWidget extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String purpose;
  final String status;
  final String subHedTwo;
  final String subHedoneData;
  final bool isviewed;
  final bool isProfile; // New property to determine profile context
  final String date;
  final String subHedone;
  final String subHedTwoData;
  final void Function()? viewOnPressed;
  final void Function()? editOnPressed;
  final void Function()? deleteOnPressed;

  const PersonDetailsWidget({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.purpose,
    required this.status,
    required this.date,
    required this.subHedone,
    required this.subHedTwo,
    required this.subHedTwoData,
    required this.subHedoneData,
    required this.isviewed,
    this.isProfile = false, // Default to false
    this.viewOnPressed,
    this.editOnPressed,
    this.deleteOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF3F3F3), // Set card background color
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        width: double.infinity,
        height: isProfile ? 200 : 248,
        child: Column(
          children: [
            // Date Section
            SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Divider(thickness: 1, color: Colors.white),

            // Details Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.gray200,
                              ),
                            ),
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              subHedone,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.gray200,
                              ),
                            ),
                            Text(
                              subHedoneData,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),

                        // Right Column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Phone",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.gray200,
                              ),
                            ),
                            Text(
                              phoneNumber,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              subHedTwo,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.gray200,
                              ),
                            ),
                            Text(
                              subHedTwoData,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (!isProfile) const Divider(thickness: 1, color: Colors.white),

            // Action Buttons Section
            if (!isProfile)
              isviewed
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: viewOnPressed,
                          icon: const Icon(
                            Icons.visibility,
                            color: AppColors.green100,
                          ),
                          label: const Text(
                            "VIEW DETAILS",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.green100,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: editOnPressed,
                          icon: const Icon(
                            Icons.edit,
                            color: AppColors.green100,
                          ),
                          label: const Text(
                            "EDIT DETAILS",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.green100,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: deleteOnPressed,
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          label: const Text(
                            "DELETE DETAILS",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
          ],
        ),
      ),
    );
  }
}
