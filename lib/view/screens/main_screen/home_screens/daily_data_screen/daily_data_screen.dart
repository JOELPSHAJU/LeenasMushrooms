// DailyDataScreen.dart
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F7FA),
              Color(0xFFE8ECEF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Enhanced Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Leena's Mushrooms",
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  color: const Color(0xFF2D3748),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'PRO',
                                  style: TextStyle(
                                    color: Colors.green.shade700,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Track Your Mushroom Growth",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                h20,

                // Chart Container
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const BarChartMainScreen(),
                ),
                h20,

                // Cards with custom gradients
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
