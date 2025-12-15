import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/themes/app_styles.dart';
import '../../../data/models/repository_model.dart';
import 'date_row.dart';

class RepoDates extends StatelessWidget {
  final GithubRepo repository;

  const RepoDates({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Timeline',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          DateRow(
            icon: Icons.add_circle_outline,
            label: 'Created',
            date: dateFormat.format(repository.createdAt),
          ),
          DateRow(
            icon: Icons.update,
            label: 'Last Updated',
            date: dateFormat.format(repository.updatedAt),
          ),
          DateRow(
            icon: Icons.push_pin,
            label: 'Last Pushed',
            date: dateFormat.format(repository.pushedAt),
          ),
        ],
      ),
    );
  }
}
