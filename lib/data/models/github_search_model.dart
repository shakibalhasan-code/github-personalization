import 'package:github_per/data/models/repository_model.dart';

class GithubSearchResponse {
  final int totalCount;
  final List<GithubRepo> items;

  GithubSearchResponse({required this.totalCount, required this.items});

  factory GithubSearchResponse.fromJson(Map<String, dynamic> json) {
    return GithubSearchResponse(
      totalCount: json['total_count'] ?? 0,
      items: (json['items'] as List)
          .map((e) => GithubRepo.fromJson(e))
          .toList(),
    );
  }
}
