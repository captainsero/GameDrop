import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';
import '../../domain/entities/game_entity.dart';
import '../widgets/game_card.dart';

class GamesView extends StatelessWidget {
  const GamesView({super.key});

  // ── Cached mock data ────────────────────────────────────────────────────
  // Replace this list with real data from the cubit when ready.
  static final List<GameEntity> _mockGames = [
    GameEntity(
      id: 1,
      name: 'Eclipse Protocol',
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co1wyy.jpg',
      releaseDate: DateTime.now().add(const Duration(days: 58)),
      tba: false,
      platforms: const ['PS5', 'Xbox'],
    ),
    GameEntity(
      id: 2,
      name: 'Neon Odyssey',
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co6jkv.jpg',
      releaseDate: DateTime.now().add(const Duration(days: 71)),
      tba: false,
      platforms: const ['PS5', 'PC'],
    ),
    GameEntity(
      id: 3,
      name: 'Void Runners',
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co5vmg.jpg',
      releaseDate: DateTime.now().add(const Duration(days: 98)),
      tba: false,
      platforms: const ['PS4', 'PS5', 'Xbox'],
    ),
    GameEntity(
      id: 4,
      name: 'Phantom Breach',
      coverUrl: null,
      releaseDate: null,
      tba: true,
      platforms: const ['PC'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: AppSize.s50,
        toolbarHeight: AppSize.s50,
        leading: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(RadiusSize.r16),
          child: Image.asset('assets/images/logo.png'),
        ),
        title: const Text('GameDrop'),
        titleSpacing: AppSize.s0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
        itemCount: _mockGames.length,
        itemBuilder: (context, index) => GameCard(game: _mockGames[index]),
      ),
    );
  }
}
