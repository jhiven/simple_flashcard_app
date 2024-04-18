import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flashcard/domain/state/deck_list/deck_list_bloc.dart';
import 'package:simple_flashcard/presentation/widgets/continue_card.dart';
import 'package:simple_flashcard/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Color> cardColor = [
      theme.colorScheme.surfaceVariant,
      theme.colorScheme.secondaryContainer,
    ];
    final List<Color> textCardColor = [
      theme.colorScheme.onSurfaceVariant,
      theme.colorScheme.onSecondaryContainer,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello, Jhiven!',
          style: theme.textTheme.headlineMedium!.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
              radius: 24,
            ),
          )
        ],
      ),
      body: BlocBuilder<DeckListBloc, DeckListState>(
        builder: (context, state) {
          switch (state) {
            case DeckListInitial():
              return const Center(child: CircularProgressIndicator());
            case DeckListSuccess():
              return ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  ContinueCard(deck: state.deckList.first),
                  Divider(
                    thickness: 0.4,
                    color: theme.colorScheme.outline,
                    height: 48,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.deckList.length,
                    itemBuilder: (context, index) {
                      final deck = state.deckList[index];
                      return Card(
                        color: cardColor[index % cardColor.length],
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () =>
                              context.router.push(DeckStatusRoute(deck: deck)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  deck.title,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium!.copyWith(
                                    color: textCardColor[
                                        index % textCardColor.length],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'Total card: ${deck.cardTotal.toString()}',
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    color: textCardColor[
                                        index % textCardColor.length],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            case DeckListFailure():
              return Text(state.errorMsg);
          }
        },
      ),
    );
  }
}
