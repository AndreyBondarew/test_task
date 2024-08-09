part of 'home_page_cubit.dart';

enum DataStatus { init, loading, loaded, error }

enum PageContent { history, searchResult }

class HomePageState {
  final bool searchFieldHasFocus;
  final String searchQuery;
  final List<HistoryModel> histories;
  final List<GithubRepositoryDataModel> searchResult;
  final Set favoriteSet;
  final List<GithubRepositoryDataModel> favoriteList;
  final DataStatus historiesStatus;
  final DataStatus searchStatus;
  final String? messageError;

  HomePageState({
    required this.searchFieldHasFocus,
    required this.histories,
    required this.searchResult,
    required this.searchQuery,
    required this.historiesStatus,
    required this.searchStatus,
    required this.favoriteSet,
    required this.favoriteList,
    this.messageError,
  });

  factory HomePageState.init() => HomePageState(
        searchFieldHasFocus: false,
        searchQuery: '',
        histories: [],
        searchResult: [],
        favoriteList: [],
        favoriteSet: {},
        historiesStatus: DataStatus.init,
        searchStatus: DataStatus.init,
      );

  PageContent get pageContent {
    if (searchFieldHasFocus || searchQuery.isNotEmpty) {
      return PageContent.searchResult;
    }
    return PageContent.history;
  }

  HomePageState copyWith({
    bool? searchFieldHasFocus,
    String? searchQuery,
    List<HistoryModel>? histories,
    List<GithubRepositoryDataModel>? searchResult,
    Set? favoriteSet,
    List<GithubRepositoryDataModel>? favoriteList,
    DataStatus? historiesStatus,
    DataStatus? searchStatus,
    String? messageError,
  }) {
    return HomePageState(
      searchFieldHasFocus: searchFieldHasFocus ?? this.searchFieldHasFocus,
      searchQuery: searchQuery ?? this.searchQuery,
      histories: histories ?? this.histories,
      searchResult: searchResult ?? this.searchResult,
      favoriteSet: favoriteSet ?? this.favoriteSet,
      favoriteList: favoriteList ?? this.favoriteList,
      historiesStatus: historiesStatus ?? this.historiesStatus,
      searchStatus: searchStatus ?? this.searchStatus,
      messageError: messageError ?? this.messageError,
    );
  }
}
