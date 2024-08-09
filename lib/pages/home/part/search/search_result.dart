part of '../../home_page.dart';

class _SearchResult extends StatelessWidget {
  const _SearchResult();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return switch (state.searchStatus) {
          DataStatus.init => const SizedBox.shrink(),
          DataStatus.loading => const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CupertinoActivityIndicator(
                  radius: 11.0,
                ),
              ),
            ),
          DataStatus.loaded => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    AppStrings.searchListTitle,
                    style: AppTextStyles.regular16(
                      color: AppColors.accentColor,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => _ListSearchItem(
                      onTap: () => context.read<HomePageCubit>().toggleFavorite(state.searchResult[index]),
                      data: state.searchResult[index],
                      inFavorite: state.favoriteSet.contains(state.searchResult[index].url),
                    ),
                    itemCount: state.searchResult.length,
                  ),
                ),
              ],
            ),
          DataStatus.error => Center(
              child: Text(
                state.messageError ?? '',
                style: AppTextStyles.semiBold16(
                  color: AppColors.systemError,
                ),
              ),
            ),
        };
      },
    );
  }
}
