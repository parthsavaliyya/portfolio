import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/portfolio_controller.dart';
import '../data/portfolio_data.dart';
import '../models/project_model.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/hover_widget.dart';
import '../widgets/parallax_widget.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;

    return Container(
      key: controller.projectsKey,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Parallax
          Positioned(
            top: 200,
            right: -100,
            child: ParallaxWidget(
              scrollController: controller.scrollController,
              speed: 0.1,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.green.withOpacity(0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 300,
            left: -150,
            child: ParallaxWidget(
              scrollController: controller.scrollController,
              speed: 0.2,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.darkGreen.withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 80 : 24,
              vertical: 80,
            ),
            child: Column(
              children: [
                const _SectionHeader(
                  emoji: '🛠️',
                  title: 'Featured Projects',
                  subtitle: 'Apps I\'ve built that make a difference',
                ),
                const SizedBox(height: 60),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 768;
                    if (isWide) {
                      // 2-column grid
                      return Column(
                        children: [
                          for (int i = 0;
                              i < PortfolioData.projects.length;
                              i += 2)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _ProjectCard(
                                      project: PortfolioData.projects[i],
                                      index: i,
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  if (i + 1 < PortfolioData.projects.length)
                                    Expanded(
                                      child: _ProjectCard(
                                        project: PortfolioData.projects[i + 1],
                                        index: i + 1,
                                      ),
                                    )
                                  else
                                    const Spacer(),
                                ],
                              ),
                            ),
                        ],
                      );
                    } else {
                      return Column(
                        children: PortfolioData.projects
                            .asMap()
                            .entries
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: _ProjectCard(
                                    project: e.value, index: e.key),
                              ),
                            )
                            .toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final int index;

  const _ProjectCard({required this.project, required this.index});

  Color _hexToColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xFF')));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return HoverWidget(
      builder: (isHovered) => GlassContainer(
        borderRadius: 24,
        blurSigma: 16,
        padding: const EdgeInsets.all(0),
        boxShadow: isHovered
            ? [
                BoxShadow(
                  color: _hexToColor(
                    project.gradientStart,
                  ).withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: -4,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
        borderColor: isHovered
            ? _hexToColor(project.gradientStart).withOpacity(0.5)
            : null,
        child: AnimatedContainer(
          duration: 200.ms,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient header with optional banner image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      _hexToColor(project.gradientStart),
                      _hexToColor(project.gradientEnd),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Banner image (if available)
                    if (isDark
                        ? project.bannerImagePathDark != null
                        : project.bannerImagePathLight != null)
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                        child: Image.asset(
                          (isDark
                              ? project.bannerImagePathDark
                              : project.bannerImagePathLight)!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      ),
                    // Gradient overlay for readability
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: Container(
                          // decoration: BoxDecoration(
                          //   gradient: LinearGradient(
                          //     colors: [
                          //       _hexToColor(project.gradientStart).withOpacity(
                          //         project.bannerImagePath != null ? 0.55 : 1.0,
                          //       ),
                          //       _hexToColor(project.gradientEnd).withOpacity(
                          //         project.bannerImagePath != null ? 0.75 : 1.0,
                          //       ),
                          //     ],
                          //     begin: Alignment.topCenter,
                          //     end: Alignment.bottomCenter,
                          //   ),
                          // ),
                          ),
                    ),
                    // Decorative circles (only when no banner)
                    if (isDark
                        ? project.bannerImagePathDark == null
                        : project.bannerImagePathLight == null) ...[
                      Positioned(
                        top: -30,
                        right: -30,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.12),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -20,
                        left: -20,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                      ),
                    ],
                    // Text content overlay
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Badges row (top-right only)
                          Row(
                            children: [
                              const Spacer(),
                              if (project.isFeatured && !project.isIosExclusive)
                                _FeaturedBadge(),
                            ],
                          ),
                          const Spacer(),
                          // Text(
                          //   project.title,
                          //   style: const TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.w800,
                          //     color: Colors.white,
                          //     letterSpacing: -0.3,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Body
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company logo row
                    if (project.companyLogoPath != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                project.companyLogoPath!,
                                height: 32,
                                width: 32,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: _hexToColor(project.gradientStart)
                                        .withOpacity(0.2),
                                  ),
                                  child: Icon(
                                    Icons.business_rounded,
                                    size: 18,
                                    color: _hexToColor(project.gradientStart),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: isDark
                                          ? Colors.white60
                                          : Colors.black45,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    project.company,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? Colors.white60
                                          : Colors.black45,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    Text(
                      project.description,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tech stack
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.techStack
                          .map(
                            (tech) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: _hexToColor(
                                  project.gradientStart,
                                ).withOpacity(0.15),
                                border: Border.all(
                                  color: _hexToColor(
                                    project.gradientStart,
                                  ).withOpacity(0.35),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                tech,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _hexToColor(project.gradientStart),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(height: 20),

                    // CTA Buttons
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        if (project.appStoreUrl != null)
                          _buildCTAButton(
                            label: 'App Store',
                            icon: FontAwesomeIcons.apple,
                            url: project.appStoreUrl!,
                            project: project,
                          ),
                        if (project.playStoreUrl != null)
                          _buildCTAButton(
                            label: 'Play Store',
                            icon: FontAwesomeIcons.googlePlay,
                            url: project.playStoreUrl!,
                            project: project,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: (150 * index).ms, duration: 600.ms)
        .slideY(begin: 0.2);
  }

  Widget _buildCTAButton({
    required String label,
    required IconData icon,
    required String url,
    required ProjectModel project,
  }) {
    return HoverWidget(
      builder: (btnHovered) => GestureDetector(
        onTap: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          }
        },
        child: AnimatedContainer(
          duration: 200.ms,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: btnHovered
                ? LinearGradient(
                    colors: [
                      _hexToColor(project.gradientStart),
                      _hexToColor(project.gradientEnd),
                    ],
                  )
                : null,
            border: btnHovered
                ? null
                : Border.all(
                    color: _hexToColor(project.gradientStart).withOpacity(0.5),
                    width: 1.5,
                  ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                icon,
                size: 16,
                color: btnHovered
                    ? Colors.white
                    : _hexToColor(project.gradientStart),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: btnHovered
                      ? Colors.white
                      : _hexToColor(project.gradientStart),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.green.withOpacity(0.15),
        border: Border.all(color: AppColors.green.withOpacity(0.4), width: 1),
      ),
      child: const Text(
        '⭐ Featured',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.darkGreen,
        ),
      ),
    );
  }
}

// Re-export _SectionHeader for use in other sections
class _SectionHeader extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;

  const _SectionHeader({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$emoji $title',
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white60
                : Colors.black45,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
        const SizedBox(height: 20),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(
              colors: [AppColors.green, AppColors.darkGreen],
            ),
          ),
        ).animate().scaleX(begin: 0, delay: 300.ms, duration: 600.ms),
      ],
    );
  }
}
