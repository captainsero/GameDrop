import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/values_manager.dart';
import '../../core/router/route_path.dart';
import '../../generated/l10n.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({required this.errorMessage, super.key});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(S.current.error), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: Theme.of(context).colorScheme.error,
                size: AppSize.s100,
              ),
              const SizedBox(height: AppSize.s24),

              Text(
                S.current.oopsSomthingWentWrong,
                style: textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s16),

              Text(
                errorMessage,
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(RoutePath.gamesRoute);
                  },
                  child: Text(S.current.returnToGames),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
