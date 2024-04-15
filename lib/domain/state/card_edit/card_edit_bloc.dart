import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_flashcard/data/provider/local/drift_database.dart';
import 'package:simple_flashcard/data/repository/card_item_repository.dart';
import 'package:simple_flashcard/domain/models/card_model.dart';

part 'card_edit_event.dart';
part 'card_edit_state.dart';

class CardEditBloc extends Bloc<CardEditEvent, CardEditState> {
  final CardItemRepository _cardItemRepository;

  CardEditBloc({
    required CardItemRepository cardItemRepository,
  })  : _cardItemRepository = cardItemRepository,
        super(CardEditInitial()) {
    on<CardEditFront>(_onCardEditFront);
    on<CardEditBack>(_onCardEditBack);
    on<CardEditSubmitUpdate>(_onCardEditSubmitUpdate);
    on<CardEditSubmitAdd>(_onCardEditSubmitAdd);
  }

  void _onCardEditFront(
    CardEditFront event,
    Emitter<CardEditState> emit,
  ) {
    emit(state.copyWith(front: event.front));
  }

  void _onCardEditBack(
    CardEditBack event,
    Emitter<CardEditState> emit,
  ) {
    emit(state.copyWith(back: event.back));
  }

  void _onCardEditSubmitUpdate(
    CardEditSubmitUpdate event,
    Emitter<CardEditState> emit,
  ) async {
    try {
      await _cardItemRepository.updateCardItem(
        CardItemCompanion(
          id: Value(event.card.id),
          back: Value(state.back),
          front: Value(state.front),
          deckId: Value(event.card.deckId),
        ),
      );

      emit(state.copyWith(status: CardEditStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CardEditStatus.failure));
    }
  }

  void _onCardEditSubmitAdd(
    CardEditSubmitAdd event,
    Emitter<CardEditState> emit,
  ) async {
    try {
      await _cardItemRepository.addCardItem(
        CardItemCompanion.insert(
          deckId: event.deckId,
          back: state.back,
          front: state.front,
        ),
      );

      emit(state.copyWith(status: CardEditStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CardEditStatus.failure));
    }
  }
}
