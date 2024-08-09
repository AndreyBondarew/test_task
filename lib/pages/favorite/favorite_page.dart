import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/models/github_repository_data.dart';
import 'package:test_task/pages/favorite/cubits/favorite_page_cubit.dart';
import 'package:test_task/resource/app_colors.dart';
import 'package:test_task/resource/app_strings.dart';
import 'package:test_task/resource/app_text_styles.dart';
import 'package:test_task/resource/assets.dart';
import 'package:test_task/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:test_task/widgets/swipe_widget/swipe_widget.dart';

part 'part/favorite_list_item.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          AppStrings.favoriteTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.semiBold16(),
        ),
      ),
      body: BlocProvider(
        create: (context) => FavoritePageCubit(
          favoriteDao: context.read(),
        )..loadFavorite(),
        child: BlocBuilder<FavoritePageCubit, FavoritePageState>(
          builder: (context, state) {
            return Stack(
              children: [
                SafeArea(
                  child: switch (state.pageStatus) {
                    PageStatus.init => const SizedBox.shrink(),
                    PageStatus.loading => const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CupertinoActivityIndicator(
                            radius: 11.0,
                          ),
                        ),
                      ),
                    PageStatus.loaded => ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25.0,
                          horizontal: 16.0,
                        ),
                        itemBuilder: (context, index) => _FavoriteListItem(
                          data: state.favorites[index],
                        ),
                        itemCount: state.favorites.length,
                      ),
                    // TODO: Handle this case.
                    PageStatus.error => throw UnimplementedError(),
                  },
                ),
                Center(
                  child: state.pageStatus == PageStatus.loaded && state.favorites.isEmpty
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
                                AppStrings.emptyFavorite,
                                style: AppTextStyles.regular14(
                                  color: AppColors.textPlaceholder,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
