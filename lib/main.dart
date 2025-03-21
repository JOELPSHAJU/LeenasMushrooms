import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';
import 'package:leenas_mushrooms/services/client/dio_client.dart';
import 'package:leenas_mushrooms/services/dataverse_repository.dart';
import 'package:leenas_mushrooms/services/rest_client.dart';
import 'package:leenas_mushrooms/view/bloc/call_details/call_details_bloc.dart';
import 'package:leenas_mushrooms/view/bloc/income_expense/income_expense_bloc.dart';
import 'package:leenas_mushrooms/view/bloc/login_bloc/login_bloc.dart';
import 'package:leenas_mushrooms/view/bloc/order_details/order_details_bloc.dart';
import 'package:leenas_mushrooms/view/screens/login_screen/login_screen_wrapper.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/main_screen.dart';
import 'package:leenas_mushrooms/view/screens/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<bool> isLoggedIn = ValueNotifier(false);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Dio dio = getDioClient();

  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  final Dio dio;
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  const MyApp({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
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
        create: (context) => DataVerseRepository(
          client: RestClient(dio),
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginBloc(
                repo: context.read<DataVerseRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => CallDetailsBloc(
                repo: context.read<DataVerseRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => OrderDetailsBloc(
                repo: context.read<DataVerseRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => IncomeExpenseBloc(
                repo: context.read<DataVerseRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: scaffoldMessengerKey,
            home: const AuthWrapper(),
          ),
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _checkToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        if (snapshot.hasData && snapshot.data != null) {
          return MainScreen();
        }
        return const LoginPage();
      },
    );
  }

  Future<String?> _checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
