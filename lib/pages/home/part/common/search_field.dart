part of '../../home_page.dart';

class _SearchField extends StatelessWidget {
  final FocusNode? searchFieldFocusNode;
  final TextEditingController searchFieldController;

  const _SearchField({
    required this.searchFieldFocusNode,
    required this.searchFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      buildWhen: (previous, current) => previous.searchFieldHasFocus != current.searchFieldHasFocus,
      builder: (context, state) {
        return TextField(
          focusNode: searchFieldFocusNode,
          style: AppTextStyles.regular14(),
          onChanged: (value) => context.read<HomePageCubit>().onChangeQuery(
                value,
              ),
          onSubmitted: (value) => context.read<HomePageCubit>().submittedSearchQuery(value),
          controller: searchFieldController,
          decoration: InputDecoration(
            filled: true,
            fillColor: state.searchFieldHasFocus ? AppColors.layer3Color : AppColors.layer2Color,
            hintText: state.searchFieldHasFocus ? null : AppStrings.searchFieldHint,
            hintStyle: AppTextStyles.regular14(
              color: AppColors.textPlaceholder,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(6.0),
              child: AnimatedContainer(
                duration: kThemeAnimationDuration,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.layer1Color.withOpacity(state.searchFieldHasFocus ? 0 : 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    Assets.iconsSearch,
                  ),
                ),
              ),
            ),
            suffixIcon: AnimatedOpacity(
              duration: kThemeAnimationDuration,
              opacity: state.searchFieldHasFocus ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30.0),
                  onTap: state.searchFieldHasFocus
                      ? () {
                          searchFieldController.text = '';
                          context.read<HomePageCubit>().onChangeQuery('');
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(Assets.iconsClose),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
