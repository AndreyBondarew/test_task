import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:test_task/exceptions/app_http_exception.dart';
import 'package:test_task/models/github_repository_data.dart';
import 'package:test_task/resource/server_settings.dart';

class GithubApiRepository {
  final Dio dio = Dio();

  Future<List<GithubRepositoryDataModel>> getGithubRepositories(String searchQuery) async {
    final List<GithubRepositoryDataModel> result = [];
    try {
      final response = await dio.get(
        ServerSettings.serverUrl,
        queryParameters: {
          'q': searchQuery,
          'per_page': ServerSettings.resultCount,
        },
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final items = response.data['items'];
        for (final item in items) {
          result.add(
            GithubRepositoryDataModel(
              name: item['name'],
              url: item['html_url'],
            ),
          );
        }
        return result;
      } else {
        throw AppHttpException(
          errorCode: response.statusCode,
          message: response.statusMessage,
        );
      }
    } catch (e, stackTrace) {
      log('‼️ Error! $e ($stackTrace)');
      rethrow;
    }
  }
}
