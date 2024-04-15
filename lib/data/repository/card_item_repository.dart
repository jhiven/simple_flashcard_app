import 'package:simple_flashcard/data/provider/local/drift_database.dart';

class CardItemRepository {
  final AppDatabase _db;

  CardItemRepository({
    required AppDatabase db,
  }) : _db = db;

  Future<List<CardItemData>> getAllCardItems() => _db.getAllCardItems();

  Future<List<CardItemData>> getCardItemsByDeckId(int deckId) =>
      _db.getCardItemsByDeckId(deckId);

  Stream<List<CardItemData>> watchCardItemsByDeckId(int deckId) =>
      _db.watchCardItemsByDeckId(deckId);

  Stream<CardItemData> watchCardItem(int id) => _db.watchCardItem(id);

  Future<CardItemData> getCardItem(int id) => _db.getCardItem(id);

  Future<int> addCardItem(CardItemCompanion entry) => _db.addCardItem(entry);

  Future<bool> updateCardItem(CardItemCompanion entry) =>
      _db.updateCardItem(entry);

  Future<int> deleteCardItem(int id) => _db.deleteCardItem(id);
}
