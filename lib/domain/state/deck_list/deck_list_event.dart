part of 'deck_list_bloc.dart';

sealed class DeckListEvent extends Equatable {
  const DeckListEvent();

  @override
  List<Object> get props => [];
}

class DeckListFetchRequested extends DeckListEvent {}
