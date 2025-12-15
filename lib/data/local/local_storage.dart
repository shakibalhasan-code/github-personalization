import 'package:get_storage/get_storage.dart';
import 'package:github_per/data/models/repository_model.dart';

class LocalStorage {
  final GetStorage _box = GetStorage();
  static const String _reposKey = 'repos';

  /// Save repositories to local storage
  Future<void> saveRepositories(List<GithubRepo> repos) async {
    try {
      final data = repos.map((e) => e.toJson()).toList();
      await _box.write(_reposKey, data);
    } catch (e) {
      throw Exception('Failed to save repositories: $e');
    }
  }

  /// Get repositories from local storage
  List<GithubRepo> getRepositories() {
    try {
      final data = _box.read(_reposKey);
      if (data == null || data is! List) {
        return [];
      }
      return data.map<GithubRepo>((e) => GithubRepo.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Clear repositories from local storage
  Future<void> clearRepositories() async {
    try {
      await _box.remove(_reposKey);
    } catch (e) {
      throw Exception('Failed to clear repositories: $e');
    }
  }

  /// Check if repositories are cached
  bool hasRepositories() {
    return _box.hasData(_reposKey);
  }
}
