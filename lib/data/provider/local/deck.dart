import 'package:drift/drift.dart';

class Deck extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 64)();
  IntColumn get cardTotal => integer().withDefault(const Constant(0))();
  IntColumn get cardLeft => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
