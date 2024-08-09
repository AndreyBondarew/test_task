import 'package:drift/drift.dart';

@DataClassName('FavoriteTable')
class FavoritesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get url => text()();
}
