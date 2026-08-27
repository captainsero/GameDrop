import 'package:go_router/go_router.dart';

import '../../features/error/error_view.dart';
import '../../features/games/presentation/view/games_view.dart';
import 'route_path.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.gamesRoute,
    routes: [
      GoRoute(
        path: RoutePath.gamesRoute,
        builder: (context, state) => const GamesView(),
      ),
    ],

    errorBuilder: (context, state) {
      return ErrorView(
        errorMessage: state.error?.toString() ?? 'Page not found',
      );
    },
  );
}
