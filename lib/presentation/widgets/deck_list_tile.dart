import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flashcard/data/repository/deck_repository.dart';
import 'package:simple_flashcard/domain/models/deck_model.dart';
import 'package:simple_flashcard/router/router.dart';

class DeckListTile extends StatelessWidget {
  const DeckListTile({
    super.key,
    required this.deck,
  });

  final DeckModel deck;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(deck.title),
      trailing: IconButton(
        onPressed: () {
          context.read<DeckRepository>().deleteDeck(deck.id);
        },
        icon: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      onTap: () {
        context.router.push(CardListRoute(deckId: deck.id));
      },
    );
  }
}
