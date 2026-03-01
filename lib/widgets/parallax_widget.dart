import 'package:flutter/material.dart';

class ParallaxWidget extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final double speed;
  final double horizontalOffset;
  final double verticalOffset;

  const ParallaxWidget({
    super.key,
    required this.child,
    required this.scrollController,
    this.speed = 0.5,
    this.horizontalOffset = 0,
    this.verticalOffset = 0,
  });

  @override
  State<ParallaxWidget> createState() => _ParallaxWidgetState();
}

class _ParallaxWidgetState extends State<ParallaxWidget> {
  double _offset = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (mounted) {
      setState(() {
        _offset = widget.scrollController.offset * widget.speed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        widget.horizontalOffset,
        widget.verticalOffset - _offset,
      ),
      child: widget.child,
    );
  }
}
