part of 'card_list_bloc.dart';

sealed class CardListState extends Equatable {
  const CardListState();

  @override
  List<Object> get props => [];
}

final class CardListInitial extends CardListState {}

final class CardListSuccess extends CardListState {
  final DeckModel deck;
  final List<CardModel> cardList;

  const CardListSuccess({required this.cardList, required this.deck});

  CardListSuccess copyWith({
    DeckModel? deck,
    List<CardModel>? cardList,
  }) {
    return CardListSuccess(
      cardList: cardList ?? this.cardList,
      deck: deck ?? this.deck,
    );
  }

  @override
  List<Object> get props => [cardList, deck];
}

final class CardListFailure extends CardListState {
  final String errorMsg;

  const CardListFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
