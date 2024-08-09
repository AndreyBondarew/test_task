import 'dart:math';

import 'package:flutter/material.dart';

/*
* Since a different animation was downloaded from the link in Figma, I decided to implement the original
* animation using Dart/Flutter (I do know how to use Lottie, of course.
* I just liked the original animation and decided to stick with what was in Figma).
*/
class AnimatedPreloader extends StatefulWidget {
  final Color color;

  const AnimatedPreloader({super.key, required this.color});

  @override
  State createState() => _AnimatedPreloaderState();
}

class _AnimatedPreloaderState extends State<AnimatedPreloader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double radius = constraints.maxHeight / 4;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size(radius * 4, radius * 4),
              painter: CirclePainter(
                progress: _controller.value,
                radius: radius,
                color: widget.color,
              ),
            );
          },
        );
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  final double radius;
  final Color color;

  CirclePainter({
    required this.progress,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;

    final Offset center = Offset(size.width / 2, size.height / 2);

    double phase = progress * 7 % 1;
    int step = (progress * 7).floor();

    switch (step) {
      case 0:
        double dx = radius * (phase * 2);
        canvas.drawCircle(center.translate(max(-dx, -radius), 0), radius, paint);
        canvas.drawCircle(center.translate(min(dx, radius), 0), radius, paint);
        break;
      case 1:
        double dy = radius * (phase * 2);
        canvas.drawCircle(center.translate(radius, min(dy, radius)), radius, paint);
        canvas.drawCircle(center.translate(-radius, max(-dy, -radius)), radius, paint);
        canvas.drawCircle(center.translate(-radius, min(dy, radius)), radius, paint);
        canvas.drawCircle(center.translate(radius, max(-dy, -radius)), radius, paint);
        break;
      case 2:
        double dx = radius * (phase * 2);
        canvas.drawCircle(center.translate(min(radius + dx, 2 * radius), -radius), radius, paint);
        canvas.drawCircle(center.translate(max(-radius - dx, -2 * radius), radius), radius, paint);
        canvas.drawCircle(center.translate(max(radius - dx, 0), radius), radius, paint);
        canvas.drawCircle(center.translate(min(-radius + dx, 0), -radius), radius, paint);
        break;
      case 3:
        double dy = radius * (phase * 2);
        canvas.drawCircle(center.translate(2 * radius, min(-radius + dy * 2, radius)), radius, paint);
        canvas.drawCircle(center.translate(-2 * radius, max(radius - dy * 2, -radius)), radius, paint);
        canvas.drawCircle(center.translate(0, radius), radius, paint);
        canvas.drawCircle(center.translate(0, -radius), radius, paint);
        break;
      case 4:
        double dx = radius * (phase * 2);
        canvas.drawCircle(center.translate(max(-dx, -radius), radius), radius, paint);
        canvas.drawCircle(center.translate(max(-dx + radius * 2, radius), radius), radius, paint);
        canvas.drawCircle(center.translate(min(dx, radius), -radius), radius, paint);
        canvas.drawCircle(center.translate(min(dx - radius * 2, -radius), -radius), radius, paint);
        break;
      case 5:
        double dy = radius * (phase * 2);
        canvas.drawCircle(center.translate(radius, min(-radius + dy, 0)), radius, paint);
        canvas.drawCircle(center.translate(-radius, max(radius - dy, 0)), radius, paint);
        canvas.drawCircle(center.translate(radius, max(radius - dy, 0)), radius, paint);
        canvas.drawCircle(center.translate(-radius, min(-radius + dy, 0)), radius, paint);
        break;
      case 6:
        double dx = radius * (phase * 2);
        canvas.drawCircle(center.translate(min(-radius + dx, 0), 0), radius, paint);
        canvas.drawCircle(center.translate(max(radius - dx, 0), 0), radius, paint);

        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
