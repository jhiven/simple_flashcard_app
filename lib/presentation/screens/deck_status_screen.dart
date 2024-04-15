import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flashcard/data/repository/card_item_repository.dart';
import 'package:simple_flashcard/data/repository/deck_repository.dart';
import 'package:simple_flashcard/domain/models/deck_model.dart';
import 'package:simple_flashcard/domain/state/deck_card_overview/deck_card_overview_bloc.dart';
import 'package:simple_flashcard/router/router.dart';

@RoutePage()
class DeckStatusScreen extends StatelessWidget implements AutoRouteWrapper {
  const DeckStatusScreen({
    super.key,
    required this.deck,
  });

  final DeckModel deck;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deck status'),
      ),
      body: BlocBuilder<DeckCardOverviewBloc, DeckCardOverviewState>(
        builder: (context, state) {
          switch (state.status) {
            case DeckCardOverViewStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case DeckCardOverViewStatus.success:
              final theme = Theme.of(context);

              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(14),
                      children: [
                        Text(
                          state.deck!.title,
                          style: theme.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Total new card: ${state.newCardList!.length}',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          'Total repeated card: ${state.repeatedCardList!.length}',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                        Divider(
                          thickness: 0.4,
                          height: 40,
                          color: theme.colorScheme.outline,
                        ),
                        Text(
                          'Deck usage',
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '''
You simply have to understand the card. 
  
If you understood the card without revealing the answer, you should mark it as "Easy".
    
If you did not understand the card, you should mark it as "Hard"
    
It is normal to forget things, and Simple Flashcard will help you with that.
        ''',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: state.currentCard != null
                          ? () {
                              context.router.push(
                                OverviewRoute(
                                  bloc: context.read<DeckCardOverviewBloc>(),
                                ),
                              );
                            }
                          : null,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Start study'),
                        ],
                      ),
                    ),
                  )
                ],
              );
            case DeckCardOverViewStatus.failure:
              return const Text('Error');
          }
        },
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => DeckCardOverviewBloc(
        deckRepository: context.read<DeckRepository>(),
        cardItemRepository: context.read<CardItemRepository>(),
      )..add(DeckCardOverviewFetchCards(deck: deck)),
      child: this,
    );
  }
}
