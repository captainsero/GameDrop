import 'package:go_router/go_router.dart';

import '../../features/error/error_view.dart';
import 'route_path.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.splashRoute,
    routes: [],

    errorBuilder: (context, state) {
      return ErrorView(
        errorMessage: state.error?.toString() ?? 'Page not found',
      );
    },
  );
}
