import 'package:flutter/material.dart';

/// Sprint bolt, traced from the Figma `Splash/Bolt` vector (replaces
/// `Icons.bolt_rounded`). Sized by [width]; height follows the aspect ratio.
class BoltMark extends StatelessWidget {
  const BoltMark({required this.width, required this.color, super.key});

  final double width;
  final Color color;

  static const double _srcWidth = 17.993268966674805;
  static const double _srcHeight = 19.694231033325195;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, width * _srcHeight / _srcWidth),
      painter: _BoltPainter(color),
    );
  }
}

class _BoltPainter extends CustomPainter {
  const _BoltPainter(this.color);

  final Color color;

  static const List<Offset> _points = [
    Offset(10.468749694826007, 0),
    Offset(8.96376229620438, 6.674037562738017),
    Offset(9.945312210084706, 7.91688776835881),
    Offset(17.077042510992317, 7.91688776835881),
    Offset(17.993268966674805, 8.963762796240468),
    Offset(7.9826309022856075, 19.694231033325195),
    Offset(7.131731099609829, 19.367188015810665),
    Offset(8.898437240602107, 12.562500334579891),
    Offset(7.9826309022856075, 11.908412702146306),
    Offset(0.8504811828764474, 11.908412702146306),
    Offset(0, 10.992187792757404),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / BoltMark._srcWidth;
    final sy = size.height / BoltMark._srcHeight;
    final path = Path()
      ..addPolygon([
        for (final p in _points) Offset(p.dx * sx, p.dy * sy),
      ], true);
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_BoltPainter old) => old.color != color;
}
