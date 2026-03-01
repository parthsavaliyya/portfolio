import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurSigma;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final Color? glassColor;
  final Gradient? gradient;
  final VoidCallback? onTap;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.blurSigma = 16,
    this.opacity = 0.12,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderColor,
    this.boxShadow,
    this.glassColor,
    this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Dark: #202020 at ~55%, Light: white at ~85%
    final defaultGlassColor = isDark
        ? const Color(0xFF202020).withOpacity(0.55)
        : Colors.white.withOpacity(0.85);

    final defaultBorderColor = isDark
        ? Colors.white.withOpacity(0.10)
        : Colors.black.withOpacity(0.07);

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: glassColor ?? defaultGlassColor,
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: gradient,
                border: Border.all(
                  color: borderColor ?? defaultBorderColor,
                  width: 1.2,
                ),
                boxShadow: boxShadow ??
                    [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.35 : 0.06),
                        blurRadius: 24,
                        spreadRadius: -4,
                        offset: const Offset(0, 8),
                      ),
                    ],
              ),
              padding: padding ?? const EdgeInsets.all(20),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
