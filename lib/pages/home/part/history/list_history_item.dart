part of '../../home_page.dart';

class ListHistoryItem extends StatelessWidget {
  final HistoryModel data;
  final VoidCallback onTap;

  const ListHistoryItem({super.key, required this.data, required this.onTap});

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: onTap,
        child: SwipeWidget(
          key: ValueKey(data.id!),
          onDelete: () => context.read<HomePageCubit>().deleteHistory(data.id!),
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
                      data.searchQuery,
                      style: AppTextStyles.regular14(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
