import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/models/github_repository_data.dart';
import 'package:test_task/models/history_model.dart';
import 'package:test_task/pages/favorite/favorite_page.dart';
import 'package:test_task/pages/home/cubits/home_page_cubit.dart';
import 'package:test_task/resource/app_colors.dart';
import 'package:test_task/resource/app_strings.dart';
import 'package:test_task/resource/app_text_styles.dart';
import 'package:test_task/resource/assets.dart';
import 'package:test_task/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:test_task/widgets/swipe_widget/swipe_widget.dart';

part 'part/common/empty_data.dart';
part 'part/common/search_field.dart';
part 'part/history/history_list.dart';
part 'part/history/list_history_item.dart';
part 'part/search/list_search_item.dart';
part 'part/search/search_result.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FocusNode? searchFieldFocusNode;
  late final TextEditingController searchFieldController;
  late final HomePageCubit _homePageCubit;

  @override
  void initState() {
    super.initState();
    searchFieldController = TextEditingController();
    _homePageCubit = HomePageCubit(
      favoriteDao: context.read(),
      githubApiRepository: context.read(),
      historyDao: context.read(),
    );
    searchFieldFocusNode = FocusNode()
      ..addListener(
        () => _homePageCubit.changeFocus(
          searchFieldFocusNode!.hasFocus,
        ),
      );
  }

  @override
  void dispose() {
    searchFieldFocusNode?.dispose();
    searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          AppStrings.homeTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.semiBold16(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 14,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(24.0),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              ),
              child: SvgPicture.asset(
                Assets.iconsFavoriteButton,
              ),
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => _homePageCubit..loadHistory(),
        child: BlocListener<HomePageCubit, HomePageState>(
          listenWhen: (previous, current) => previous.messageError != current.messageError,
          listener: (context, state) {
            if (state.messageError?.isNotEmpty ?? false) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.iconPrimary,
                  content: Text(
                    state.messageError!,
                    style: AppTextStyles.semiBold16(
                      color: AppColors.systemError,
                    ),
                  ),
                ),
              );
            }
          },
          child: Stack(
            /*
          Since in Figma the text about empty data is centered
          relative to the screen height rather than in the center
          of the empty space, I had to use a Stack. In a real
          project, I would probably ask the designer how critical
          this positioning is, or if I can place this text in the
          center of the available space, so I don’t have to use a Stack.
          */
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    children: [
                      _SearchField(
                        searchFieldFocusNode: searchFieldFocusNode,
                        searchFieldController: searchFieldController,
                      ),
                      Expanded(
                        child: BlocBuilder<HomePageCubit, HomePageState>(
                          builder: (context, state) {
                            return state.pageContent == PageContent.searchResult
                                ? const _SearchResult()
                                : _HistoryList(
                                    onSelect: (value) {
                                      searchFieldController.text = value;
                                      context.read<HomePageCubit>().onChangeQuery(value);
                                    },
                                  );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _EmptyDataDispatcher(),
            ],
          ),
        ),
      ),
    );
  }
}
