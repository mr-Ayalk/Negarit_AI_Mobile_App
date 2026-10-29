import 'package:flutter/material.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';

/// A drawn floor-plan chrome. It is not a venue map and has no zone data.
class FloorPlanPreview extends StatelessWidget {
  const FloorPlanPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      painter: _FloorPlanPainter(),
      child: SizedBox.expand(),
    );
  }
}

class _FloorPlanPainter extends CustomPainter {
  const _FloorPlanPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = NegaritColors.skyTop;
    canvas.drawRect(Offset.zero & size, background);

    final block = Paint()..color = NegaritColors.surface.withValues(alpha: 0.9);
    final rooms = [
      Rect.fromLTWH(
        size.width * 0.08,
        size.height * 0.08,
        size.width * 0.34,
        size.height * 0.22,
      ),
      Rect.fromLTWH(
        size.width * 0.48,
        size.height * 0.1,
        size.width * 0.4,
        size.height * 0.16,
      ),
      Rect.fromLTWH(
        size.width * 0.12,
        size.height * 0.38,
        size.width * 0.28,
        size.height * 0.2,
      ),
      Rect.fromLTWH(
        size.width * 0.5,
        size.height * 0.36,
        size.width * 0.36,
        size.height * 0.24,
      ),
      Rect.fromLTWH(
        size.width * 0.18,
        size.height * 0.66,
        size.width * 0.46,
        size.height * 0.16,
      ),
    ];
    for (final room in rooms) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(room, const Radius.circular(18)),
        block,
      );
    }

    final route = Path()
      ..moveTo(size.width * 0.22, size.height * 0.74)
      ..cubicTo(
        size.width * 0.28,
        size.height * 0.48,
        size.width * 0.55,
        size.height * 0.58,
        size.width * 0.68,
        size.height * 0.22,
      );
    canvas.drawPath(
      route,
      Paint()
        ..color = NegaritColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );

    final pin = Paint()..color = NegaritColors.primary;
    for (final center in [
      Offset(size.width * 0.22, size.height * 0.74),
      Offset(size.width * 0.42, size.height * 0.48),
      Offset(size.width * 0.68, size.height * 0.22),
    ]) {
      canvas.drawCircle(center, 8, pin);
      canvas.drawCircle(center, 4, Paint()..color = NegaritColors.surface);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
