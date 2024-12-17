import 'package:go_router/go_router.dart';
import 'package:leenas_mushrooms/main.dart';
import 'package:leenas_mushrooms/view/login_page.dart';

final router = GoRouter(
    // navigatorKey: MyApp.navigatorKey,
    initialLocation: LoginPage.routePath,
    routes: [
      GoRoute(
        path: LoginPage.routePath,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
    ]);
