import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leenas_mushrooms/core/common_widgets/person_details_widget.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';
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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: AppColors.black),
        centerTitle: true,
        title: loadAssetPic(ImagePathProvider.logoletters, height: 40),
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: const Color.fromARGB(255, 224, 224, 224),
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
                  'Profile',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.getAppFont(
                    context: context,
                    color: AppColors.black,
                    weight: FontWeight.w500,
                    size: 21.sp,
                  ),
                ),
              ],
            ),
          ),
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
          h30,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color:
                          const Color(0xFFF5F5F5), // Set the background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12), // Inner padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
        ],
      ),
    );
  }
}
