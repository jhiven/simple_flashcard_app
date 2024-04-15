part of 'card_detail_bloc.dart';

enum CardDetailStatus { initial, success, failure }

final class CardDetailState extends Equatable {
  final CardModel? card;
  final CardDetailStatus status;

  const CardDetailState({
    this.card,
    this.status = CardDetailStatus.initial,
  });

  CardDetailState copyWith({
    CardModel? card,
    CardDetailStatus? status,
  }) {
    return CardDetailState(
      card: card ?? this.card,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [card, status];
}

final class CardDetailInitial extends CardDetailState {}
