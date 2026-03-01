import 'dart:math';
import '../services/resume_download_stub.dart'
    if (dart.library.js_interop) '../services/resume_download_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/glass_container.dart';
import '../widgets/hover_widget.dart';
import '../widgets/parallax_widget.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _orbitController;
  late Map<String, String> _randomQuoteData;

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
    _randomQuoteData =
        PortfolioData.quotes[Random().nextInt(PortfolioData.quotes.length)];
  }

  @override
  void dispose() {
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;
    final isTablet = size.width >= 768 && size.width < 1024;

    return Container(
      key: controller.heroKey,
      constraints: BoxConstraints(minHeight: size.height),
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 80 : 24,
        100,
        isDesktop ? 80 : 24,
        60,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Parallax Elements
          Positioned(
            top: -50,
            right: -20,
            child: ParallaxWidget(
              scrollController: controller.scrollController,
              speed: 0.2,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.green.withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: -30,
            child: ParallaxWidget(
              scrollController: controller.scrollController,
              speed: 0.3,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.darkGreen.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          isDesktop || isTablet
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: ParallaxWidget(
                        scrollController: controller.scrollController,
                        speed: 0.05,
                        child: _buildTextContent(context),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: ParallaxWidget(
                        scrollController: controller.scrollController,
                        speed: 0.1,
                        child: _buildImageContent(context),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildTextContent(context),
                    const SizedBox(height: 48),
                    _buildImageContent(context),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Badge
        GlassContainer(
          borderRadius: 100,
          padding: const EdgeInsets.fromLTRB(14, 10, 20, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animated Pulse

              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "“${_randomQuoteData['quote']!}”",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "— ${_randomQuoteData['author']!}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: AppColors.green.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 800.ms)
            .slideX(begin: -0.2, curve: Curves.easeOutBack),

        const SizedBox(height: 24),

        // Hi line
        Text(
          'Hi, I\'m',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: isDark
                ? Colors.white.withOpacity(0.7)
                : Colors.black.withOpacity(0.55),
          ),
        )
            .animate()
            .fadeIn(delay: 400.ms, duration: 800.ms)
            .slideX(begin: -0.2, curve: Curves.easeOutBack),

        // Name
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.green, AppColors.darkGreen],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: const Text(
            'PARTH\nSAVALIYA',
            style: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.05,
              letterSpacing: -2,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 600.ms, duration: 1000.ms)
            .slideX(begin: -0.2, curve: Curves.easeOutBack),

        const SizedBox(height: 16),

        // Role
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.green.withOpacity(0.10),
            border: Border.all(
              color: AppColors.green.withOpacity(0.35),
              width: 1,
            ),
          ),
          child: const Text(
            '3+ Years Experience',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.green,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 800.ms, duration: 800.ms)
            .slideX(begin: -0.2, curve: Curves.easeOutBack),

        const SizedBox(height: 20),

        // Sub text
        Text(
          'Crafting beautiful, high-performance Flutter apps.\nSpecializing in iOS & Android with a passion for\nAI-powered products and stunning UI experiences.',
          style: TextStyle(
            fontSize: 16,
            height: 1.7,
            fontWeight: FontWeight.w400,
            color: isDark
                ? Colors.white.withOpacity(0.65)
                : Colors.black.withOpacity(0.55),
          ),
        )
            .animate()
            .fadeIn(delay: 1000.ms, duration: 800.ms)
            .blur(begin: const Offset(10, 10), end: Offset.zero),

        const SizedBox(height: 40),

        // CTAs
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _buildCTA(
              context,
              label: 'View Projects',
              icon: Icons.rocket_launch_rounded,
              isPrimary: true,
              onTap: () => Get.find<PortfolioController>().scrollToSection(
                Get.find<PortfolioController>().projectsKey,
              ),
            ),
            _buildCTA(
              context,
              label: 'Contact Me',
              icon: Icons.mail_outline_rounded,
              isPrimary: false,
              onTap: () => Get.find<PortfolioController>().scrollToSection(
                Get.find<PortfolioController>().contactKey,
              ),
            ),
            _buildDownloadResumeCTA(context),
          ],
        )
            .animate()
            .fadeIn(delay: 1200.ms, duration: 800.ms)
            .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack),
      ],
    );
  }

  void _downloadResume() {
    downloadResume();
  }

  Widget _buildDownloadResumeCTA(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return HoverWidget(
      builder: (isHovered) => GestureDetector(
        onTap: _downloadResume,
        child: AnimatedContainer(
          duration: 200.ms,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: isHovered
                ? const LinearGradient(
                    colors: [AppColors.green, AppColors.darkGreen],
                  )
                : null,
            border: isHovered
                ? null
                : Border.all(
                    color: AppColors.green.withOpacity(0.6),
                    width: 1.5,
                  ),
            color: Colors.transparent,
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: AppColors.green.withOpacity(0.35),
                      blurRadius: 20,
                      spreadRadius: -4,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.download_rounded,
                size: 18,
                color: isHovered
                    ? Colors.white
                    : (isDark ? AppColors.green : AppColors.darkGreen),
              ),
              const SizedBox(width: 8),
              Text(
                'Download CV',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: isHovered
                      ? Colors.white
                      : (isDark ? AppColors.green : AppColors.darkGreen),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        )
            .animate(target: isHovered ? 1 : 0)
            .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05)),
      ),
    );
  }

  Widget _buildCTA(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return HoverWidget(
      builder: (isHovered) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: 200.ms,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: isPrimary
                ? const LinearGradient(
                    colors: [AppColors.green, AppColors.darkGreen],
                  )
                : null,
            border: isPrimary
                ? null
                : Border.all(
                    color: AppColors.green.withOpacity(0.7),
                    width: 1.5,
                  ),
            color: isPrimary ? null : Colors.transparent,
            boxShadow: isPrimary && isHovered
                ? [
                    BoxShadow(
                      color: AppColors.green.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: -4,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isPrimary
                    ? Colors.white
                    : (isDark ? AppColors.green : AppColors.darkGreen),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: isPrimary
                      ? Colors.white
                      : (isDark ? AppColors.green : AppColors.darkGreen),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        )
            .animate(target: isHovered ? 1 : 0)
            .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05)),
      ),
    );
  }

  Widget _buildImageContent(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final containerSize = size.width < 768 ? 280.0 : 340.0;

    return Center(
      child: SizedBox(
        width: containerSize,
        height: containerSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow ring
            Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const SweepGradient(
                  colors: [
                    AppColors.green,
                    AppColors.darkGreen,
                    Color(0xFF2A5E12),
                    AppColors.green,
                  ],
                ),
              ),
            ).animate(onPlay: (c) => c.repeat()).rotate(duration: 8000.ms),

            // White gap
            Container(
              width: containerSize - 6,
              height: containerSize - 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),

            // Image
            Container(
              width: containerSize - 18,
              height: containerSize - 18,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.darkSurface, AppColors.darkCard],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/dev_image.png',
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, _) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.green, AppColors.darkGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_rounded,
                      size: containerSize * 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Orbiting icons
            ..._buildOrbitingIcons(containerSize),
          ],
        ),
      )
          .animate()
          .fadeIn(delay: 600.ms, duration: 1000.ms)
          .scale(begin: const Offset(0.7, 0.7), curve: Curves.easeOutBack),
    );
  }

  List<Widget> _buildOrbitingIcons(double containerSize) {
    final orbitRadius = containerSize / 2 + 28;
    final icons = [
      (FontAwesomeIcons.flutter, AppColors.green, '0'),
      (FontAwesomeIcons.fire, AppColors.green, '2.094'),
      (Icons.code_rounded, AppColors.darkGreen, '4.188'),
    ];

    return icons.map((item) {
      return AnimatedBuilder(
        animation: _orbitController,
        builder: (context, child) {
          final angle = _orbitController.value * 2 * pi + double.parse(item.$3);
          final x = cos(angle) * orbitRadius;
          final y = sin(angle) * orbitRadius;
          return Transform.translate(offset: Offset(x, y), child: child);
        },
        child: GlassContainer(
          borderRadius: 50,
          blurSigma: 8,
          padding: const EdgeInsets.all(10),
          width: 44,
          height: 44,
          child: Icon(item.$1, color: item.$2, size: 18),
        ),
      );
    }).toList();
  }
}
