part of '../favorite_page.dart';

class _FavoriteListItem extends StatelessWidget {
  final GithubRepositoryDataModel data;

  const _FavoriteListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SwipeWidget(
        key: ValueKey(data.id!),
        onDelete: () => context.read<FavoritePageCubit>().deleteFavorite(data.id!),
        secondChild: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.systemError,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: SvgPicture.asset(Assets.iconsDelete),
            ),
          ),
        ),
        isAvailableDelete: true,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.layer2Color,
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    data.name,
                    style: AppTextStyles.regular14(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SvgPicture.asset(
                  Assets.iconsFavoriteGreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
