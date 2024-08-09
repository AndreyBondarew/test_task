import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/db/daos/favorite_dao.dart';
import 'package:test_task/db/daos/history_dao.dart';
import 'package:test_task/exceptions/app_http_exception.dart';
import 'package:test_task/models/github_repository_data.dart';
import 'package:test_task/models/history_model.dart';
import 'package:test_task/repositories/github_api.dart';
import 'package:test_task/resource/app_strings.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  bool searchInProgress = false;
  Timer? _debounce;
  StreamSubscription? historySubscription;
  StreamSubscription? favoriteSubscription;
  final FavoriteDao _favoriteDao;
  final GithubApiRepository _githubApiRepository;
  final HistoryDao _historyDao;

  HomePageCubit(
      {required FavoriteDao favoriteDao,
      required GithubApiRepository githubApiRepository,
      required HistoryDao historyDao})
      : _historyDao = historyDao,
        _githubApiRepository = githubApiRepository,
        _favoriteDao = favoriteDao,
        super(HomePageState.init()) {
    historySubscription = _historyDao.changeDataStream.listen(
      (event) => loadHistory(),
    );
    favoriteSubscription = _favoriteDao.changeDataStream.listen(
      (event) {
        _loadFavorites();
      },
    );
  }

  @override
  Future<Function> close() async {
    historySubscription?.cancel();
    favoriteSubscription?.cancel();
    return super.close;
  }

  Future<void> changeFocus(bool? searchFieldHasFocus) async {
    emit(
      state.copyWith(
        searchFieldHasFocus: searchFieldHasFocus,
      ),
    );
    if (!(searchFieldHasFocus ?? true) && state.searchQuery.isNotEmpty) {
      await _historyDao.saveHistory(history: HistoryModel(searchQuery: state.searchQuery));
    }
  }

  Future<void> submittedSearchQuery(String searchQuery) async {
    if (searchQuery.isNotEmpty) {
      await _historyDao.saveHistory(history: HistoryModel(searchQuery: state.searchQuery));
    }
    emit(state.copyWith(searchQuery: searchQuery));
  }

  void onChangeQuery(String newQuery) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    if (newQuery.isNotEmpty) {
      emit(
        state.copyWith(
          searchStatus: DataStatus.loading,
          searchQuery: newQuery,
        ),
      );
      _debounce = Timer(
        const Duration(milliseconds: 500),
        () async {
          try {
            final searchResult = await _githubApiRepository.getGithubRepositories(
              newQuery,
            );
            emit(
              state.copyWith(
                searchStatus: DataStatus.loaded,
                searchResult: searchResult,
              ),
            );
          } catch (e) {
            _handleError(e);
          }
        },
      );
    } else {
      emit(
        state.copyWith(
          searchQuery: newQuery,
          searchStatus: DataStatus.loaded,
          searchResult: [],
        ),
      );
    }
  }

  Future<void> loadHistory() async {
    emit(state.copyWith(historiesStatus: DataStatus.loading));
    final histories = await _historyDao.getHistories();
    emit(
      state.copyWith(
        histories: histories,
        historiesStatus: DataStatus.loaded,
      ),
    );
  }

  Future<void> deleteHistory(int historyId) async {
    await _historyDao.deleteHistory(historyId: historyId);
  }

  Future<void> toggleFavorite(GithubRepositoryDataModel searchResult) async {
    if (state.favoriteSet.contains(searchResult.url)) {
      final favorite = state.favoriteList
          .where(
            (element) => element.url == searchResult.url,
          )
          .first;
      await _favoriteDao.deleteFavorite(favorite.id!);
    } else {
      await _favoriteDao.createFavorite(githubRepository: searchResult);
    }
  }

  Future<void> _loadFavorites() async {
    final res = (await _favoriteDao.getFavorites());
    emit(
      state.copyWith(
        favoriteSet: res
            .map(
              (e) => e.url,
            )
            .toSet(),
        favoriteList: res,
      ),
    );
  }

  void _clearError() {
    emit(state.copyWith(messageError: '', searchStatus: DataStatus.init));
  }

  void _handleError(Object e) {
    if (e is AppHttpException) {
      final errorCode = e.errorCode ?? 0;
      if (errorCode == 0) {
        emit(state.copyWith(searchStatus: DataStatus.error, messageError: AppStrings.unknownError));
      } else if (errorCode >= 300 && errorCode < 400) {
        emit(
            state.copyWith(searchStatus: DataStatus.error, messageError: '${AppStrings.redirectionError}: $errorCode'));
      } else if (errorCode >= 400 && errorCode < 500) {
        emit(state.copyWith(searchStatus: DataStatus.error, messageError: '${AppStrings.clientError}: $errorCode'));
      } else if (errorCode >= 500) {
        emit(state.copyWith(searchStatus: DataStatus.error, messageError: '${AppStrings.serverError}: $errorCode'));
      }
    } else {
      emit(state.copyWith(searchStatus: DataStatus.error, messageError: AppStrings.connectionError));
    }
    Future.delayed(Duration.zero).then(
      (value) => _clearError(),
    );
  }
}
