part of 'card_edit_bloc.dart';

enum CardEditStatus { initial, success, failure }

final class CardEditState extends Equatable {
  final String front;
  final String back;
  final CardEditStatus status;

  const CardEditState({
    this.front = '',
    this.back = '',
    this.status = CardEditStatus.initial,
  });

  @override
  List<Object> get props => [front, back, status];

  CardEditState copyWith({
    String? front,
    String? back,
    CardEditStatus? status,
  }) {
    return CardEditState(
      front: front ?? this.front,
      back: back ?? this.back,
      status: status ?? this.status,
    );
  }
}

final class CardEditInitial extends CardEditState {}
