import 'package:drift/drift.dart';
import 'package:test_task/db/database.dart';
import 'package:test_task/models/github_repository_data.dart';

extension GithubDataModelToCompanion on GithubRepositoryDataModel {
  FavoritesTableCompanion toCompanion() => FavoritesTableCompanion(
        id: id == null ? const Value.absent() : Value(id!),
        name: Value(name),
        url: Value(url),
      );
}

extension FavoriteTableToModel on FavoriteTable {
  GithubRepositoryDataModel toModel() => GithubRepositoryDataModel(
        id: id,
        name: name,
        url: url,
      );
}
