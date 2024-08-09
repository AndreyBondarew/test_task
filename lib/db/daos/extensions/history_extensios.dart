import 'package:drift/drift.dart';
import 'package:test_task/db/database.dart';
import 'package:test_task/models/history_model.dart';

extension HistoryModelToCompanion on HistoryModel {
  HistoriesTableCompanion toCompanion() => HistoriesTableCompanion(
        id: id == null ? const Value.absent() : Value(id!),
        searchQuery: Value(searchQuery),
      );
}

extension HistoriTableToModel on HistoryTable {
  HistoryModel toModel() => HistoryModel(
        id: id,
        searchQuery: searchQuery,
      );
}
