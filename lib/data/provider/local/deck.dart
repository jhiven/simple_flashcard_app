import 'package:drift/drift.dart';

class Deck extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 0, max: 32)();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
