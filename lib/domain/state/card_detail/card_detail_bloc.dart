import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_flashcard/data/repository/card_item_repository.dart';
import 'package:simple_flashcard/domain/models/card_model.dart';

part 'card_detail_event.dart';
part 'card_detail_state.dart';

class CardDetailBloc extends Bloc<CardDetailEvent, CardDetailState> {
  final CardItemRepository _cardItemRepository;

  CardDetailBloc({required CardItemRepository cardItemRepository})
      : _cardItemRepository = cardItemRepository,
        super(CardDetailInitial()) {
    on<CardDetailRequested>(_onCardDetailRequested);
  }

  Future<void> _onCardDetailRequested(
    CardDetailRequested event,
    Emitter<CardDetailState> emit,
  ) {
    return emit.forEach(
      _cardItemRepository.watchCardItem(event.cardId),
      onData: (data) => state.copyWith(
        card: CardModel.fromCardItemData(data),
        status: CardDetailStatus.success,
      ),
      onError: (error, stackTrace) => state.copyWith(
        status: CardDetailStatus.failure,
      ),
    );
  }
}
