import 'package:flutter/material.dart';
import 'package:test_task/pages/home/home_page.dart';
import 'package:test_task/pages/preloader/part/animated_preloader.dart';
import 'package:test_task/resource/app_colors.dart';
import 'package:test_task/resource/app_strings.dart';
import 'package:test_task/resource/app_text_styles.dart';

class PreloaderPage extends StatefulWidget {
  const PreloaderPage({super.key});

  @override
  State createState() => _PreloaderPageState();
}

class _PreloaderPageState extends State<PreloaderPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4)).then(
      (value) => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: AppColors.accentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.appTitle,
              style: AppTextStyles.semiBold16(
                color: AppColors.layer4Color,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: SizedBox(
                height: 50,
                child: AnimatedPreloader(
                  color: AppColors.layer4Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
