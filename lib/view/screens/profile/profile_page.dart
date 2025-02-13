import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/common_appbar.dart';
import 'package:leenas_mushrooms/core/common_widgets/person_details_widget.dart';
import 'package:leenas_mushrooms/core/common_widgets/screen_route_title.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const CommonAppBar(iconNeeded: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenRouteTitle(title: 'Profile'),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: PersonDetailsWidget(
              isviewed: false,
              isProfile: true,
              name: 'name',
              phoneNumber: "+91 1234567890",
              purpose: 'purpose',
              status: 'pending',
              date: "PROFILE DETAILS",
              subHedone: 'Purpose',
              subHedoneData: "Purpose",
              subHedTwo: 'Status',
              subHedTwoData: 'Pending',
            ),
          ),
          h10,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)),
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: Text(
                        "CALL RECORDS",
                        style: AppFonts.getAppFont(
                          context: context,
                          color: AppColors.black,
                          weight: FontWeight.w400,
                          size: 19.sp,
                        ),
                      ),
                    ),
                    h10,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              color: const Color(
                                  0xFFF5F5F5), // Set the background color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12), // Inner padding
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '8:45 AM',
                                        style: AppFonts.getAppFont(
                                          context: context,
                                          color: AppColors.black,
                                          weight: FontWeight.w400,
                                          size: 16.sp,
                                        ),
                                      ),
                                      Text(
                                        '8590182736',
                                        style: AppFonts.getAppFont(
                                          context: context,
                                          color: AppColors.gray200,
                                          weight: FontWeight.w400,
                                          size: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    ' 21/12/2024',
                                    style: AppFonts.getAppFont(
                                      context: context,
                                      color: AppColors.black,
                                      weight: FontWeight.w400,
                                      size: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 3), // Separate list items
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
