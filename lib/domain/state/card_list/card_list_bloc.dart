import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_flashcard/data/repository/card_item_repository.dart';
import 'package:simple_flashcard/data/repository/deck_repository.dart';
import 'package:simple_flashcard/domain/models/card_model.dart';

part 'card_list_event.dart';
part 'card_list_state.dart';

class CardListBloc extends Bloc<CardListEvent, CardListState> {
  final CardItemRepository _cardItemRepository;

  CardListBloc(
      {required CardItemRepository cardItemRepository,
      required DeckRepository deckRepository})
      : _cardItemRepository = cardItemRepository,
        super(CardListInitial()) {
    on<CardListRequested>(_onCardListRequested);
  }

  Future<void> _onCardListRequested(
    CardListRequested event,
    Emitter<CardListState> emit,
  ) async {
    try {
      return emit.forEach(
        _cardItemRepository.watchCardItemsByDeckId(event.deckId),
        onData: (data) {
          return CardListSuccess(
            cardList:
                data.map((card) => CardModel.fromCardItemData(card)).toList(),
          );
        },
      );
    } catch (e) {
      emit(CardListFailure(errorMsg: e.toString()));
    }
  }
}
