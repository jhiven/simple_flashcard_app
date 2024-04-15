part of 'deck_detail_bloc.dart';

sealed class DeckDetailEvent extends Equatable {
  const DeckDetailEvent();

  @override
  List<Object> get props => [];
}

final class DeckDetailRequested extends DeckDetailEvent {
  final int deckId;

  const DeckDetailRequested({required this.deckId});

  @override
  List<Object> get props => [deckId];
}
