import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/resource/app_colors.dart';
import 'package:test_task/resource/assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? title;

  const CustomAppBar({
    Key? key,
    this.actions,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowPrimary,
            blurRadius: 20.0,
            offset: Offset(0, 6.0),
          ),
          BoxShadow(
            color: AppColors.shadowSecondary,
            blurRadius: 6.0,
          )
        ],
      ),
      child: AppBar(
        actions: actions,
        title: title,
        centerTitle: true,
        leading: (Navigator.of(context).canPop())
            ? Padding(
                padding: const EdgeInsets.only(
                  //vertical: 8.0,
                  left: 14.0,
                ),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(
                    Assets.iconsBackButton,
                  ),
                ),
              )
            : null,
        surfaceTintColor: AppColors.backgroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
