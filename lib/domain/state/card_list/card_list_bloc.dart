import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_flashcard/data/repository/card_item_repository.dart';
import 'package:simple_flashcard/data/repository/deck_repository.dart';
import 'package:simple_flashcard/domain/models/card_model.dart';
import 'package:simple_flashcard/domain/models/deck_model.dart';

part 'card_list_event.dart';
part 'card_list_state.dart';

class CardListBloc extends Bloc<CardListEvent, CardListState> {
  final CardItemRepository _cardItemRepository;
  final DeckRepository _deckRepository;

  CardListBloc(
      {required CardItemRepository cardItemRepository,
      required DeckRepository deckRepository})
      : _cardItemRepository = cardItemRepository,
        _deckRepository = deckRepository,
        super(CardListInitial()) {
    on<CardListRequested>(_onCardListRequested);
    on<CardListDeckRequested>(_onCardListDeckRequested);
  }

  Future<void> _onCardListRequested(
    CardListRequested event,
    Emitter<CardListState> emit,
  ) async {
    try {
      final deck = DeckModel.fromDeckData(
        await _deckRepository.getDeck(event.deckId),
      );
      return emit.forEach(
        _cardItemRepository.watchCardItemsByDeckId(event.deckId),
        onData: (data) {
          return CardListSuccess(
            deck: deck,
            cardList:
                data.map((card) => CardModel.fromCardItemData(card)).toList(),
          );
        },
      );
    } catch (e) {
      emit(CardListFailure(errorMsg: e.toString()));
    }
  }

  Future<void> _onCardListDeckRequested(
      CardListDeckRequested event, Emitter<CardListState> emit) async {
    try {
      final deck = DeckModel.fromDeckData(
        await _deckRepository.getDeck(event.deckId),
      );

      if (state is CardListSuccess) {
        emit((state as CardListSuccess).copyWith(deck: deck));
      } else {
        emit(const CardListFailure(errorMsg: 'failed to get deck'));
      }
    } catch (e) {
      emit(CardListFailure(errorMsg: e.toString()));
    }
  }
}
