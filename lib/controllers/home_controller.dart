import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final String defaultKeyword = 'flutter';

  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList repositories = [].obs;

  @override
  void onInit() {
    super.onInit();
    // Load default repositories
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
  void searchRepositories(String keyword) {
    final searchTerm = keyword.isEmpty ? defaultKeyword : keyword;
    // TODO: Implement API call to search repositories
    debugPrint('Searching for: $searchTerm');

    // Placeholder: Set loading state
    isLoading.value = true;

    // TODO: Replace with actual API call
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      // repositories.value = fetchedData;
    });
  }

  /// Navigate to repository details
  void navigateToDetails(int index) {
    // TODO: Implement navigation to details screen
    debugPrint('Navigate to repository details: $index');
  }
}
