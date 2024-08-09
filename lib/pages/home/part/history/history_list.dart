part of '../../home_page.dart';

class _HistoryList extends StatelessWidget {
  final ValueChanged<String> onSelect;
  const _HistoryList({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return switch (state.historiesStatus) {
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
                    AppStrings.historyListTitle,
                    style: AppTextStyles.regular16(
                      color: AppColors.accentColor,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => ListHistoryItem(
                      data: state.histories[index],
                      onTap: () => onSelect(state.histories[index].searchQuery),
                    ),
                    itemCount: state.histories.length,
                  ),
                ),
              ],
            ),
          DataStatus.error => throw UnimplementedError(),
        };
      },
    );
  }
}
