import 'package:flutter/material.dart';
import '../../core/utils/themes/app_styles.dart';
import '../../data/models/repository_model.dart';
import 'widgets/repo_header.dart';
import 'widgets/repo_description.dart';
import 'widgets/repo_stats.dart';
import 'widgets/repo_metadata.dart';
import 'widgets/repo_topics.dart';
import 'widgets/repo_dates.dart';

class RepoDetailsView extends StatelessWidget {
  final GithubRepo repository;

  const RepoDetailsView({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RepoHeader(repository: repository),
            RepoDescription(repository: repository),
            RepoStats(repository: repository),
            RepoMetadata(repository: repository),
            if (repository.topics.isNotEmpty)
              RepoTopics(repository: repository),
            RepoDates(repository: repository),
          ],
        ),
      ),
    );
  }

  /// App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(repository.name, style: AppTextStyles.titleLarge),
      elevation: 0,
    );
  }
}
