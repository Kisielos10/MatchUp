class Project {
  String projectName;
  int commitsPerWeek;
  List<String> topLanguages;
  int publicPullRequests;
  int stars;
  int followers;
  bool isProUser;

  Project({
    this.projectName = '',
    this.commitsPerWeek = 0,
    this.topLanguages = const [],
    this.publicPullRequests = 0,
    this.stars = 0,
    this.followers = 0,
    this.isProUser = false,
  });
}

