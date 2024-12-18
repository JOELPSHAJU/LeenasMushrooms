import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/color.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/drawer_imag.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        DrawerLIstTile(
            leading: const Icon(Icons.home), title: "Home", onTap: () {}),
        DrawerLIstTile(
            leading: const Icon(Icons.person_add),
            title: "Daily Data",
            onTap: () {}),

        DrawerLIstTile(
            leading: const Icon(Icons.receipt_long),
            title: "Order Details",
            onTap: () {}),

        DrawerLIstTile(
          leading: const Icon(Icons.payment),
          title: "Income/Expense",
          onTap: () {},
        ),

        // Spacer to push Logout button to the bottom
        const Spacer(),
        // const Text("Version 1.0.0", style: TextStyle()),

        FutureBuilder(
            future: rootBundle.loadString("pubspec.yaml"),
            builder: (context, snapshot) {
              String version = "Unknown";
              if (snapshot.hasData) {
                var yaml = loadYaml(snapshot.data.toString());
                version = yaml["version"];
              }

              return Text('Version: $version');
            }),
        const DividerWidget(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text(
            "Logout",
            style: TextStyle(
                fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            // Handle Logout action
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Logout",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                content: const Text("Are you sure you want to log out?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel",
                        style: TextStyle(color: AppColors.green100)),
                  ),
                  TextButton(
                    onPressed: () {
                      // Perform Logout action
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class DrawerLIstTile extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Widget leading;
  const DrawerLIstTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: leading,
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          onTap: onTap,
        ),
        const DividerWidget(),
      ],
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Divider(thickness: 1, color: Colors.grey),
    );
  }
}
