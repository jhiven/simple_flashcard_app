import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flashcard/data/repository/card_item_repository.dart';
import 'package:simple_flashcard/domain/models/card_model.dart';
import 'package:simple_flashcard/router/router.dart';

class CardListTile extends StatelessWidget {
  const CardListTile({
    super.key,
    required this.card,
  });

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        card.front,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              context.read<CardItemRepository>().deleteCardItem(card.id);
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          IconButton(
            onPressed: () {
              context.router.push(CardEditRoute(card: card));
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      onTap: () {
        context.router.push(CardDetailRoute(cardId: card.id));
      },
    );
  }
}
