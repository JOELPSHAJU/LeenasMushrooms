import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/view/screens/login_screen/login_screen_wrapper.dart';

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

    const double kMobileBreakpoint = 600;
    const double kTabletBreakpoint = 1024;

    Size getDesignSize(BuildContext context) {
      double width = MediaQuery.sizeOf(context).width;
      if (width < kMobileBreakpoint) {
        return const Size(393, 852); // Mobile
      } else if (width < kTabletBreakpoint) {
        return const Size(1024, 1488); // Tablet
      } else {
        return const Size(1920, 1082); // Desktop
      }
    }

    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: false,
      designSize: getDesignSize(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessngerKey,
        home: const LoginPage(),
      ),
    );
  }
}
