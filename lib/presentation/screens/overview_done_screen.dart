import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OverviewDoneScreen extends StatelessWidget {
  const OverviewDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Text(
                "Finished reviewing all of today's cards",
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 70,
              ),
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(999),
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.done,
                  color: theme.colorScheme.onSecondaryContainer,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Text(
                "You're doing great, keep it up!",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  context.router.maybePop();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Back'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
