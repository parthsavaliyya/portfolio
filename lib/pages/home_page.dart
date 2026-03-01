import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../sections/contact_section.dart';
import '../sections/experience_section.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../theme/app_theme.dart';
import '../widgets/navbar.dart';

/// Minimum layout width — below this the content scrolls horizontally
const double kMinLayoutWidth = 360;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final layoutWidth =
        screenWidth < kMinLayoutWidth ? kMinLayoutWidth : screenWidth;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        // Horizontal scroll kicks in ONLY when window < kMinLayoutWidth.
        // The entire Stack (including Positioned navbar) is inside this scroll,
        // so no widget — including the navbar — ever renders narrower than 360px.
        scrollDirection: Axis.horizontal,
        physics: screenWidth < kMinLayoutWidth
            ? const ClampingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: layoutWidth,
            maxWidth: layoutWidth,
          ),
          child: Stack(
            children: [
              // Background — animated only in light mode
              isDark ? _buildDarkBg(context) : _buildLightAnimatedBg(context),

              // Main vertical scroll content
              SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  children: const [
                    HeroSection(),
                    ExperienceSection(),
                    ProjectsSection(),
                    SkillsSection(),
                    ContactSection(),
                  ],
                ),
              ),

              // Floating Navbar (on top)
              const PortfolioNavbar(),

              // Back to Top FAB
              Obx(
                () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  right: 24,
                  bottom: controller.showBackToTop.value ? 24 : -80,
                  child: _BackToTopButton(controller: controller),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Static subtle orbs for dark mode (unchanged from before)
  Widget _buildDarkBg(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: -150,
            left: -150,
            child: Container(
              width: 500,
              height: 500,
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
          Positioned(
            top: 200,
            right: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.darkGreen.withOpacity(0.10),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 800,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
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
        ],
      ),
    );
  }

  /// Animated floating orbs for light mode only — drawn via CustomPainter
  /// so they are guaranteed to fill the full screen.
  Widget _buildLightAnimatedBg(BuildContext context) {
    return Positioned.fill(
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _bgController,
          builder: (context, _) {
            return CustomPaint(
              painter: _LightBgPainter(_bgController.value),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

/// CustomPainter that draws animated radial-gradient orbs across the full canvas.
/// Only used in light mode.
class _LightBgPainter extends CustomPainter {
  final double t; // 0.0 → 1.0 (animation value)
  _LightBgPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final wave = sin(t * pi); // smooth 0 → 1 → 0
    final w = size.width;
    final h = size.height;

    // Pre-build green paints at different opacities
    void drawOrb(Offset center, double radius, Color color) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [color, Colors.transparent],
          stops: const [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
    }

    // Orb 1 — top-left, drifts right+down
    drawOrb(
      Offset(-60 + wave * 80, -60 + wave * 80),
      280,
      AppColors.green.withOpacity(0.22),
    );

    // Orb 2 — top-right, counter drift
    drawOrb(
      Offset(w + 100 - wave * 100, 80 + wave * 60),
      320,
      AppColors.darkGreen.withOpacity(0.18),
    );

    // Orb 3 — mid-left, vertical bob
    drawOrb(
      Offset(-40, h * 0.4 + wave * 100),
      260,
      AppColors.green.withOpacity(0.16),
    );

    // Orb 4 — mid-right, opposite bob
    drawOrb(
      Offset(w + 60 - wave * 60, h * 0.55 - wave * 80),
      300,
      AppColors.darkGreen.withOpacity(0.14),
    );

    // Orb 5 — bottom-left, slow up
    drawOrb(
      Offset(w * 0.15 + wave * 40, h * 0.75 - wave * 60),
      240,
      AppColors.green.withOpacity(0.12),
    );

    // Orb 6 — bottom-center, subtle pulse
    drawOrb(
      Offset(w * 0.55, h * 0.85 + wave * 40),
      200,
      AppColors.darkGreen.withOpacity(0.10),
    );
  }

  @override
  bool shouldRepaint(_LightBgPainter old) => old.t != t;
}

class _BackToTopButton extends StatelessWidget {
  final PortfolioController controller;

  const _BackToTopButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.scrollToTop,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.green, AppColors.darkGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.green.withOpacity(0.4),
              blurRadius: 16,
              spreadRadius: -4,
            ),
          ],
        ),
        child: const Icon(
          Icons.keyboard_arrow_up_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.3));
  }
}
