import 'package:equatable/equatable.dart';
import 'package:simple_flashcard/data/provider/local/card_item.dart';
import 'package:simple_flashcard/data/provider/local/drift_database.dart';

class CardModel extends Equatable {
  final int id;
  final int deckId;
  final String front;
  final String back;
  final AnswerType? answerType;
  final DateTime? answerAt;
  final DateTime createdAt;

  const CardModel({
    required this.id,
    required this.deckId,
    required this.front,
    required this.back,
    this.answerType,
    this.answerAt,
    required this.createdAt,
  });

  factory CardModel.fromCardItemData(CardItemData cardItemData) {
    return CardModel(
      id: cardItemData.id,
      deckId: cardItemData.deckId,
      front: cardItemData.front,
      back: cardItemData.back,
      answerType: cardItemData.answeredType,
      answerAt: cardItemData.answeredAt,
      createdAt: cardItemData.createdAt,
    );
  }

  CardModel copyWith({
    int? id,
    int? deckId,
    String? front,
    String? back,
    AnswerType? answerType,
    DateTime? answerAt,
    DateTime? createdAt,
  }) {
    return CardModel(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      front: front ?? this.front,
      back: back ?? this.back,
      answerType: answerType ?? this.answerType,
      answerAt: answerAt ?? this.answerAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        deckId,
        front,
        back,
        answerType,
        answerAt,
        createdAt,
      ];
}
