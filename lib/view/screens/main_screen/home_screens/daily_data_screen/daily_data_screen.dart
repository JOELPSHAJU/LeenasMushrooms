import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
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
            // BarChartMainScreen(),
            h20,
            MainScreenListTile(
              size: size,
              image: ImagePathProvider.mushroomImageMainScreen,
              text: 'Mushrooom',
            ),
            h20,
            MainScreenListTile(
              size: size,
              image: ImagePathProvider.bedImageMainScreen,
              text: 'Bed',
            ),
            h20,
            MainScreenListTile(
              size: size,
              image: ImagePathProvider.seedImageMainScreen,
              text: 'Seed',
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
