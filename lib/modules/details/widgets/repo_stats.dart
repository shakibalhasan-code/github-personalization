import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/themes/app_colors.dart';
import '../../../data/models/repository_model.dart';
import 'stat_card.dart';

class RepoStats extends StatelessWidget {
  final GithubRepo repository;

  const RepoStats({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StatCard(
            icon: Icons.star,
            label: 'Stars',
            value: repository.formattedStars,
            color: Colors.amber,
          ),
          StatCard(
            icon: Icons.fork_right,
            label: 'Forks',
            value: repository.formattedForks,
            color: AppColors.lightPrimary,
          ),
          StatCard(
            icon: Icons.visibility,
            label: 'Watchers',
            value: repository.watchersCount.toString(),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
