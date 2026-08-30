import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamedrop/config/base_state/base_state.dart';
import 'package:gamedrop/features/game_details/domain/entities/game_detail_entity.dart';
import 'package:gamedrop/features/game_details/presentation/view/game_details_view.dart';
import 'package:gamedrop/features/game_details/presentation/view_model/game_details_state.dart';
import 'package:gamedrop/features/game_details/presentation/view_model/game_details_view_model.dart';
import 'package:gamedrop/features/game_details/presentation/widgets/game_details_loading_view.dart';
import 'package:gamedrop/features/games/presentation/widgets/empty_view.dart';
import 'package:gamedrop/features/games/presentation/widgets/error_view.dart';
import 'package:mocktail/mocktail.dart';

class MockGameDetailsViewModel extends MockCubit<GameDetailsState>
    implements GameDetailsViewModel {}

void main() {
  late MockGameDetailsViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockGameDetailsViewModel();
  });

  const tGame = GameDetailEntity(
    id: 1,
    name: 'Eclipse Protocol',
    coverUrl: null,
    releaseDate: null,
    tba: true,
    platforms: ['PS5', 'Xbox'],
    summary: 'A rogue signal triggers a catastrophic eclipse event.',
  );

  Widget buildTestableWidget() {
    return MaterialApp(
      home: BlocProvider<GameDetailsViewModel>.value(
        value: mockViewModel,
        child: const GameDetailsView(gameId: 1),
      ),
    );
  }

  group('GameDetailsView', () {
    testWidgets('renders GameDetailsLoadingView when isLoading is true', (
      tester,
    ) async {
      when(() => mockViewModel.state).thenReturn(
        const GameDetailsState(
          getGameDetailState: BaseState(isLoading: true),
        ),
      );

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(GameDetailsLoadingView), findsOneWidget);
    });

    testWidgets('renders ErrorView when errorMessage is present', (
      tester,
    ) async {
      when(() => mockViewModel.state).thenReturn(
        const GameDetailsState(
          getGameDetailState: BaseState(errorMessage: 'Network error'),
        ),
      );

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(ErrorView), findsOneWidget);
      expect(find.text('Network error'), findsOneWidget);
    });

    testWidgets('renders EmptyView when data is null and not loading', (
      tester,
    ) async {
      when(() => mockViewModel.state).thenReturn(
        const GameDetailsState(
          getGameDetailState: BaseState(),
        ),
      );

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(EmptyView), findsOneWidget);
    });

    testWidgets('renders full detail layout when data is loaded successfully', (
      tester,
    ) async {
      when(() => mockViewModel.state).thenReturn(
        const GameDetailsState(
          getGameDetailState: BaseState(data: tGame),
        ),
      );

      await tester.pumpWidget(buildTestableWidget());

      expect(find.text('Eclipse Protocol'), findsOneWidget);
      expect(find.text('RELEASING IN'), findsOneWidget);
      expect(find.text('ABOUT'), findsOneWidget);
      expect(
        find.text('A rogue signal triggers a catastrophic eclipse event.'),
        findsOneWidget,
      );
      expect(find.text('Back'), findsOneWidget);
      expect(find.text('PS5 EXCLUSIVE'), findsOneWidget);
    });
  });
}
