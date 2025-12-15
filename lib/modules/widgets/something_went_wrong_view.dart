import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/themes/app_styles.dart';

class SomethingWentWrongView extends StatelessWidget {
  String? message;
  SomethingWentWrongView({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.redAccent, size: 64.r),
          SizedBox(height: 16.h),
          Text(
            'Something went wrong!',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),

          message != null
              ? Text(
                  message!,
                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                )
              : SizedBox(),

          SizedBox(height: 8.h),
          Text(
            'Please try again later.',
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
