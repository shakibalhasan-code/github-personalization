import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/themes/app_styles.dart';
import '../../../data/models/repository_model.dart';
import 'info_row.dart';

class RepoMetadata extends StatelessWidget {
  final GithubRepo repository;

  const RepoMetadata({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Repository Info',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          if (repository.language.isNotEmpty)
            InfoRow(
              icon: Icons.code,
              label: 'Language',
              value: repository.language,
            ),
          if (repository.license != null)
            InfoRow(
              icon: Icons.gavel,
              label: 'License',
              value: repository.license!.name,
            ),
          InfoRow(
            icon: Icons.link,
            label: 'URL',
            value: repository.htmlUrl,
            isLink: true,
          ),
        ],
      ),
    );
  }
}
