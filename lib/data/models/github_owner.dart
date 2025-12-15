class GithubOwner {
  final int id;
  final String login;
  final String avatarUrl;
  final String htmlUrl;

  GithubOwner({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
  });

  factory GithubOwner.fromJson(Map<String, dynamic> json) {
    return GithubOwner(
      id: json['id'],
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
    );
  }
}
