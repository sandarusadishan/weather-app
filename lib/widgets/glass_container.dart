import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color color;
  final double opacity;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 20.0,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.color = Colors.white,
    this.opacity = 0.5, // Increased opacity for Light Mode (glass needs to be visible)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // Reduced blur for performance
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withOpacity(opacity),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: Colors.white.withOpacity(0.6), // Stronger border
                width: 1.5,
              ),
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(opacity + 0.1),
                  color.withOpacity(opacity),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
