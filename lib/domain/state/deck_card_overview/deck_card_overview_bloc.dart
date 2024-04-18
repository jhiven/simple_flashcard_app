import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:simple_flashcard/data/provider/local/card_item.dart';
import 'package:simple_flashcard/data/provider/local/drift_database.dart';
import 'package:simple_flashcard/data/repository/card_item_repository.dart';
import 'package:simple_flashcard/data/repository/deck_repository.dart';
import 'package:simple_flashcard/domain/models/card_model.dart';
import 'package:simple_flashcard/domain/models/deck_model.dart';

part 'deck_card_overview_event.dart';
part 'deck_card_overview_state.dart';

class DeckCardOverviewBloc
    extends Bloc<DeckCardOverviewEvent, DeckCardOverviewState> {
  final DeckRepository _deckRepository;
  final CardItemRepository _cardItemRepository;

  DeckCardOverviewBloc({
    required DeckRepository deckRepository,
    required CardItemRepository cardItemRepository,
  })  : _cardItemRepository = cardItemRepository,
        _deckRepository = deckRepository,
        super(DeckCardOverviewInitial()) {
    on<DeckCardOverviewFetchCards>(_onDeckCardOverviewFetchCards);
    on<DeckCardOverviewEasyCard>(_onDeckCardOverviewEasyCard);
    on<DeckCardOverviewHardCard>(_onDeckCardOverviewHardCard);
    on<DeckCardOverviewOpen>(_onDeckCardOverviewOpen);
  }

  Future<void> _onDeckCardOverviewFetchCards(
    DeckCardOverviewFetchCards event,
    Emitter<DeckCardOverviewState> emit,
  ) async {
    try {
      return emit.forEach(
        _deckRepository.watchDeckOverview(event.deck.id),
        onData: (data) {
          final List<CardModel> cardItemList =
              data.map((e) => CardModel.fromCardItemData(e.card)).toList();

          final List<CardModel> newCardList = cardItemList
              .where((element) =>
                  element.answerType == null ||
                  element.answerType == AnswerType.easy)
              .toList();

          final List<CardModel> repeatedCardList = cardItemList
              .where((element) => element.answerType == AnswerType.hard)
              .toList();

          final CardModel? currentCard = newCardList.isNotEmpty
              ? newCardList.first
              : repeatedCardList.isNotEmpty
                  ? repeatedCardList.first
                  : null;

          final DeckModel deck = data.isNotEmpty
              ? DeckModel.fromDeckData(data.first.deck)
              : event.deck;

          return state.copyWith(
            deck: deck,
            newCardList: newCardList,
            repeatedCardList: repeatedCardList,
            currentCard: () => currentCard,
            status: DeckCardOverViewStatus.success,
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(status: DeckCardOverViewStatus.failure),
      );
      throw Exception(e.toString());
    }
  }

  void _onDeckCardOverviewEasyCard(
    DeckCardOverviewEasyCard event,
    Emitter<DeckCardOverviewState> emit,
  ) async {
    try {
      if (state.currentCard != null) {
        await _cardItemRepository.nextCard(
          CardItemCompanion(
            id: Value(state.currentCard!.id),
            answeredType: const Value(AnswerType.easy),
            deckId: Value(state.currentCard!.deckId),
            front: Value(state.currentCard!.front),
            back: Value(state.currentCard!.back),
          ),
        );
        emit(
          state.copyWith(
            status: DeckCardOverViewStatus.success,
            isOpen: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: DeckCardOverViewStatus.success,
            currentCard: null,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: DeckCardOverViewStatus.failure));
      throw Exception(e.toString());
    }
  }

  void _onDeckCardOverviewHardCard(
    DeckCardOverviewHardCard event,
    Emitter<DeckCardOverviewState> emit,
  ) async {
    try {
      if (state.currentCard != null) {
        await _cardItemRepository.updateCardItem(
          CardItemCompanion(
            id: Value(state.currentCard!.id),
            answeredType: const Value(AnswerType.hard),
            deckId: Value(state.currentCard!.deckId),
            front: Value(state.currentCard!.front),
            back: Value(state.currentCard!.back),
          ),
        );
        emit(
          state.copyWith(
            status: DeckCardOverViewStatus.success,
            isOpen: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: DeckCardOverViewStatus.success,
            currentCard: null,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: DeckCardOverViewStatus.failure));
      throw Exception(e.toString());
    }
  }

  void _onDeckCardOverviewOpen(
    DeckCardOverviewOpen event,
    Emitter<DeckCardOverviewState> emit,
  ) {
    emit(
      state.copyWith(
        isOpen: true,
        status: DeckCardOverViewStatus.success,
      ),
    );
  }
}
