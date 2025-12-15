import 'dart:convert';
import 'package:github_per/core/constant/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../data/models/repository_model.dart';
import 'network_service.dart';

class GithubApiService {
  static final GithubApiService _instance = GithubApiService._internal();
  factory GithubApiService() => _instance;
  GithubApiService._internal();

  static const String baseUrl = AppConstant.baseUrl;
  final Logger _logger = Logger();
  final NetworkService _networkService = NetworkService();

  Future<RepositorySearchResponse?> searchRepositories({
    required String query,
    String sort = 'stars',
    String order = 'desc',
    int perPage = 50,
    int page = 1,
  }) async {
    try {
      // Check internet connectivity
      final hasConnection = await _networkService
          .checkConnectivityWithMessage();
      if (!hasConnection) {
        return null;
      }

      _logger.i('Searching repositories: $query');

      final uri = Uri.parse('$baseUrl/search/repositories').replace(
        queryParameters: {
          'q': query,
          'sort': sort,
          'order': order,
          'per_page': perPage.toString(),
          'page': page.toString(),
        },
      );

      final response = await http
          .get(uri, headers: {'Accept': 'application/vnd.github.v3+json'})
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception('Request timeout');
            },
          );

      if (response.statusCode == 200) {
        _logger.i('Repository search successful');
        final data = json.decode(response.body);
        return RepositorySearchResponse.fromJson(data);
      } else if (response.statusCode == 403) {
        _logger.w('API rate limit exceeded: ${response.statusCode}');
        _showErrorSnackbar(
          'Rate Limit Exceeded',
          'GitHub API rate limit reached. Please try again later.',
        );
        return null;
      } else {
        _logger.e('Repository search failed: ${response.statusCode}');
        _showErrorSnackbar(
          'Search Failed',
          'Unable to search repositories. Please try again.',
        );
        return null;
      }
    } catch (e) {
      _logger.e('Error searching repositories: $e');
      _showErrorSnackbar(
        'Error',
        'An error occurred while searching repositories.',
      );
      return null;
    }
  }

  Future<GithubRepo?> getRepositoryDetails({
    required String owner,
    required String repo,
  }) async {
    try {
      // Check internet connectivity
      final hasConnection = await _networkService
          .checkConnectivityWithMessage();
      if (!hasConnection) {
        return null;
      }

      _logger.i('Fetching repository details: $owner/$repo');

      final uri = Uri.parse('$baseUrl/repos/$owner/$repo');

      final response = await http
          .get(uri, headers: {'Accept': 'application/vnd.github.v3+json'})
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception('Request timeout');
            },
          );

      if (response.statusCode == 200) {
        _logger.i('Repository details fetched successfully');
        final data = json.decode(response.body);
        return GithubRepo.fromJson(data);
      } else if (response.statusCode == 404) {
        _logger.w('Repository not found: $owner/$repo');
        _showErrorSnackbar('Not Found', 'Repository not found.');
        return null;
      } else if (response.statusCode == 403) {
        _logger.w('API rate limit exceeded: ${response.statusCode}');
        _showErrorSnackbar(
          'Rate Limit Exceeded',
          'GitHub API rate limit reached. Please try again later.',
        );
        return null;
      } else {
        _logger.e('Failed to fetch repository details: ${response.statusCode}');
        _showErrorSnackbar('Error', 'Unable to fetch repository details.');
        return null;
      }
    } catch (e) {
      _logger.e('Error fetching repository details: $e');
      _showErrorSnackbar(
        'Error',
        'An error occurred while fetching repository details.',
      );
      return null;
    }
  }

  /// Show error snackbar
  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}
