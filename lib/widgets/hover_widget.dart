import 'package:flutter/material.dart';

class HoverWidget extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  final Duration duration;

  const HoverWidget({
    super.key,
    required this.builder,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<HoverWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: widget.duration,
        curve: Curves.easeOutBack,
        child: widget.builder(_isHovered),
      ),
    );
  }
}
