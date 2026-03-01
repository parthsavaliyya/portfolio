import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../data/portfolio_data.dart';
import '../models/experience_model.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/parallax_widget.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;

    return Container(
      key: controller.experienceKey,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Parallax
          Positioned(
            top: 100,
            left: -50,
            child: ParallaxWidget(
              scrollController: controller.scrollController,
              speed: 0.15,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.green.withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            right: -80,
            child: ParallaxWidget(
              scrollController: controller.scrollController,
              speed: 0.25,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.darkGreen.withOpacity(0.06),
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
                _SectionHeader(
                  emoji: '🏢',
                  title: 'Work Experience',
                  subtitle: 'My professional journey building Flutter apps',
                ),
                const SizedBox(height: 60),
                ...PortfolioData.experiences.asMap().entries.map((entry) {
                  return _TimelineItem(
                    experience: entry.value,
                    index: entry.key,
                    isLast: entry.key == PortfolioData.experiences.length - 1,
                    isDark: isDark,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

class _TimelineItem extends StatelessWidget {
  final ExperienceModel experience;
  final int index;
  final bool isLast;
  final bool isDark;

  const _TimelineItem({
    required this.experience,
    required this.index,
    required this.isLast,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final isEven = index % 2 == 0;
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator column (dot + line)
          SizedBox(
            width: 36,
            child: Column(
              children: [
                _TimelineDot(isCurrent: experience.isCurrent),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 380,
                    color: AppColors.green.withValues(alpha: 0.3),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Card — fully flexible, no height constraint
          Expanded(
            child: GlassContainer(
              margin: EdgeInsets.only(
                bottom: 24,
                left: isDesktop && !isEven ? 40 : 0,
                right: isDesktop && isEven ? 40 : 0,
              ),
              borderRadius: 20,
              padding: const EdgeInsets.all(24),
              child: _buildContent(context),
            )
                .animate()
                .fadeIn(delay: (200 * index).ms, duration: 600.ms)
                .slideX(begin: isEven ? -0.15 : 0.15),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Company logo or emoji fallback
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isDark
                    ? Colors.white.withOpacity(0.07)
                    : Colors.black.withOpacity(0.05),
              ),
              clipBehavior: Clip.antiAlias,
              child: experience.companyLogoPath != null
                  ? Image.asset(
                      experience.companyLogoPath!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: Text(
                          experience.emoji,
                          style: const TextStyle(fontSize: 26),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        experience.emoji,
                        style: const TextStyle(fontSize: 26),
                      ),
                    ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          experience.company,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      if (experience.isCurrent) ...[
                        const SizedBox(width: 8),
                        _NewBadge(),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    experience.role,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Duration + Location — wraps on narrow cards
        Wrap(
          spacing: 12,
          runSpacing: 4,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    experience.duration,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white54 : Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on_outlined,
                    size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    experience.location,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        const Divider(height: 24, thickness: 0.5),

        // Highlights
        ...experience.highlights
            .map(
              (h) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: experience.isCurrent
                            ? AppColors.green
                            : AppColors.darkGreen,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        h,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}

class _TimelineDot extends StatelessWidget {
  final bool isCurrent;
  const _TimelineDot({required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isCurrent ? AppColors.green : AppColors.darkGreen.withOpacity(0.6),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: AppColors.green.withOpacity(0.5),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : null,
        border: Border.all(
          color: isCurrent ? AppColors.green : AppColors.darkGreen,
          width: 2,
        ),
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [AppColors.green, AppColors.darkGreen],
        ),
      ),
      child: const Text(
        'Present',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.3));
  }
}
