part of 'card_detail_bloc.dart';

sealed class CardDetailEvent extends Equatable {
  const CardDetailEvent();

  @override
  List<Object> get props => [];
}

final class CardDetailRequested extends CardDetailEvent {
  final int cardId;

  const CardDetailRequested({required this.cardId});

  @override
  List<Object> get props => [cardId];
}
