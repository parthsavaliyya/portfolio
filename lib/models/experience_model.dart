class ExperienceModel {
  final String company;
  final String role;
  final String duration;
  final String location;
  final List<String> highlights;
  final bool isCurrent;
  final String emoji;
  final String? companyLogoPath; // optional local asset for company logo

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.duration,
    required this.location,
    required this.highlights,
    this.isCurrent = false,
    required this.emoji,
    this.companyLogoPath,
  });
}
