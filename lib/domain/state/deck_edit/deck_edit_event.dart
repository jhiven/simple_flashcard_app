part of 'deck_edit_bloc.dart';

sealed class DeckEditEvent extends Equatable {
  const DeckEditEvent();

  @override
  List<Object> get props => [];
}

final class DeckEditTitle extends DeckEditEvent {
  final String title;

  const DeckEditTitle({required this.title});

  @override
  List<Object> get props => [title];
}

final class DeckEditSubmitUpdate extends DeckEditEvent {
  final int deckId;

  const DeckEditSubmitUpdate({required this.deckId});

  @override
  List<Object> get props => [deckId];
}

final class DeckEditSubmitAdd extends DeckEditEvent {}
