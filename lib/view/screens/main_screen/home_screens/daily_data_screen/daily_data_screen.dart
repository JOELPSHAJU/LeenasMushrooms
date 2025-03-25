import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      backgroundColor:
          Colors.transparent, // Transparent to allow gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F5DC), // Cream (Beige)
              Color(0xFFD4E4D2), // Light Green
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Branded Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Leena's ",
                                style: TextStyle(
                                  fontFamily:
                                      'DancingScript',
                                  fontSize: 28.sp,
                                  color:
                                      const Color(0xFF2E7D32),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Mushroom",
                                style: TextStyle(
                                  fontFamily:
                                      'Montserrat',
                                  fontSize: 28.sp,
                                  color: const Color(0xFF2E7D32),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Track Your Mushroom Growth",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14.sp,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                h20,
               
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const BarChartMainScreen(),
                ),
                h20,
                // Mushroom Card
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AddMushroomDetailsScreen(),
                    ),
                  ),
                  child: MainScreenListTile(
                    size: size,
                    image: ImagePathProvider.mushroomImageMainScreen,
                    text: 'Mushroom',
                  ),
                ),
                h20,
                // Bed Card
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AddBedDetailsScreen(),
                    ),
                  ),
                  child: MainScreenListTile(
                    size: size,
                    image: ImagePathProvider.bedImageMainScreen,
                    text: 'Bed',
                  ),
                ),
                h20,
                // Seed Card
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AddSedDetailsScreen(),
                    ),
                  ),
                  child: MainScreenListTile(
                    size: size,
                    image: ImagePathProvider.seedImageMainScreen,
                    text: 'Seed',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom + 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
