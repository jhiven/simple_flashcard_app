part of 'card_list_bloc.dart';

sealed class CardListState extends Equatable {
  const CardListState();

  @override
  List<Object> get props => [];
}

final class CardListInitial extends CardListState {}

final class CardListSuccess extends CardListState {
  final List<CardModel> cardList;

  const CardListSuccess({required this.cardList});

  CardListSuccess copyWith({
    List<CardModel>? cardList,
  }) {
    return CardListSuccess(
      cardList: cardList ?? this.cardList,
    );
  }

  @override
  List<Object> get props => [cardList];
}

final class CardListFailure extends CardListState {
  final String errorMsg;

  const CardListFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
