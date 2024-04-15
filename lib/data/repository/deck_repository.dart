import 'package:simple_flashcard/data/provider/local/drift_database.dart';
import 'package:simple_flashcard/domain/models/deck_overview.dart';

class DeckRepository {
  final AppDatabase _db;

  DeckRepository({
    required AppDatabase db,
  }) : _db = db;

  Future<List<DeckData>> getAllDecks() => _db.getAllDecks();

  Stream<List<DeckData>> watchAllDecks() => _db.watchAllDecks();

  Stream<List<DeckOverview>> watchDeckOverview(int deckId) =>
      _db.watchDeckOverview(deckId);

  Stream<DeckData> watchDeck(int id) => _db.watchDeck(id);

  Future<DeckData> getDeck(int id) => _db.getDeck(id);

  Future<int> addDeck(DeckCompanion entry) => _db.addDeck(entry);

  Future<bool> updateDeck(DeckCompanion entry) => _db.updateDeck(entry);

  Future<int> deleteDeck(int id) => _db.deleteDeck(id);
}
