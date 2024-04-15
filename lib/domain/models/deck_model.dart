import 'package:equatable/equatable.dart';
import 'package:simple_flashcard/data/provider/local/drift_database.dart';

class DeckModel extends Equatable {
  final int id;
  final String title;
  final DateTime createdAt;

  const DeckModel({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory DeckModel.fromDeckData(DeckData deckData) {
    return DeckModel(
      id: deckData.id,
      title: deckData.title,
      createdAt: deckData.createdAt,
    );
  }

  DeckModel copyWith({
    int? id,
    String? title,
    DateTime? createdAt,
  }) {
    return DeckModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
      ];
}
