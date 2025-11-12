import 'package:flutter/material.dart';

class BounceLogo extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offset;

  const BounceLogo({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
    this.offset = 5,
  });

  @override
  State<BounceLogo> createState() => _BounceLogoState();
}

class _BounceLogoState extends State<BounceLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        final offset =
            widget.offset * (1 - (_controller.value - 0.5).abs() * 2);
        return Transform.translate(offset: Offset(0, -offset), child: child);
      },
      child: widget.child,
    );
  }
}
