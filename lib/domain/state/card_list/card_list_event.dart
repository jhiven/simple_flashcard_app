part of 'card_list_bloc.dart';

sealed class CardListEvent extends Equatable {
  const CardListEvent();

  @override
  List<Object> get props => [];
}

final class CardListRequested extends CardListEvent {
  final int deckId;

  const CardListRequested({required this.deckId});

  @override
  List<Object> get props => [deckId];
}

final class CardListDeckRequested extends CardListEvent {
  final int deckId;

  const CardListDeckRequested({required this.deckId});

  @override
  List<Object> get props => [deckId];
}
