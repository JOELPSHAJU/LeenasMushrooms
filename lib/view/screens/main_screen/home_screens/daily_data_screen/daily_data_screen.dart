import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/daily_data_screen/add_bed_details/add_bed_details.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/daily_data_screen/add_mushroom%20_details/add_mushroom_details.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/daily_data_screen/add_seed_details/add_seed_details.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/daily_data_screen/widgets/barchart_main_screen.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/daily_data_screen/widgets/main_screen_tiles.dart';

class DailyDataScreen extends StatelessWidget {
  const DailyDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            h20,
            // ignore: prefer_const_constructors
            BarChartMainScreen(),
            h20,
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const AddMushroomDetailsScreen()),
              ),
              child: MainScreenListTile(
                size: size,
                image: ImagePathProvider.mushroomImageMainScreen,
                text: 'Mushrooom',
              ),
            ),
            h20,
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const AddBedDetailsScreen()),
              ),
              child: MainScreenListTile(
                size: size,
                image: ImagePathProvider.bedImageMainScreen,
                text: 'Bed',
              ),
            ),
            h20,
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const AddSedDetailsScreen()),
              ),
              child: MainScreenListTile(
                size: size,
                image: ImagePathProvider.seedImageMainScreen,
                text: 'Seed',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + 30.h,
            )
          ],
        ),
      ),
    );
  }
}
