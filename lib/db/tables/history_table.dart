import 'package:drift/drift.dart';

@DataClassName('HistoryTable')
class HistoriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get searchQuery => text().unique()();
}
