part of 'deck_card_overview_bloc.dart';

sealed class DeckCardOverviewEvent extends Equatable {
  const DeckCardOverviewEvent();

  @override
  List<Object> get props => [];
}

final class DeckCardOverviewFetchCards extends DeckCardOverviewEvent {
  final DeckModel deck;

  const DeckCardOverviewFetchCards({
    required this.deck,
  });

  @override
  List<Object> get props => [deck];
}

final class DeckCardOverviewHardCard extends DeckCardOverviewEvent {}

final class DeckCardOverviewEasyCard extends DeckCardOverviewEvent {}

final class DeckCardOverviewOpen extends DeckCardOverviewEvent {}
