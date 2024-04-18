import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_flashcard/data/provider/local/drift_database.dart';
import 'package:simple_flashcard/data/repository/deck_repository.dart';

part 'deck_edit_event.dart';
part 'deck_edit_state.dart';

class DeckEditBloc extends Bloc<DeckEditEvent, DeckEditState> {
  final DeckRepository _deckRepository;

  DeckEditBloc({
    required DeckRepository deckRepository,
  })  : _deckRepository = deckRepository,
        super(DeckEditInitial()) {
    on<DeckEditTitle>(_onDeckEditTitle);
    on<DeckEditSubmitUpdate>(_onDeckEditSubmitUpdate);
    on<DeckEditSubmitAdd>(_onDeckEditSubmitAdd);
  }

  void _onDeckEditTitle(
    DeckEditTitle event,
    Emitter<DeckEditState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDeckEditSubmitUpdate(
    DeckEditSubmitUpdate event,
    Emitter<DeckEditState> emit,
  ) async {
    try {
      print(state.title);
      await _deckRepository.updateDeck(
        DeckCompanion(
          id: Value(event.deckId),
          title: Value(state.title),
        ),
      );

      emit(state.copyWith(status: DeckEditStatus.success));
    } catch (e) {
      emit(state.copyWith(status: DeckEditStatus.failure));
      throw Exception(e.toString());
    }
  }

  void _onDeckEditSubmitAdd(
    DeckEditSubmitAdd event,
    Emitter<DeckEditState> emit,
  ) async {
    try {
      if (state.title.isNotEmpty) {
        await _deckRepository.addDeck(
          DeckCompanion.insert(
            title: state.title,
          ),
        );
      }

      emit(state.copyWith(status: DeckEditStatus.success));
    } catch (e) {
      emit(state.copyWith(status: DeckEditStatus.failure));
    }
  }
}
