import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/portfolio_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/hover_widget.dart';
import '../widgets/parallax_widget.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      key: controller.contactKey,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Parallax
          Positioned(
            top: 0,
            left: 0,
            child: ParallaxWidget(
              scrollController: controller.scrollController,
              speed: 0.1,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.green.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: ParallaxWidget(
              scrollController: controller.scrollController,
              speed: 0.2,
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
                // Header
                Column(
                  children: [
                    const Text(
                      '📬 Get In Touch',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
                    const SizedBox(height: 12),
                    Text(
                      'Let\'s build something amazing together',
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
                    )
                        .animate()
                        .scaleX(begin: 0, delay: 300.ms, duration: 600.ms),
                  ],
                ),

                const SizedBox(height: 60),

                // Contact cards
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 600;
                    if (isWide) {
                      return Row(
                        children: [
                          Expanded(
                            child:
                                _ContactCard(item: _contactItems[0], index: 0),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child:
                                _ContactCard(item: _contactItems[1], index: 1),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child:
                                _ContactCard(item: _contactItems[2], index: 2),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: _contactItems
                            .asMap()
                            .entries
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child:
                                    _ContactCard(item: e.value, index: e.key),
                              ),
                            )
                            .toList(),
                      );
                    }
                  },
                ),

                const SizedBox(height: 80),

                // Footer divider
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.green.withOpacity(0.5),
                        AppColors.darkGreen.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Footer text
                Column(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [AppColors.green, AppColors.darkGreen],
                      ).createShader(bounds),
                      child: const Text(
                        'Parth Savaliya',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Flutter Developer • Building beautiful apps since 2022',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white54 : Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '© 2024 Parth Savaliya. Crafted with ❤️ & Flutter',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white38 : Colors.black26,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static final List<_ContactItem> _contactItems = [
    _ContactItem(
      icon: FontAwesomeIcons.linkedin,
      label: 'LinkedIn',
      value: 'Parth Savaliya',
      color: AppColors.green,
      url: 'https://www.linkedin.com/in/parth-savaliya-598237274/',
    ),
    _ContactItem(
      icon: FontAwesomeIcons.envelope,
      label: 'Email',
      value: 'parthsavaliya0082@gmail.com',
      color: AppColors.green,
      url: 'mailto:parthsavaliya0082@gmail.com',
    ),
    _ContactItem(
      icon: FontAwesomeIcons.phone,
      label: 'Phone',
      value: '+91 70462 10082',
      color: AppColors.green,
      url: 'tel:+917046210082',
    ),
  ];
}

class _ContactItem {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final String url;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.url,
  });
}

class _ContactCard extends StatelessWidget {
  final _ContactItem item;
  final int index;

  const _ContactCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
      builder: (isHovered) => GestureDetector(
        onTap: () async {
          final uri = Uri.parse(item.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: GlassContainer(
          borderRadius: 20,
          padding: const EdgeInsets.all(28),
          borderColor: isHovered ? item.color.withOpacity(0.5) : null,
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: item.color.withOpacity(0.25),
                    blurRadius: 24,
                    spreadRadius: -4,
                  ),
                ]
              : null,
          child: Column(
            children: [
              AnimatedContainer(
                duration: 200.ms,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.color.withOpacity(isHovered ? 0.2 : 0.1),
                  boxShadow: isHovered
                      ? [
                          BoxShadow(
                            color: item.color.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: -2,
                          ),
                        ]
                      : null,
                ),
                child: FaIcon(item.icon, color: item.color, size: 24),
              ),
              const SizedBox(height: 16),
              Text(
                item.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.value,
                style: TextStyle(
                  fontSize: 13,
                  color: item.color,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: (200 * index).ms, duration: 600.ms)
        .slideY(begin: 0.3);
  }
}
