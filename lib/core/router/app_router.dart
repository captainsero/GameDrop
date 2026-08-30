import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/di/di.dart';
import '../../features/error/error_view.dart';
import '../../features/game_details/presentation/view/game_details_view.dart';
import '../../features/game_details/presentation/view_model/game_details_event.dart';
import '../../features/game_details/presentation/view_model/game_details_view_model.dart';
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
      GoRoute(
        path: '${RoutePath.gameDetailsRoute}/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return BlocProvider(
            create: (_) {
              final vm = getIt<GameDetailsViewModel>();
              unawaited(vm.onEvent(GetGameDetailEvent(id: id)));
              return vm;
            },
            child: GameDetailsView(gameId: id),
          );
        },
      ),
    ],

    errorBuilder: (context, state) {
      return ErrorView(
        errorMessage: state.error?.toString() ?? 'Page not found',
      );
    },
  );
}
