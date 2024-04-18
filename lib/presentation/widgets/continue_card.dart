import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:simple_flashcard/domain/models/deck_model.dart';
import 'package:simple_flashcard/router/router.dart';

class ContinueCard extends StatelessWidget {
  const ContinueCard({super.key, required this.deck});

  final DeckModel deck;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        context.router.push(DeckStatusRoute(deck: deck));
      },
      child: Card.filled(
        color: theme.colorScheme.secondaryContainer.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Continue where you left off!',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircularPercentIndicator(
                        percent:
                            (deck.cardTotal - deck.cardLeft) / deck.cardTotal,
                        animation: true,
                        lineWidth: 6,
                        animationDuration: 1200,
                        radius: 24,
                        center: Text(
                          '${(((deck.cardTotal - deck.cardLeft) / deck.cardTotal) * 100).toInt()}%',
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: theme.colorScheme.primary,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deck.title,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                              '${deck.cardTotal - deck.cardLeft}/${deck.cardTotal} card finished'),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: theme.colorScheme.onSecondaryContainer,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
