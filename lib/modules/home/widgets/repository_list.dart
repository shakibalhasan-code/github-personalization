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
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: 10, // TODO: Replace with controller.repositories.length
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return RepositoryCard(
              index: index,
              onTap: () => controller.navigateToDetails(index),
            );
          },
        );
      }),
    );
  }
}
