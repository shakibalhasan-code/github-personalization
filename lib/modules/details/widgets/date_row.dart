import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/themes/app_colors.dart';
import '../../../core/utils/themes/app_styles.dart';

class DateRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String date;

  const DateRow({
    super.key,
    required this.icon,
    required this.label,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, size: 20.r, color: AppColors.lightOutline),
          SizedBox(width: 12.w),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.lightOutline,
            ),
          ),
          const Spacer(),
          Text(
            date,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
