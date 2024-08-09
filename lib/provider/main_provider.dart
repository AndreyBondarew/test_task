import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/db/daos/favorite_dao.dart';
import 'package:test_task/db/daos/history_dao.dart';
import 'package:test_task/db/database.dart';
import 'package:test_task/repositories/github_api.dart';

class MainProvider extends StatelessWidget {
  final Widget child;

  const MainProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => Database(),
        ),
        RepositoryProvider(
          create: (context) => FavoriteDao(
            context.read(),
          ),
        ),
        RepositoryProvider(
          create: (context) => GithubApiRepository(),
        ),
        RepositoryProvider(
          create: (context) => HistoryDao(
            context.read(),
          ),
        )
      ],
      child: child,
    );
  }
}
