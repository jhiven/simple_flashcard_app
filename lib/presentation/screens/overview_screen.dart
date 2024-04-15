import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flashcard/domain/state/deck_card_overview/deck_card_overview_bloc.dart';
import 'package:simple_flashcard/presentation/widgets/flashcard.dart';
import 'package:simple_flashcard/router/router.dart';

@RoutePage()
class OverviewScreen extends StatelessWidget implements AutoRouteWrapper {
  const OverviewScreen({
    super.key,
    required this.bloc,
  });

  final DeckCardOverviewBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeckCardOverviewBloc, DeckCardOverviewState>(
      listener: (context, state) => context.router.replace(
        const OverviewDoneRoute(),
      ),
      listenWhen: (previous, current) =>
          previous.currentCard != current.currentCard &&
          current.currentCard == null,
      builder: (context, state) {
        switch (state.status) {
          case DeckCardOverViewStatus.initial:
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case DeckCardOverViewStatus.success:
            final theme = Theme.of(context);
            if (state.currentCard != null) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(state.deck!.title),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AnimatedSwitcher(
                        transitionBuilder: (child, animation) {
                          final offset1 = Tween(
                            begin: const Offset(-1, 0),
                            end: const Offset(0, 0),
                          );
                          final offset2 = Tween(
                            begin: const Offset(1, 0),
                            end: const Offset(0, 0),
                          );

                          return SlideTransition(
                            position: (animation.value == 1 ? offset1 : offset2)
                                .animate(animation),
                            child: child,
                          );
                        },
                        duration: Durations.medium3,
                        child: Padding(
                          key: ValueKey(state.currentCard!.id),
                          padding: const EdgeInsets.all(12),
                          child: Flashcard(
                            front: state.currentCard!.front,
                            back: state.currentCard!.back,
                            isOpen: state.isOpen,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Total new card: ${state.newCardList!.length}',
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          Text(
                            'Total repeated card: ${state.repeatedCardList!.length}',
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: state.isOpen
                          ? Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      context
                                          .read<DeckCardOverviewBloc>()
                                          .add(DeckCardOverviewHardCard());
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Hard'),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () {
                                      context
                                          .read<DeckCardOverviewBloc>()
                                          .add(DeckCardOverviewEasyCard());
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Easy'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : FilledButton(
                              onPressed: () {
                                context
                                    .read<DeckCardOverviewBloc>()
                                    .add(DeckCardOverviewOpen());
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Show answer'),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              );
            } else {
              return const Scaffold();
            }
          case DeckCardOverViewStatus.failure:
            return Scaffold(
              appBar: AppBar(),
              body: const Text('Error'),
            );
        }
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: this,
    );
  }
}
