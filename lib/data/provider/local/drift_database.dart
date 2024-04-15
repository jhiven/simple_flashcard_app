import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_flashcard/data/provider/local/card_item.dart';
import 'package:simple_flashcard/data/provider/local/deck.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:simple_flashcard/domain/models/deck_overview.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [CardItem, Deck])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          if (kDebugMode) {
            final m = createMigrator();
            for (final table in allTables) {
              await m.deleteTable(table.actualTableName);
              await m.createTable(table);
            }
          }
        },
      );

  Future<List<CardItemData>> getAllCardItems() {
    return select(cardItem).get();
  }

  Future<List<DeckData>> getAllDecks() {
    return select(deck).get();
  }

  Stream<List<DeckData>> watchAllDecks() {
    return select(deck).watch();
  }

  Stream<List<CardItemData>> watchCardItemsByDeckId(int deckId) {
    return (select(cardItem)..where((tbl) => tbl.deckId.equals(deckId)))
        .watch();
  }

  Future<DeckData> getDeck(int id) {
    return (select(deck)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Stream<DeckData> watchDeck(int id) {
    return (select(deck)..where((tbl) => tbl.id.equals(id))).watchSingle();
  }

  Stream<CardItemData> watchCardItem(int id) {
    return (select(cardItem)..where((tbl) => tbl.id.equals(id))).watchSingle();
  }

  Future<CardItemData> getCardItem(int id) {
    return (select(cardItem)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<List<CardItemData>> getCardItemsByDeckId(int deckId) {
    return (select(cardItem)..where((tbl) => tbl.deckId.equals(deckId))).get();
  }

  Future<int> addDeck(DeckCompanion entry) {
    return into(deck).insert(entry);
  }

  Future<int> addCardItem(CardItemCompanion entry) {
    return into(cardItem).insert(entry);
  }

  Future<bool> updateDeck(DeckCompanion entry) {
    return update(deck).replace(entry);
  }

  Stream<List<DeckOverview>> watchDeckOverview(int deckId) {
    final query = (select(deck)..where((tbl) => tbl.id.equals(deckId)))
        .join([innerJoin(cardItem, cardItem.deckId.equalsExp(deck.id))])
      ..where(cardItem.answeredAt.day.isSmallerThanValue(DateTime.now().day) |
          cardItem.answeredAt.isNull());

    return query.watch().map((rows) {
      return rows.map((row) {
        return DeckOverview(
          card: row.readTable(cardItem),
          deck: row.readTable(deck),
        );
      }).toList();
    });
  }

  Future<bool> updateCardItem(CardItemCompanion entry) {
    return update(cardItem).replace(entry);
  }

  Future<int> deleteDeck(int id) {
    return transaction(() async {
      await (delete(cardItem)..where((tbl) => tbl.deckId.equals(id))).go();

      return await (delete(deck)..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  Future<int> deleteCardItem(int id) {
    return (delete(cardItem)..where((tbl) => tbl.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
