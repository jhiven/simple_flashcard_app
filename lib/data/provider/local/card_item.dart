import 'package:drift/drift.dart';
import 'package:simple_flashcard/data/provider/local/deck.dart';

enum AnswerType { hard, easy }

class CardItem extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get deckId => integer().references(Deck, #id)();
  TextColumn get front => text().withLength(min: 1, max: 128)();
  TextColumn get back => text().withLength(min: 1)();
  IntColumn get answeredType => intEnum<AnswerType>().nullable()();
  DateTimeColumn get answeredAt => dateTime().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
