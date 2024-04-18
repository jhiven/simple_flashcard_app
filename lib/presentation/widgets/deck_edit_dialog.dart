import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flashcard/data/repository/deck_repository.dart';
import 'package:simple_flashcard/domain/models/deck_model.dart';
import 'package:simple_flashcard/domain/state/deck_edit/deck_edit_bloc.dart';
import 'package:simple_flashcard/utils/validator.dart';

class DeckEditDialog extends StatelessWidget with CustomFormValidator {
  DeckEditDialog({
    super.key,
    this.deck,
  });

  final DeckModel? deck;

  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => DeckEditBloc(
        deckRepository: context.read<DeckRepository>(),
      ),
      child: BlocListener<DeckEditBloc, DeckEditState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == DeckEditStatus.success,
        listener: (context, state) => context.router.maybePop(),
        child: Builder(builder: (context) {
          if (deck != null) {
            context.read<DeckEditBloc>().add(DeckEditTitle(title: deck!.title));
          }
          return AlertDialog(
            title: Text(deck == null ? 'Add new deck' : 'Edit deck'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _fromKey,
                  child: TextFormField(
                    initialValue: deck?.title,
                    validator: (value) => validateIsNotEmpty(value, 'Title'),
                    maxLength: 64,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      label: Text('Title'),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      context
                          .read<DeckEditBloc>()
                          .add(DeckEditTitle(title: value));
                    },
                  ),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                  textStyle: theme.textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  context.router.maybePop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  textStyle: theme.textTheme.labelLarge,
                ),
                child: Text(deck == null ? 'Submit' : 'Edit'),
                onPressed: () {
                  if (_fromKey.currentState!.validate()) {
                    if (deck == null) {
                      context.read<DeckEditBloc>().add(DeckEditSubmitAdd());
                    } else {
                      context
                          .read<DeckEditBloc>()
                          .add(DeckEditSubmitUpdate(deckId: deck!.id));
                    }
                  }
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
