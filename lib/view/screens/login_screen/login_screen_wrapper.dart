import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/view/screens/login_screen/mobile_login_page.dart';

class LoginPage extends StatelessWidget {
  static const routePath = '/login';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MobileLoginPage();
  }
}
