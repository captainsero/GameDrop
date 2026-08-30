import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/style_manager.dart';
import '../../../../core/constants/values_manager.dart';
import '../../domain/entities/game_detail_entity.dart';
import 'countdown_card.dart';

class GameDetailsCountdownSection extends StatelessWidget {
  const GameDetailsCountdownSection({
    required this.game,
    super.key,
  });

  final GameDetailEntity game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final releaseDate = game.releaseDate;
    final isTba = game.tba || releaseDate == null;

    final String formattedDate = releaseDate != null
        ? DateFormat('MMMM d,\nyyyy').format(releaseDate)
        : 'To Be\nAnnounced';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Label ────────────────────────────────────────────────
          Text(
            'RELEASING IN',
            style: getBoldStyle(
              fontFamily: FontConstants.outfit,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              fontSize: FontSize.s12,
            ).copyWith(letterSpacing: 1.5),
          ),
          const SizedBox(height: AppSize.s14),

          // ── Countdown Row ────────────────────────────────────────────────
          if (isTba)
            _TbaCountdownView(
              formattedDate: formattedDate,
              colorScheme: colorScheme,
            )
          else
            StreamBuilder<DateTime>(
              stream: Stream.periodic(
                const Duration(seconds: 1),
                (_) => DateTime.now(),
              ),
              initialData: DateTime.now(),
              builder: (context, snapshot) {
                final now = snapshot.data ?? DateTime.now();
                final difference = releaseDate.difference(now);
                final isPast = difference.isNegative;

                final days = isPast ? 0 : difference.inDays;
                final hours = isPast ? 0 : difference.inHours % 24;
                final minutes = isPast ? 0 : difference.inMinutes % 60;
                final seconds = isPast ? 0 : difference.inSeconds % 60;

                final daysStr = days.toString().padLeft(2, '0');
                final hoursStr = hours.toString().padLeft(2, '0');
                final minStr = minutes.toString().padLeft(2, '0');
                final secStr = seconds.toString().padLeft(2, '0');

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── 4 Countdown Cards ──────────────────────────────────
                    CountdownCard(value: daysStr, label: 'DAYS'),
                    const SizedBox(width: AppSize.s8),
                    CountdownCard(value: hoursStr, label: 'HRS'),
                    const SizedBox(width: AppSize.s8),
                    CountdownCard(value: minStr, label: 'MIN'),
                    const SizedBox(width: AppSize.s8),
                    CountdownCard(value: secStr, label: 'SEC'),

                    const Spacer(),

                    // ── Release Date Column ────────────────────────────────
                    _ReleaseDateColumn(
                      formattedDate: isPast ? 'OUT NOW' : formattedDate,
                      colorScheme: colorScheme,
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}

class _ReleaseDateColumn extends StatelessWidget {
  const _ReleaseDateColumn({
    required this.formattedDate,
    required this.colorScheme,
  });

  final String formattedDate;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'RELEASE DATE',
          style: getBoldStyle(
            fontFamily: FontConstants.outfit,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            fontSize: FontSize.s10,
          ).copyWith(letterSpacing: 1.2),
        ),
        const SizedBox(height: AppSize.s4),
        Text(
          formattedDate,
          textAlign: TextAlign.end,
          style: getBoldStyle(
            fontFamily: FontConstants.outfit,
            color: colorScheme.secondary,
            fontSize: FontSize.s14,
          ),
        ),
      ],
    );
  }
}

class _TbaCountdownView extends StatelessWidget {
  const _TbaCountdownView({
    required this.formattedDate,
    required this.colorScheme,
  });

  final String formattedDate;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CountdownCard(value: '--', label: 'DAYS'),
        const SizedBox(width: AppSize.s8),
        const CountdownCard(value: '--', label: 'HRS'),
        const SizedBox(width: AppSize.s8),
        const CountdownCard(value: '--', label: 'MIN'),
        const SizedBox(width: AppSize.s8),
        const CountdownCard(value: '--', label: 'SEC'),
        const Spacer(),
        _ReleaseDateColumn(
          formattedDate: formattedDate,
          colorScheme: colorScheme,
        ),
      ],
    );
  }
}
