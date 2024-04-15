import 'package:equatable/equatable.dart';
import 'package:simple_flashcard/data/provider/local/drift_database.dart';

class DeckOverview extends Equatable {
  final CardItemData card;
  final DeckData deck;

  const DeckOverview({required this.card, required this.deck});

  @override
  List<Object?> get props => [card, deck];
}
