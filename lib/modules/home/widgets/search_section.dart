import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/themes/app_colors.dart';
import '../../../core/utils/themes/app_styles.dart';

class SearchSection extends StatelessWidget {
  final TextEditingController searchController;
  final String defaultKeyword;
  final VoidCallback onClear;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  const SearchSection({
    super.key,
    required this.searchController,
    required this.defaultKeyword,
    required this.onClear,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Search Repositories', style: AppTextStyles.titleMedium),
          SizedBox(height: 12.h),
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Enter keyword (e.g., $defaultKeyword)',
              prefixIcon: Icon(Icons.search, size: 20.r),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, size: 20.r),
                      onPressed: onClear,
                    )
                  : null,
            ),
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
          SizedBox(height: 8.h),
          Text(
            'Default: $defaultKeyword',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.lightOutline,
            ),
          ),
        ],
      ),
    );
  }
}
