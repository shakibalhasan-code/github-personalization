import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/themes/app_colors.dart';
import '../../../core/utils/themes/app_styles.dart';
import '../../../data/models/repository_model.dart';

class RepoHeader extends StatelessWidget {
  final GithubRepo repository;

  const RepoHeader({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundImage: NetworkImage(repository.owner.avatarUrl),
            backgroundColor: AppColors.lightPrimaryContainer,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  repository.name,
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  repository.fullName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.lightOutline,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'by ${repository.owner.login}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.lightPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
