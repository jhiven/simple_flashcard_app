import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flashcard/data/repository/card_item_repository.dart';
import 'package:simple_flashcard/domain/models/card_model.dart';
import 'package:simple_flashcard/domain/state/card_edit/card_edit_bloc.dart';
import 'package:simple_flashcard/utils/validator.dart';

@RoutePage()
class CardEditScreen extends StatelessWidget
    with CustomFormValidator
    implements AutoRouteWrapper {
  CardEditScreen({
    super.key,
    this.card,
    this.deckId,
  });

  final CardModel? card;
  final int? deckId;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (card != null) {
      context.read<CardEditBloc>().add(CardEditBack(back: card!.back));
      context.read<CardEditBloc>().add(CardEditFront(front: card!.front));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(card == null ? 'Add Card' : 'Edit card'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: card?.front,
                validator: (value) => validateFrontCard(value),
                maxLength: 128,
                decoration: const InputDecoration(
                  label: Text('Front'),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  context.read<CardEditBloc>().add(CardEditFront(front: value));
                },
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                initialValue: card?.back,
                validator: (value) => validateIsNotEmpty(value, 'Back card'),
                decoration: const InputDecoration(
                  label: Text('Back'),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  context.read<CardEditBloc>().add(CardEditBack(back: value));
                },
              ),
              const SizedBox(
                height: 14,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (card != null) {
                      context
                          .read<CardEditBloc>()
                          .add(CardEditSubmitUpdate(card: card!));
                    } else if (deckId != null) {
                      context
                          .read<CardEditBloc>()
                          .add(CardEditSubmitAdd(deckId: deckId!));
                    }
                    context.router.maybePop();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(card == null ? 'Buat Card' : 'Edit card'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CardEditBloc(
        cardItemRepository: context.read<CardItemRepository>(),
      ),
      child: this,
    );
  }
}
