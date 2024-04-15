import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_flashcard/data/repository/deck_repository.dart';
import 'package:simple_flashcard/domain/models/deck_model.dart';

part 'deck_list_event.dart';
part 'deck_list_state.dart';

class DeckListBloc extends Bloc<DeckListEvent, DeckListState> {
  final DeckRepository _deckRepository;

  DeckListBloc({required DeckRepository deckRepository})
      : _deckRepository = deckRepository,
        super(DeckListInitial()) {
    on<DeckListFetchRequested>(_onDeckListFetchRequested);
  }

  Future<void> _onDeckListFetchRequested(
    DeckListFetchRequested event,
    Emitter<DeckListState> emit,
  ) async {
    try {
      return emit.forEach(
        _deckRepository.watchAllDecks(),
        onData: (deckList) {
          return DeckListSuccess(
            deckList: deckList
                .map((deckData) => DeckModel.fromDeckData(deckData))
                .toList(),
          );
        },
      );
    } catch (e) {
      emit(DeckListFailure(errorMsg: e.toString()));
    }
  }
}
