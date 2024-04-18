import 'package:equatable/equatable.dart';
import 'package:simple_flashcard/data/provider/local/drift_database.dart';

class DeckModel extends Equatable {
  final int id;
  final String title;
  final int cardTotal;
  final int cardLeft;
  final DateTime createdAt;

  const DeckModel({
    required this.id,
    required this.title,
    required this.cardTotal,
    required this.cardLeft,
    required this.createdAt,
  });

  factory DeckModel.fromDeckData(DeckData deckData) {
    return DeckModel(
      id: deckData.id,
      title: deckData.title,
      createdAt: deckData.createdAt,
      cardTotal: deckData.cardTotal,
      cardLeft: deckData.cardLeft,
    );
  }

  DeckModel copyWith({
    int? id,
    String? title,
    DateTime? createdAt,
    int? cardTotal,
    int? cardLeft,
  }) {
    return DeckModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      cardTotal: cardTotal ?? this.cardTotal,
      cardLeft: cardLeft ?? this.cardTotal,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        cardTotal,
        cardLeft,
      ];
}
