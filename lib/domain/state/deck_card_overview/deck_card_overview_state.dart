part of 'deck_card_overview_bloc.dart';

enum DeckCardOverViewStatus { initial, success, failure }

final class DeckCardOverviewState extends Equatable {
  final DeckModel? deck;
  final List<CardModel>? newCardList;
  final List<CardModel>? repeatedCardList;
  final CardModel? currentCard;
  final DeckCardOverViewStatus status;
  final bool isOpen;

  const DeckCardOverviewState({
    this.deck,
    this.newCardList,
    this.repeatedCardList,
    this.currentCard,
    this.isOpen = false,
    this.status = DeckCardOverViewStatus.initial,
  });

  DeckCardOverviewState copyWith({
    DeckModel? deck,
    List<CardModel>? newCardList,
    List<CardModel>? repeatedCardList,
    ValueGetter<CardModel?>? currentCard,
    DeckCardOverViewStatus? status,
    bool? isOpen,
  }) {
    return DeckCardOverviewState(
      deck: deck ?? this.deck,
      newCardList: newCardList ?? this.newCardList,
      repeatedCardList: repeatedCardList ?? this.repeatedCardList,
      currentCard: currentCard != null ? currentCard() : this.currentCard,
      status: status ?? this.status,
      isOpen: isOpen ?? this.isOpen,
    );
  }

  @override
  List<Object?> get props => [
        deck,
        newCardList,
        repeatedCardList,
        status,
        currentCard,
        isOpen,
      ];
}

final class DeckCardOverviewInitial extends DeckCardOverviewState {}
