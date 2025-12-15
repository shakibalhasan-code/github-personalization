import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_per/core/constant/app_constant.dart';
import 'package:github_per/core/utils/themes/app_styles.dart';
import 'package:github_per/controllers/home_controller.dart';
import 'widgets/repository_list.dart';
import 'widgets/search_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          SearchSection(
            searchController: controller.searchController,
            defaultKeyword: controller.defaultKeyword,
            onClear: controller.clearSearch,
            onChanged: controller.onSearchChanged,
            onSubmitted: controller.searchRepositories,
          ),
          RepositoryList(controller: controller),
        ],
      ),
    );
  }

  /// App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(AppConstant.appName, style: AppTextStyles.titleLarge),
      elevation: 0,
    );
  }
}
