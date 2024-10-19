import 'package:easy_cha/core/constant/extension.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  final double width;
  final double height;
  final bool isCircular;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;

  const Skeleton({
    super.key,
    this.margin,
    this.borderRadius,
    required this.width,
    required this.height,
    this.isCircular = false,
  });

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateColorAnimation();
  }

  // * Update colors when theme changes
  void _updateColorAnimation() {
    bool isDark = context.theme.brightness == Brightness.dark;
    _colorAnimation = ColorTween(
      begin: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
      end: isDark ? Colors.grey.shade600 : Colors.grey.shade100,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (_, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: widget.isCircular
                ? null
                : widget.borderRadius ?? BorderRadius.circular(3.5.w),
            shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
          ),
          child: child,
        );
      },
    );
  }
}
