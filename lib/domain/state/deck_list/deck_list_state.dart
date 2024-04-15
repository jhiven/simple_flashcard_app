part of 'deck_list_bloc.dart';

sealed class DeckListState extends Equatable {
  const DeckListState();

  @override
  List<Object> get props => [];
}

final class DeckListInitial extends DeckListState {}

final class DeckListSuccess extends DeckListState {
  final List<DeckModel> deckList;

  const DeckListSuccess({required this.deckList});

  @override
  List<Object> get props => [deckList];
}

final class DeckListFailure extends DeckListState {
  final String errorMsg;

  const DeckListFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
