import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_flashcard/data/repository/deck_repository.dart';
import 'package:simple_flashcard/domain/models/deck_model.dart';

part 'deck_detail_event.dart';
part 'deck_detail_state.dart';

class DeckDetailBloc extends Bloc<DeckDetailEvent, DeckDetailState> {
  final DeckRepository _deckRepository;

  DeckDetailBloc({
    required DeckRepository deckRepository,
  })  : _deckRepository = deckRepository,
        super(DeckDetailInitial()) {
    on<DeckDetailRequested>(_onDeckDetailRequested);
  }

  Future<void> _onDeckDetailRequested(
    DeckDetailRequested event,
    Emitter<DeckDetailState> emit,
  ) {
    return emit.forEach(
      _deckRepository.watchDeck(event.deckId),
      onData: (data) => state.copyWith(
        deck: DeckModel.fromDeckData(data),
        status: DeckDetailStatus.success,
      ),
      onError: (error, stackTrace) => state.copyWith(
        status: DeckDetailStatus.failure,
      ),
    );
  }
}
