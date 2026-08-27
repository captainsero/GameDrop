import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/di/di.dart';
import '../../features/error/error_view.dart';
import '../../features/games/presentation/view/games_view.dart';
import '../../features/games/presentation/view_model/games_event.dart';
import '../../features/games/presentation/view_model/games_view_model.dart';
import 'route_path.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.gamesRoute,
    routes: [
      GoRoute(
        path: RoutePath.gamesRoute,
        builder: (context, state) => BlocProvider(
          create: (_) {
            final vm = getIt<GamesViewModel>();
            unawaited(vm.onEvent(GetUpcomingGamesEvent(page: 1)));
            return vm;
          },
          child: const GamesView(),
        ),
      ),
    ],

    errorBuilder: (context, state) {
      return ErrorView(
        errorMessage: state.error?.toString() ?? 'Page not found',
      );
    },
  );
}
