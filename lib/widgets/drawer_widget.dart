import 'package:flutter/material.dart';

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
        ListTile(
          leading: const Icon(Icons.person_add_alt_1),
          title: const Text("Daily Data"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: () {},
        ),
      ],
    );
  }
}
