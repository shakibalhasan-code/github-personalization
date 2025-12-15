class GithubLicense {
  final String key;
  final String name;
  final String spdxId;
  final String url;

  GithubLicense({
    required this.key,
    required this.name,
    required this.spdxId,
    required this.url,
  });

  factory GithubLicense.fromJson(Map<String, dynamic> json) {
    return GithubLicense(
      key: json['key'] ?? '',
      name: json['name'] ?? '',
      spdxId: json['spdx_id'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
