import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/db/daos/favorite_dao.dart';
import 'package:test_task/models/github_repository_data.dart';

part 'favorite_page_state.dart';

class FavoritePageCubit extends Cubit<FavoritePageState> {
  final FavoriteDao _favoriteDao;
  StreamSubscription? _favoriteSubscription;

  FavoritePageCubit({required FavoriteDao favoriteDao})
      : _favoriteDao = favoriteDao,
        super(FavoritePageState.init()) {
    _favoriteSubscription = _favoriteDao.changeDataStream.listen(
      (event) {
        loadFavorite();
      },
    );
  }

  @override
  Future<Function> close() async {
    _favoriteSubscription?.cancel();
    return super.close;
  }

  Future<void> loadFavorite() async {
    emit(state.copyWith(pageStatus: PageStatus.loading));
    final favorites = await _favoriteDao.getFavorites();
    emit(
      state.copyWith(
        pageStatus: PageStatus.loaded,
        favorites: favorites,
      ),
    );
  }

  Future<void> deleteFavorite(int favoriteId) async {
    await _favoriteDao.deleteFavorite(favoriteId);
  }
}
