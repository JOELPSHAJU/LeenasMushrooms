import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leenas_mushrooms/core/router/router.dart';
import 'package:leenas_mushrooms/view/login_page.dart';
import 'package:leenas_mushrooms/widgets/bottom_nav_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the preferred orientation to portrait up
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessngerKey = GlobalKey<ScaffoldMessengerState>();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,
    //   scaffoldMessengerKey: scaffoldMessngerKey,
    //   routerConfig: router,
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessngerKey,
      home: const LoginPage(),
    );
  }
}
