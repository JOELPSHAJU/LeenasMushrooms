import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({super.key});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: const Text(
              'Order Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: const Text(
              'Income Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: const Text(
              'Expense Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: const Text(
              'Sign Out',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
