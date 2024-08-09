import 'dart:async';

import 'package:drift/drift.dart';
import 'package:test_task/db/daos/extensions/history_extensios.dart';
import 'package:test_task/db/database.dart';
import 'package:test_task/db/tables/history_table.dart';
import 'package:test_task/models/history_model.dart';

part 'history_dao.g.dart';

@DriftAccessor(
  tables: [HistoriesTable],
)
class HistoryDao extends DatabaseAccessor<Database> with _$HistoryDaoMixin {
  HistoryDao(super.attachedDatabase);

  final StreamController<HistoryModel?> _changeDataEvent = StreamController.broadcast();

  Future<HistoryModel?> saveHistory({required HistoryModel history}) async {
    try {
      final res = (await (into(historiesTable).insertReturning(history.toCompanion()))).toModel();
      _changeDataEvent.add(res);
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<List<HistoryModel>> getHistories() async {
    return (await (select(historiesTable)
              ..orderBy(
                [
                  (t) => OrderingTerm(
                        expression: t.id,
                        mode: OrderingMode.desc,
                      ),
                ],
              ))
            .get())
        .map(
          (e) => e.toModel(),
        )
        .toList();
  }

  Future<bool> deleteHistory({required int historyId}) async {
    final res = (await (delete(historiesTable)
              ..where(
                (tbl) => tbl.id.equals(historyId),
              ))
            .go()) >
        0;
    if (res) {
      _changeDataEvent.add(null);
    }
    return res;
  }

  Stream<HistoryModel?> get changeDataStream => _changeDataEvent.stream;
}
