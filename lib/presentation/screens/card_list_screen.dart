import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flashcard/data/repository/card_item_repository.dart';
import 'package:simple_flashcard/data/repository/deck_repository.dart';
import 'package:simple_flashcard/domain/models/deck_model.dart';
import 'package:simple_flashcard/domain/state/card_list/card_list_bloc.dart';
import 'package:simple_flashcard/domain/state/deck_detail/deck_detail_bloc.dart';
import 'package:simple_flashcard/presentation/widgets/card_list_tile.dart';
import 'package:simple_flashcard/presentation/widgets/deck_edit_dialog.dart';
import 'package:simple_flashcard/router/router.dart';

@RoutePage()
class CardListScreen extends StatelessWidget implements AutoRouteWrapper {
  const CardListScreen({super.key, required this.deckId});

  final int deckId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (context) {
            final String? title = context
                .select((DeckDetailBloc value) => value.state.deck?.title);

            return Text(title ?? '');
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              final DeckModel? deck = context.select(
                (DeckDetailBloc value) => value.state.deck,
              );

              return IconButton(
                onPressed: () {
                  if (deck != null) {
                    _showEditDeckDialog(context, deck);
                  }
                },
                icon: const Icon(Icons.edit),
              );
            },
          )
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) {
          final int? deckId = context.select(
            (DeckDetailBloc value) => value.state.deck?.id,
          );

          return FloatingActionButton(
            onPressed: () {
              if (deckId != null) {
                context.router.push(CardEditRoute(deckId: deckId));
              }
            },
            child: const Icon(Icons.add_box_outlined),
          );
        },
      ),
      body: Builder(
        builder: (context) {
          final DeckDetailStatus status = context.select(
            (DeckDetailBloc value) => value.state.status,
          );

          switch (status) {
            case DeckDetailStatus.initial:
            case DeckDetailStatus.success:
              return BlocBuilder<CardListBloc, CardListState>(
                builder: (context, state) {
                  switch (state) {
                    case CardListInitial():
                      return const Center(child: CircularProgressIndicator());
                    case CardListSuccess():
                      return ListView.builder(
                        itemCount: state.cardList.length,
                        itemBuilder: (context, index) {
                          final card = state.cardList[index];
                          return CardListTile(card: card);
                        },
                      );
                    case CardListFailure():
                      return Text(state.errorMsg);
                  }
                },
              );
            case DeckDetailStatus.failure:
              return const Center(child: Text('Error occured'));
          }
        },
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CardListBloc(
            cardItemRepository: context.read<CardItemRepository>(),
            deckRepository: context.read<DeckRepository>(),
          )..add(CardListRequested(deckId: deckId)),
        ),
        BlocProvider(
          create: (context) => DeckDetailBloc(
            deckRepository: context.read<DeckRepository>(),
          )..add(DeckDetailRequested(deckId: deckId)),
        )
      ],
      child: this,
    );
  }

  Future<void> _showEditDeckDialog(BuildContext context, DeckModel deck) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DeckEditDialog(deck: deck);
      },
    );
  }
}
