import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import 'repository_card.dart';

class RepositoryList extends StatelessWidget {
  final HomeController controller;

  const RepositoryList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value && controller.repositories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.repositories.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64.r, color: Colors.grey),
                SizedBox(height: 16.h),
                Text(
                  'No repositories found',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshRepositories,
          child: ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.repositories.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final repository = controller.repositories[index];
              return RepositoryCard(
                repository: repository,
                onTap: () => controller.navigateToDetails(repository),
              );
            },
          ),
        );
      }),
    );
  }
}
