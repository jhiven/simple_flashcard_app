part of 'deck_detail_bloc.dart';

enum DeckDetailStatus { initial, success, failure }

final class DeckDetailState extends Equatable {
  final DeckModel? deck;
  final DeckDetailStatus status;

  const DeckDetailState({
    this.deck,
    this.status = DeckDetailStatus.initial,
  });

  DeckDetailState copyWith({
    DeckModel? deck,
    DeckDetailStatus? status,
  }) {
    return DeckDetailState(
      deck: deck ?? this.deck,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [deck, status];
}

final class DeckDetailInitial extends DeckDetailState {}
