import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/bloc/login_bloc/login_bloc.dart';
import 'package:leenas_mushrooms/view/screens/call_details_page/call_details_page.dart';
import 'package:leenas_mushrooms/view/screens/expense_detail_page/expense_detail_page.dart';
import 'package:leenas_mushrooms/view/screens/income_detail_page/income_detail_page.dart';
import 'package:leenas_mushrooms/view/screens/login_screen/login_screen_wrapper.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/order_details_screen/order_details_screen.dart';
import 'package:leenas_mushrooms/view/screens/show_harvest_details/bed_harvest/bed_harvest_details.dart';
import 'package:leenas_mushrooms/view/screens/show_harvest_details/mushroom_harvest/mushroom_harvest_details.dart';
import 'package:leenas_mushrooms/view/screens/show_harvest_details/seed_harvest/seed_harvest_details.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({super.key});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: const Text(
                'Leenas Mushrooms',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text(
                'leenas@gmail.com',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              decoration: const BoxDecoration(
                  color: AppColors.black,
                  image: DecorationImage(
                      image: AssetImage(
                        ImagePathProvider.drawerBackground,
                      ),
                      fit: BoxFit.cover)),
              currentAccountPicture: loadAssetPic(
                ImagePathProvider.logoletters,
              )),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: const Text(
              'Call Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // CallDetailsPage

              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const CallDetailsPage()),
              );
            },
          ),
          Divider(
            color: AppColors.grey300,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: const Text(
              'Order Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const OrderDetailsScreen()),
              );
            },
          ),
          Divider(
            color: AppColors.grey300,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: const Text(
              'Income Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const IncomeDetailPage()),
              );
            },
          ),
          Divider(
            color: AppColors.grey300,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: const Text(
              'Expense Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const ExpanseDetailPage()),
              );
            },
          ),
          Divider(
            color: AppColors.grey300,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: const Text(
              'Mushroom Harvest Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const MushroomHarvestDetails()),
              );
            },
          ),
          Divider(
            color: AppColors.grey300,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: const Text(
              'Bed Harvest Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const BedHarvestDetails()),
              );
            },
          ),
          Divider(
            color: AppColors.grey300,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: const Text(
              'Seed Harvest Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const SeedHarvestDetails()),
              );
            },
          ),
          Divider(
            color: AppColors.grey300,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: const Text(
              'Sign Out',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }
}

void showLogoutDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        title: Text(
          "Log Out?",
          style: AppFonts.getAppFont(
            size: 20.sp,
            context: context,
            color: AppColors.black,
            weight: FontWeight.w500,
          ),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: AppFonts.getAppFont(
            size: 16.sp,
            context: context,
            color: AppColors.black,
            weight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Cancel",
              style: AppFonts.getAppFont(
                size: 14.sp,
                context: context,
                color: AppColors.primaryColor,
                weight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<LoginBloc>().add(LogoutEvent());
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Log Out",
              style: AppFonts.getAppFont(
                size: 14.sp,
                context: context,
                color: AppColors.white,
                weight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
}
