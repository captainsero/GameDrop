import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/values_manager.dart';
import '../view_model/games_event.dart';
import '../view_model/games_view_model.dart';

/// Animated search [TextField] that slides and fades into the AppBar title
/// area. Submitting a non-empty query dispatches [SearchGamesEvent].
/// The inline clear button dispatches [ClearSearchEvent].
class SearchBarField extends StatelessWidget {
  const SearchBarField({
    required this.controller,
    required this.focusNode,
    required this.fadeAnimation,
    required this.slideAnimation,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  void _onChanged(BuildContext context, String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      unawaited(
        context.read<GamesViewModel>().onEvent(ClearSearchEvent()),
      );
    } else {
      unawaited(
        context
            .read<GamesViewModel>()
            .onEvent(SearchGamesEvent(query: trimmed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: (value) => _onChanged(context, value),
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Search games\u2026',
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
            suffixIcon: _ClearFieldButton(
              controller: controller,
              focusNode: focusNode,
            ),
          ),
        ),
      ),
    );
  }
}

/// Inline clear button that appears when the [controller] has text.
class _ClearFieldButton extends StatelessWidget {
  const _ClearFieldButton({
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        if (value.text.isEmpty) return const SizedBox.shrink();
        return IconButton(
          iconSize: AppSize.s20,
          icon: const Icon(Icons.cancel_outlined),
          onPressed: () {
            controller.clear();
            focusNode.requestFocus();
            unawaited(
              context
                  .read<GamesViewModel>()
                  .onEvent(ClearSearchEvent()),
            );
          },
        );
      },
    );
  }
}
