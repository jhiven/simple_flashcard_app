part of 'card_edit_bloc.dart';

sealed class CardEditEvent extends Equatable {
  const CardEditEvent();

  @override
  List<Object> get props => [];
}

final class CardEditFront extends CardEditEvent {
  final String front;

  const CardEditFront({required this.front});

  @override
  List<Object> get props => [front];
}

final class CardEditBack extends CardEditEvent {
  final String back;

  const CardEditBack({required this.back});

  @override
  List<Object> get props => [back];
}

final class CardEditSubmitUpdate extends CardEditEvent {
  final CardModel card;

  const CardEditSubmitUpdate({required this.card});

  @override
  List<Object> get props => [card];
}

final class CardEditSubmitAdd extends CardEditEvent {
  final int deckId;

  const CardEditSubmitAdd({required this.deckId});

  @override
  List<Object> get props => [deckId];
}
