import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    // initialLocation: RoutePath.loginRoute,
    routes: [],

    //TODO: add
    // errorBuilder: (context, state) {
    //   return ErrorScreen(
    //     errorMessage: state.error?.toString() ?? 'Page not found',
    //   );
    // },
  );
}
