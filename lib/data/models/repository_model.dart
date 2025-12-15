import 'package:github_per/data/models/git_license_model.dart';
import 'package:github_per/data/models/github_owner.dart';

class GithubRepo {
  final int id;
  final String name;
  final String fullName;
  final String description;
  final String htmlUrl;
  final int stargazersCount;
  final int forksCount;
  final int watchersCount;
  final String language;
  final DateTime updatedAt;
  final DateTime createdAt;
  final DateTime pushedAt;
  final GithubOwner owner;
  final GithubLicense? license;
  final List<String> topics;

  GithubRepo({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.htmlUrl,
    required this.stargazersCount,
    required this.forksCount,
    required this.watchersCount,
    required this.language,
    required this.updatedAt,
    required this.createdAt,
    required this.pushedAt,
    required this.owner,
    required this.license,
    required this.topics,
  });

  factory GithubRepo.fromJson(Map<String, dynamic> json) {
    return GithubRepo(
      id: json['id'],
      name: json['name'] ?? '',
      fullName: json['full_name'] ?? '',
      description: json['description'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      stargazersCount: json['stargazers_count'] ?? 0,
      forksCount: json['forks_count'] ?? 0,
      watchersCount: json['watchers_count'] ?? 0,
      language: json['language'] ?? '',
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      pushedAt: DateTime.parse(json['pushed_at']),
      owner: GithubOwner.fromJson(json['owner']),
      license: json['license'] != null
          ? GithubLicense.fromJson(json['license'])
          : null,
      topics: json['topics'] != null ? List<String>.from(json['topics']) : [],
    );
  }

  /// Format star count for display (e.g., 1.2k, 10k)
  String get formattedStars {
    if (stargazersCount >= 1000) {
      return '${(stargazersCount / 1000).toStringAsFixed(1)}k';
    }
    return stargazersCount.toString();
  }

  /// Format fork count for display
  String get formattedForks {
    if (forksCount >= 1000) {
      return '${(forksCount / 1000).toStringAsFixed(1)}k';
    }
    return forksCount.toString();
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'description': description,
      'html_url': htmlUrl,
      'stargazers_count': stargazersCount,
      'forks_count': forksCount,
      'watchers_count': watchersCount,
      'language': language,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'pushed_at': pushedAt.toIso8601String(),
      'owner': owner,
      'license': license,
      'topics': topics,
    };
  }
}

class RepositorySearchResponse {
  final int totalCount;
  final bool incompleteResults;
  final List<GithubRepo> items;

  RepositorySearchResponse({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  factory RepositorySearchResponse.fromJson(Map<String, dynamic> json) {
    return RepositorySearchResponse(
      totalCount: json['total_count'] ?? 0,
      incompleteResults: json['incomplete_results'] ?? false,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((item) => GithubRepo.fromJson(item))
              .toList() ??
          [],
    );
  }
}
