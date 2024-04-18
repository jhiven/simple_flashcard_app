import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:simple_flashcard/data/provider/local/card_item.dart';
import 'package:simple_flashcard/data/provider/local/deck.dart';
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
            await validateDatabaseSchema();
          }
          await customStatement('PRAGMA foreign_keys = ON');
        },
        onCreate: (m) async {
          await m.createAll();

          final manifestoId = await into(deck).insert(
            DeckCompanion.insert(
              title: 'Agile manifesto',
              cardTotal: const Value(8),
              cardLeft: const Value(8),
            ),
          );

          await batch((batch) {
            batch.insertAll(
              cardItem,
              [
                CardItemCompanion.insert(
                  deckId: manifestoId,
                  front: 'Agile manifesto no 1',
                  back: 'Individuals and interactions',
                ),
                CardItemCompanion.insert(
                  deckId: manifestoId,
                  front: 'Agile manifesto no 2',
                  back: 'Working software',
                ),
                CardItemCompanion.insert(
                  deckId: manifestoId,
                  front: 'Agile manifesto no 3',
                  back: 'Customer collaboration',
                ),
                CardItemCompanion.insert(
                  deckId: manifestoId,
                  front: 'Agile manifesto no 4',
                  back: 'Responding to change',
                ),
                CardItemCompanion.insert(
                  deckId: manifestoId,
                  front: 'Individuals and interaction over...',
                  back: 'Tool and processes',
                ),
                CardItemCompanion.insert(
                  deckId: manifestoId,
                  front: 'Working software over...',
                  back: 'Comprehensive documentation',
                ),
                CardItemCompanion.insert(
                  deckId: manifestoId,
                  front: 'Customer collaboration over...',
                  back: 'Contract and negotiation',
                ),
                CardItemCompanion.insert(
                  deckId: manifestoId,
                  front: 'Responding to change over...',
                  back: 'Following plan',
                ),
              ],
            );
          });
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
    return transaction(() async {
      await (update(deck)..where((tbl) => tbl.id.equals(entry.deckId.value)))
          .write(
        DeckCompanion.custom(
          cardLeft: deck.cardLeft + const Constant(1),
          cardTotal: deck.cardTotal + const Constant(1),
        ),
      );
      return await into(cardItem).insert(entry);
    });
    // return into(cardItem).insert(entry);
  }

  Future<bool> nextCard(CardItemCompanion entry) {
    return transaction(() async {
      await update(deck).write(
        DeckCompanion.custom(
          cardLeft: deck.cardLeft - const Constant(1),
        ),
      );
      return await updateCardItem(
        entry.copyWith(
          answeredAt: Value(DateTime.now()),
        ),
      );
    });
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

    return NativeDatabase.createInBackground(file, logStatements: true);
  });
}
