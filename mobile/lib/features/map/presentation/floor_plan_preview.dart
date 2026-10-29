import 'package:flutter/material.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';

/// Schematic of the named Adwa visit places. It is not a measured floor plan.
class FloorPlanPreview extends StatelessWidget {
  const FloorPlanPreview({this.highlight, super.key});

  /// English place name to mark. The drawing stays a schematic.
  final String? highlight;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _FloorPlanPainter(highlight: highlight),
      child: const SizedBox.expand(),
    );
  }
}

class _FloorPlanPainter extends CustomPainter {
  const _FloorPlanPainter({this.highlight});

  final String? highlight;

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [NegaritColors.skyBottom, NegaritColors.skyTop],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, background);

    final route = Path()
      ..moveTo(size.width * 0.26, size.height * 0.16)
      ..lineTo(size.width * 0.70, size.height * 0.16)
      ..lineTo(size.width * 0.26, size.height * 0.40)
      ..lineTo(size.width * 0.70, size.height * 0.40)
      ..lineTo(size.width * 0.50, size.height * 0.82);
    canvas.drawPath(
      route,
      Paint()
        ..color = NegaritColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );

    final rooms = <_Room>[
      _Room('Entrance', 0.08, 0.08, 0.36, 0.16),
      _Room('5gna Ber', 0.52, 0.08, 0.36, 0.16),
      _Room('6gna Ber', 0.08, 0.32, 0.36, 0.16),
      _Room('Coffee', 0.52, 0.32, 0.36, 0.16),
      _Room('Restaurant', 0.08, 0.56, 0.36, 0.14),
      _Room('Parking', 0.52, 0.56, 0.16, 0.14),
      _Room('Restrooms', 0.72, 0.56, 0.16, 0.14),
      _Room('Exits', 0.28, 0.76, 0.44, 0.12),
    ];

    final block = Paint()..color = NegaritColors.surface;
    final marked = Paint()..color = NegaritColors.primary;
    final border = Paint()
      ..color = NegaritColors.primary.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (final room in rooms) {
      final rect = Rect.fromLTWH(
        size.width * room.x,
        size.height * room.y,
        size.width * room.w,
        size.height * room.h,
      );
      final shape = RRect.fromRectAndRadius(rect, const Radius.circular(16));
      final selected = room.name == highlight;
      canvas.drawRRect(shape, selected ? marked : block);
      if (!selected) {
        canvas.drawRRect(shape, border);
      }
      _label(canvas, room.name, rect.center, selected: selected);
    }
  }

  void _label(Canvas canvas, String text, Offset center, {required bool selected}) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: selected ? Colors.white : NegaritColors.text,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(
      canvas,
      center - Offset(painter.width / 2, painter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _FloorPlanPainter oldDelegate) {
    return oldDelegate.highlight != highlight;
  }
}

class _Room {
  const _Room(this.name, this.x, this.y, this.w, this.h);

  final String name;
  final double x;
  final double y;
  final double w;
  final double h;
}
