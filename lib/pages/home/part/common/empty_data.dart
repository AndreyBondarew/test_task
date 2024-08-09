part of '../../home_page.dart';

class _EmptyDataDispatcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return state.pageContent == PageContent.searchResult
              ? _EmptySearchData(
                  isEmpty: state.searchResult.isEmpty &&
                      state.searchQuery.isNotEmpty &&
                      state.searchStatus != DataStatus.loading &&
                      state.searchStatus != DataStatus.error,
                )
              : _EmptyHistoryData(
                  isEmpty: state.histories.isEmpty && state.historiesStatus == DataStatus.loaded,
                );
        },
      ),
    );
  }
}

class _EmptySearchData extends StatelessWidget {
  final bool isEmpty;

  const _EmptySearchData({required this.isEmpty});

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SvgPicture.asset(
                  Assets.iconsNoResult,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  AppStrings.emptySearch,
                  style: AppTextStyles.regular14(
                    color: AppColors.textPlaceholder,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

class _EmptyHistoryData extends StatelessWidget {
  final bool isEmpty;

  const _EmptyHistoryData({required this.isEmpty});

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SvgPicture.asset(Assets.iconsNoResult),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  AppStrings.emptyHistory,
                  style: AppTextStyles.regular14(
                    color: AppColors.textPlaceholder,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
