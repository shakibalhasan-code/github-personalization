import 'package:logger/logger.dart';
import '../../core/api/github_api_service.dart';
import '../local/local_storage.dart';
import '../models/repository_model.dart';

class GithubRepository {
  final GithubApiService _apiService;
  final LocalStorage _localStorage;
  final Logger _logger = Logger();

  GithubRepository({GithubApiService? apiService, LocalStorage? localStorage})
    : _apiService = apiService ?? GithubApiService(),
      _localStorage = localStorage ?? LocalStorage();

  /// Search repositories with offline fallback
  Future<RepositorySearchResponse?> searchRepositories({
    required String query,
    String sort = 'stars',
    String order = 'desc',
    int perPage = 50,
    int page = 1,
  }) async {
    try {
      _logger.i('Repository: Searching repositories for "$query"');

      final response = await _apiService.searchRepositories(
        query: query,
        sort: sort,
        order: order,
        perPage: perPage,
        page: page,
      );

      if (response != null && response.items.isNotEmpty) {
        // Save to local storage for offline access
        await _localStorage.saveRepositories(response.items);
        _logger.i(
          'Repository: Saved ${response.items.length} repositories to local storage',
        );
      }

      return response;
    } catch (e) {
      _logger.e('Repository: Error searching repositories - $e');

      // Fallback to local storage if API fails
      final cachedRepos = _localStorage.getRepositories();
      if (cachedRepos.isNotEmpty) {
        _logger.i(
          'Repository: Returning ${cachedRepos.length} cached repositories',
        );
        return RepositorySearchResponse(
          totalCount: cachedRepos.length,
          incompleteResults: false,
          items: cachedRepos,
        );
      }

      return null;
    }
  }

  /// Get repository details with offline fallback
  Future<GithubRepo?> getRepositoryDetails({
    required String owner,
    required String repo,
  }) async {
    try {
      _logger.i('Repository: Fetching details for $owner/$repo');

      final repository = await _apiService.getRepositoryDetails(
        owner: owner,
        repo: repo,
      );

      if (repository != null) {
        // Update in local storage if exists
        await _updateRepositoryInCache(repository);
      }

      return repository;
    } catch (e) {
      _logger.e('Repository: Error fetching repository details - $e');

      // Try to get from cache
      final cachedRepo = _getRepositoryFromCache(owner, repo);
      return cachedRepo;
    }
  }

  /// Get cached repositories
  List<GithubRepo> getCachedRepositories() {
    try {
      return _localStorage.getRepositories();
    } catch (e) {
      _logger.e('Repository: Error getting cached repositories - $e');
      return [];
    }
  }

  /// Clear cached repositories
  Future<void> clearCache() async {
    try {
      await _localStorage.clearRepositories();
      _logger.i('Repository: Cache cleared');
    } catch (e) {
      _logger.e('Repository: Error clearing cache - $e');
    }
  }

  /// Update repository in cache
  Future<void> _updateRepositoryInCache(GithubRepo repository) async {
    try {
      final cached = _localStorage.getRepositories();
      final index = cached.indexWhere((r) => r.id == repository.id);

      if (index != -1) {
        cached[index] = repository;
        await _localStorage.saveRepositories(cached);
        _logger.i('Repository: Updated ${repository.fullName} in cache');
      }
    } catch (e) {
      _logger.e('Repository: Error updating cache - $e');
    }
  }

  /// Get repository from cache
  GithubRepo? _getRepositoryFromCache(String owner, String repo) {
    try {
      final cached = _localStorage.getRepositories();
      final fullName = '$owner/$repo';

      return cached.firstWhere(
        (r) => r.fullName.toLowerCase() == fullName.toLowerCase(),
        orElse: () => throw Exception('Not found in cache'),
      );
    } catch (e) {
      _logger.w('Repository: $owner/$repo not found in cache');
      return null;
    }
  }
}
