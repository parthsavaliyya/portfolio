import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../data/portfolio_data.dart';
import '../models/skill_model.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/parallax_widget.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;

    return Container(
      key: controller.skillsKey,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Parallax
          Positioned(
            top: 50,
            right: 0,
            child: ParallaxWidget(
              scrollController: controller.scrollController,
              speed: 0.12,
              child: Container(
                width: 350,
                height: 350,
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
            bottom: 50,
            left: -100,
            child: ParallaxWidget(
              scrollController: controller.scrollController,
              speed: 0.18,
              child: Container(
                width: 400,
                height: 400,
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
                _buildHeader(context),
                const SizedBox(height: 60),
                _buildSkillsGrid(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        const Text(
          '⚡ Tech Stack',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
        const SizedBox(height: 12),
        Text(
          'Technologies I work with every day',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.white60 : Colors.black45,
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

  Widget _buildSkillsGrid(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final crossAxis = size.width >= 1024
        ? 7
        : size.width >= 768
            ? 5
            : 3;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - (crossAxis - 1) * 16) / crossAxis;
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: PortfolioData.skills
              .asMap()
              .entries
              .map(
                (e) => SizedBox(
                  width: itemWidth,
                  child: _SkillCard(skill: e.value, index: e.key),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _SkillCard extends StatefulWidget {
  final SkillModel skill;
  final int index;

  const _SkillCard({required this.skill, required this.index});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  Widget _buildSkillImage() {
    final path = widget.skill.imagePath;
    if (path == null) {
      // Fallback: FontAwesome icon
      return Icon(
        widget.skill.icon,
        color: widget.skill.color,
        size: 28,
      );
    }

    if (path.endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        width: 28,
        height: 28,
        colorFilter: null, // keep original colors
        placeholderBuilder: (_) => Icon(
          widget.skill.icon,
          color: widget.skill.color,
          size: 28,
        ),
      );
    }

    return Image.asset(
      path,
      width: 28,
      height: 28,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(
        widget.skill.icon,
        color: widget.skill.color,
        size: 28,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Transform.scale(
        scale: _isHovered ? 1.08 : 1.0,
        child: GlassContainer(
          borderRadius: 16,
          blurSigma: 12,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.skill.color.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: -2,
                  ),
                ]
              : null,
          borderColor: _isHovered ? widget.skill.color.withOpacity(0.6) : null,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.skill.color.withOpacity(
                    _isHovered ? 0.2 : 0.1,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: widget.skill.color.withOpacity(0.3),
                            blurRadius: 16,
                            spreadRadius: -2,
                          ),
                        ]
                      : null,
                ),
                child: _buildSkillImage(),
              ),
              const SizedBox(height: 10),
              Text(
                widget.skill.name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      )
          .animate()
          .fadeIn(delay: (80 * widget.index).ms, duration: 500.ms)
          .scale(begin: const Offset(0.8, 0.8)),
    );
  }
}
