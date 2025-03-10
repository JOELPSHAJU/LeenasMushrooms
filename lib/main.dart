import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/services/api_services.dart';
import 'package:leenas_mushrooms/view/bloc/add_call_details/add_call_details_bloc.dart';
import 'package:leenas_mushrooms/view/bloc/login_bloc/login_bloc.dart';
import 'package:leenas_mushrooms/view/screens/splash_screen/splash_screen.dart';

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
        child: RepositoryProvider(
      create: (context) => ApiService(Dio()),  
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(
              apiService: context.read<ApiService>(),
            ),
          ),
           BlocProvider(
            create: (context) => AddCallDetailsBloc(
              apiService: context.read<ApiService>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: scaffoldMessngerKey,
          home: const SplashScreen(),
        ),
      )));
  }
}
