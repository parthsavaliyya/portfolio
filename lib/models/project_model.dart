class ProjectModel {
  final String title;
  final String description;
  final String company;
  final List<String> techStack;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final bool isIosExclusive;
  final bool isFeatured;
  final String emoji;
  final String gradientStart;
  final String gradientEnd;
  final String? bannerImagePathLight;
  final String? bannerImagePathDark;
  final String? companyLogoPath; // asset path for company logo

  const ProjectModel({
    required this.title,
    required this.description,
    required this.company,
    required this.techStack,
    this.appStoreUrl,
    this.playStoreUrl,
    this.isIosExclusive = false,
    this.isFeatured = false,
    required this.emoji,
    required this.gradientStart,
    required this.gradientEnd,
    this.bannerImagePathLight,
    this.bannerImagePathDark,
    this.companyLogoPath,
  });
}
