import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/themes/app_colors.dart';
import '../../../core/utils/themes/app_styles.dart';
import '../../../data/models/repository_model.dart';

class RepositoryCard extends StatelessWidget {
  final GithubRepo repository;
  final VoidCallback onTap;

  const RepositoryCard({
    super.key,
    required this.repository,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRepositoryHeader(),
              SizedBox(height: 8.h),
              _buildRepositoryDescription(),
              SizedBox(height: 12.h),
              _buildRepositoryStats(),
            ],
          ),
        ),
      ),
    );
  }

  /// Repository Header (Name and Owner)
  Widget _buildRepositoryHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundImage: NetworkImage(repository.owner.avatarUrl),
          backgroundColor: AppColors.lightPrimaryContainer,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repository.name,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              Text(
                repository.fullName,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.lightOutline,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 16.r,
          color: AppColors.lightOutline,
        ),
      ],
    );
  }

  /// Repository Description
  Widget _buildRepositoryDescription() {
    return Text(
      repository.description.isNotEmpty
          ? repository.description
          : 'No description available',
      style: AppTextStyles.bodyMedium,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Repository Statistics (Stars, Forks, Language)
  Widget _buildRepositoryStats() {
    return Row(
      children: [
        _buildStatItem(Icons.star, repository.formattedStars),
        SizedBox(width: 16.w),
        _buildStatItem(Icons.fork_right, repository.formattedForks),
        if (repository.language.isNotEmpty)
          _buildLanguageTag(repository.language),
      ],
    );
  }

  /// Individual Stat Item
  Widget _buildStatItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 16.r, color: AppColors.lightOutline),
        SizedBox(width: 4.w),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.lightOutline,
          ),
        ),
      ],
    );
  }

  /// Language Tag
  Widget _buildLanguageTag(String language) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.lightPrimaryContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        language,
        style: AppTextStyles.labelSmall.copyWith(color: AppColors.lightPrimary),
      ),
    );
  }
}
