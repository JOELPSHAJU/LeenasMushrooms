import 'package:go_router/go_router.dart';
import 'package:leenas_mushrooms/main.dart';
import 'package:leenas_mushrooms/view/screens/login_screen/login_screen_wrapper.dart';

final router = GoRouter(
    navigatorKey: MyApp.navigatorKey,
    initialLocation: LoginPage.routePath,
    routes: [
      GoRoute(
        path: LoginPage.routePath,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
    ]);
