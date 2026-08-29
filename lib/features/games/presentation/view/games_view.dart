import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/games_event.dart';
import '../view_model/games_state.dart';
import '../view_model/games_view_model.dart';
import '../widgets/games_app_bar.dart';
import '../widgets/search_games_body.dart';
import '../widgets/upcoming_games_body.dart';

class GamesView extends StatefulWidget {
  const GamesView({super.key});

  @override
  State<GamesView> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView>
    with SingleTickerProviderStateMixin {
  // -- Controller / focus / animation lifecycle --------------------------------
  late final TextEditingController _searchController;
  late final FocusNode _searchFocus;
  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocus = FocusNode();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );
    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(0.15, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOut),
        );

    unawaited(
      context.read<GamesViewModel>().onEvent(GetUpcomingGamesEvent(page: 1)),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  // -- Animation side-effects driven by ViewModel state -----------------------

  void _onSearchActiveChanged({required bool isActive}) {
    if (isActive) {
      _animController.forward();
      _searchFocus.requestFocus();
    } else {
      _animController.reverse();
      _searchController.clear();
      _searchFocus.unfocus();
    }
  }

  // -- Build ------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return BlocListener<GamesViewModel, GamesState>(
      listenWhen: (prev, curr) => prev.isSearchActive != curr.isSearchActive,
      listener: (context, state) =>
          _onSearchActiveChanged(isActive: state.isSearchActive),
      child: Scaffold(
        appBar: GamesAppBar(
          searchController: _searchController,
          searchFocus: _searchFocus,
          fadeAnimation: _fadeAnimation,
          slideAnimation: _slideAnimation,
        ),
        body: BlocBuilder<GamesViewModel, GamesState>(
          buildWhen: (prev, curr) => prev.isSearchActive != curr.isSearchActive,
          builder: (context, state) => state.isSearchActive
              ? SearchGamesBody(searchController: _searchController)
              : const UpcomingGamesBody(),
        ),
      ),
    );
  }
}
