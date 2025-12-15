import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../data/models/repository_model.dart';
import '../data/repository/github_read_repo.dart';
import '../modules/details/repo_details_view.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final String defaultKeyword = 'flutter';
  final Logger _logger = Logger();
  final GithubRepository _repository = GithubRepository();

  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<GithubRepo> repositories = <GithubRepo>[].obs;
  final RxInt totalCount = 0.obs;
  final RxInt currentPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    // Load default repositories on init
    searchRepositories(defaultKeyword);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Clear search input
  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  /// Handle search input change
  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  /// Perform repository search
  Future<void> searchRepositories(String keyword) async {
    try {
      final searchTerm = keyword.trim().isEmpty
          ? defaultKeyword
          : keyword.trim();

      _logger.i('Searching repositories for: $searchTerm');

      // Set loading state
      isLoading.value = true;
      currentPage.value = 1;

      // Call repository (which uses API with offline fallback)
      final response = await _repository.searchRepositories(
        query: searchTerm,
        sort: 'stars',
        order: 'desc',
        perPage: 50,
        page: currentPage.value,
      );

      if (response != null) {
        repositories.value = response.items;
        totalCount.value = response.totalCount;

        _logger.i('Found ${response.items.length} repositories');

        if (response.items.isEmpty) {
          Get.snackbar(
            'No Results',
            'No repositories found for "$searchTerm"',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
        }
      } else {
        repositories.clear();
        totalCount.value = 0;
      }
    } catch (e) {
      _logger.e('Error in searchRepositories: $e');
      repositories.clear();
      totalCount.value = 0;

      Get.snackbar(
        'Error',
        'Failed to search repositories',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Load more repositories (pagination)
  Future<void> loadMoreRepositories() async {
    if (isLoading.value) return;

    try {
      final searchTerm = searchQuery.value.isEmpty
          ? defaultKeyword
          : searchQuery.value;

      _logger.i('Loading more repositories, page: ${currentPage.value + 1}');

      isLoading.value = true;
      currentPage.value++;

      final response = await _repository.searchRepositories(
        query: searchTerm,
        sort: 'stars',
        order: 'desc',
        perPage: 50,
        page: currentPage.value,
      );

      if (response != null && response.items.isNotEmpty) {
        repositories.addAll(response.items);
        _logger.i('Loaded ${response.items.length} more repositories');
      }
    } catch (e) {
      _logger.e('Error loading more repositories: $e');
      currentPage.value--; // Revert page number on error
    } finally {
      isLoading.value = false;
    }
  }

  /// Navigate to repository details
  void navigateToDetails(GithubRepo repository) {
    _logger.i('Navigate to repository: ${repository.fullName}');

    Get.to(
      () => RepoDetailsView(repository: repository),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Refresh repositories
  Future<void> refreshRepositories() async {
    final searchTerm = searchQuery.value.isEmpty
        ? defaultKeyword
        : searchQuery.value;
    await searchRepositories(searchTerm);
  }
}
