part of '../../home_page.dart';

class _ListSearchItem extends StatelessWidget {
  final GithubRepositoryDataModel data;
  final bool? inFavorite;
  final VoidCallback onTap;

  const _ListSearchItem({required this.data, this.inFavorite, required this.onTap});

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: onTap,
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
                if (inFavorite != null)
                  SvgPicture.asset(
                    inFavorite! ? Assets.iconsFavoriteGreen : Assets.iconsFavorite,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
