part of 'favorite_page_cubit.dart';

enum PageStatus { init, loading, loaded, error }

class FavoritePageState {
  final List<GithubRepositoryDataModel> favorites;
  final PageStatus pageStatus;

  FavoritePageState({required this.favorites, required this.pageStatus});

  factory FavoritePageState.init() => FavoritePageState(
        favorites: [],
        pageStatus: PageStatus.init,
      );

  FavoritePageState copyWith({
    List<GithubRepositoryDataModel>? favorites,
    PageStatus? pageStatus,
  }) {
    return FavoritePageState(
      favorites: favorites ?? this.favorites,
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
