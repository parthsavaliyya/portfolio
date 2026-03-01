import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../data/portfolio_data.dart';
import '../services/theme_service.dart';
import '../theme/app_theme.dart';
import 'glass_container.dart';
import 'hover_widget.dart';

class PortfolioNavbar extends StatefulWidget {
  const PortfolioNavbar({super.key});

  @override
  State<PortfolioNavbar> createState() => _PortfolioNavbarState();
}

class _PortfolioNavbarState extends State<PortfolioNavbar> {
  bool _menuOpen = false;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final themeService = Get.find<ThemeService>();
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Column(
        children: [
          GlassContainer(
            borderRadius: 20,
            blurSigma: 20,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 24,
              vertical: isMobile ? 10 : 14,
            ),
            child: Row(
              children: [
                // Logo — green gradient
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.green, AppColors.darkGreen],
                  ).createShader(bounds),
                  child: const Text(
                    'Flutter Dev',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const Spacer(),

                // Nav links (desktop) — Flexible so parent Row never overflows
                if (!isMobile)
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: _buildNavLinks(context, controller),
                      ),
                    ),
                  ),

                const SizedBox(width: 8),

                // Theme Toggle
                HoverWidget(
                  builder: (isHovered) => Obx(
                    () => AnimatedContainer(
                      duration: 200.ms,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isHovered
                            ? AppColors.green.withOpacity(0.15)
                            : Colors.transparent,
                      ),
                      child: IconButton(
                        onPressed: themeService.toggleTheme,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        iconSize: 22,
                        icon: AnimatedSwitcher(
                          duration: 300.ms,
                          transitionBuilder: (child, anim) =>
                              RotationTransition(turns: anim, child: child),
                          child: themeService.isDark
                              ? const Icon(
                                  Icons.wb_sunny_rounded,
                                  key: ValueKey('sun'),
                                  color: AppColors.green,
                                  size: 22,
                                )
                              : const Icon(
                                  Icons.dark_mode_rounded,
                                  key: ValueKey('moon'),
                                  color: AppColors.darkGreen,
                                  size: 22,
                                ),
                        ),
                        tooltip: 'Toggle Theme',
                      ),
                    ),
                  ),
                ),

                // Hamburger (mobile)
                if (isMobile) ...[
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: () => setState(() => _menuOpen = !_menuOpen),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: 22,
                    icon: AnimatedSwitcher(
                      duration: 200.ms,
                      child: _menuOpen
                          ? const Icon(
                              Icons.close_rounded,
                              key: ValueKey('close'),
                            )
                          : const Icon(
                              Icons.menu_rounded,
                              key: ValueKey('menu'),
                            ),
                    ),
                  ),
                ],
              ],
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -1),

          // Mobile Menu
          if (isMobile && _menuOpen)
            GlassContainer(
              margin: const EdgeInsets.only(top: 8),
              borderRadius: 16,
              blurSigma: 20,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: PortfolioData.navItems.asMap().entries.map((e) {
                  final keys = [
                    controller.heroKey,
                    controller.experienceKey,
                    controller.projectsKey,
                    controller.skillsKey,
                    controller.contactKey,
                  ];
                  return ListTile(
                    title: Text(
                      e.value,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      setState(() => _menuOpen = false);
                      controller.scrollToSection(keys[e.key]);
                    },
                  );
                }).toList(),
              ),
            ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2),
        ],
      ),
    );
  }

  List<Widget> _buildNavLinks(
    BuildContext context,
    PortfolioController controller,
  ) {
    final keys = [
      controller.heroKey,
      controller.experienceKey,
      controller.projectsKey,
      controller.skillsKey,
      controller.contactKey,
    ];

    return PortfolioData.navItems.asMap().entries.map((entry) {
      return HoverWidget(
        builder: (isHovered) => GestureDetector(
          onTap: () => controller.scrollToSection(keys[entry.key]),
          child: AnimatedContainer(
            duration: 200.ms,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isHovered
                  ? AppColors.green.withOpacity(0.12)
                  : Colors.transparent,
            ),
            child: Text(
              entry.value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isHovered ? AppColors.green : null,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
