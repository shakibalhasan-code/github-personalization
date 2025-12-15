import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/themes/app_styles.dart';
import '../../../data/models/repository_model.dart';

class RepoDescription extends StatelessWidget {
  final GithubRepo repository;

  const RepoDescription({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            repository.description.isNotEmpty
                ? repository.description
                : 'No description available',
            style: AppTextStyles.bodyMedium,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
