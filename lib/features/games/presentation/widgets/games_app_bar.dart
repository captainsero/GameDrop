import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/values_manager.dart';
import '../view_model/games_event.dart';
import '../view_model/games_state.dart';
import '../view_model/games_view_model.dart';
import 'search_bar_field.dart';

/// AppBar for the Games screen.
///
/// Switches between the logo/title and the animated search field based on
/// [GamesState.isSearchActive]. No local state — reads from [GamesViewModel].
class GamesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GamesAppBar({
    required this.searchController,
    required this.searchFocus,
    required this.fadeAnimation,
    required this.slideAnimation,
    super.key,
  });

  final TextEditingController searchController;
  final FocusNode searchFocus;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  @override
  Size get preferredSize => const Size.fromHeight(AppSize.s50);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesViewModel, GamesState>(
      buildWhen: (prev, curr) => prev.isSearchActive != curr.isSearchActive,
      builder: (context, state) => AppBar(
        leadingWidth: AppSize.s50,
        toolbarHeight: AppSize.s50,
        leading: state.isSearchActive
            ? null
            : ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(RadiusSize.r16),
                child: Image.asset(AssetsConst.logo),
              ),
        title: state.isSearchActive
            ? SearchBarField(
                controller: searchController,
                focusNode: searchFocus,
                fadeAnimation: fadeAnimation,
                slideAnimation: slideAnimation,
              )
            : const Text('GameDrop'),
        titleSpacing: state.isSearchActive ? AppPadding.p4 : AppPadding.p0,
        actions: [
          if (state.isSearchActive)
            IconButton(
              tooltip: 'Close search',
              onPressed: () =>
                  context.read<GamesViewModel>().onEvent(CloseSearchEvent()),
              icon: const Icon(Icons.close),
            )
          else
            IconButton(
              tooltip: 'Search games',
              onPressed: () =>
                  context.read<GamesViewModel>().onEvent(OpenSearchEvent()),
              icon: const Icon(Icons.search_outlined),
            ),
        ],
      ),
    );
  }
}
