import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_task/pages/preloader/preloader_page.dart';
import 'package:test_task/resource/app_theme.dart';

import 'provider/main_provider.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      runApp(
        const MyApp(),
      );
    },
    (error, stack) {
      log('‼️ error: $error \n stack: $stack');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MainProvider(
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle.dark,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Github Search Demo',
            theme: AppTheme.light(context),
            home: const PreloaderPage(),
          ),
        ),
      ),
    );
  }
}
