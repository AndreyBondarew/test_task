import 'dart:async';

import 'package:drift/drift.dart';
import 'package:test_task/db/daos/extensions/favorite_extensions.dart';
import 'package:test_task/db/database.dart';
import 'package:test_task/db/tables/favorite_table.dart';
import 'package:test_task/models/github_repository_data.dart';

part 'favorite_dao.g.dart';

@DriftAccessor(
  tables: [FavoritesTable],
)
class FavoriteDao extends DatabaseAccessor<Database> with _$FavoriteDaoMixin {
  final StreamController<GithubRepositoryDataModel?> _changeDataEvent = StreamController.broadcast();
  FavoriteDao(super.attachedDatabase);

  Future<GithubRepositoryDataModel> createFavorite({required GithubRepositoryDataModel githubRepository}) async {
    final res = (await into(favoritesTable).insertReturning(githubRepository.toCompanion())).toModel();
    _changeDataEvent.add(res);
    return res;
  }

  Future<List<GithubRepositoryDataModel>> getFavorites() async {
    return (await (select(favoritesTable)).get())
        .map(
          (e) => e.toModel(),
        )
        .toList();
  }

  Future<bool> deleteFavorite(int favoriteId) async {
    final res = (await (delete(favoritesTable)
              ..where(
                (tbl) => tbl.id.equals(favoriteId),
              ))
            .go()) >
        0;
    if (res) {
      _changeDataEvent.add(null);
    }
    return res;
  }

  Stream<GithubRepositoryDataModel?> get changeDataStream => _changeDataEvent.stream;
}
