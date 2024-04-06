import 'package:flutter/material.dart';
import 'package:widget_tree_visualizer/package/calculator.dart';
import 'package:widget_tree_visualizer/package/widget_box.dart';
import 'package:widget_tree_visualizer/package/widget_info.dart';

class WidgetTreeCanvas extends StatelessWidget {
  WidgetTreeCanvas({
    super.key,
    required this.root,
  });

  final WidgetInfo root;

  final _calculator = Calculator();

  final _margin = 16.0;
  final _connectionHeight = 60.0;
  final _boxSize = const Size(120, 60);

  @override
  Widget build(BuildContext context) {
    final desiredCanvasWidth = _calculator.desiredCanvasWidth(
      root,
      margin: _margin,
      boxWidth: _boxSize.width,
    );

    final desiredCanvasHeight = _calculator.desiredCanvasHeight(
      root,
      boxHeight: _boxSize.height,
      connectionHeight: _connectionHeight,
    );

    final canvasInfos = _calculator.canvasInfosOf(
      root,
      canvasWidth: desiredCanvasWidth,
      offsetX: 0,
      depth: 0,
      margin: _margin,
      boxSize: _boxSize,
      connectionHeight: _connectionHeight,
    );

    return FittedBox(
      child: SizedBox(
        width: desiredCanvasWidth,
        height: desiredCanvasHeight,
        child: Stack(children: [
          ...canvasInfos.map(
            (info) => Positioned(
              left: info.position.dx,
              top: info.position.dy,
              child: WidgetBox(name: info.info.name),
            ),
          ),
          ...canvasInfos.map(
            (info) {
              final lines = _calculator.linesFrom(
                info.info,
                boxSize: _boxSize,
                allCanvasInfo: canvasInfos,
              );
              return lines
                  .map((line) => CustomPaint(
                        painter: _ConnectionPainter(
                          from: line.$1,
                          to: line.$2,
                        ),
                      ))
                  .toList();
            },
          ).expand((e) => e),
        ]),
      ),
    );
  }
}

class _ConnectionPainter extends CustomPainter {
  _ConnectionPainter({
    required this.from,
    required this.to,
  });

  final Offset from;
  final Offset to;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    canvas.drawLine(from, to, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      from != (oldDelegate as _ConnectionPainter).from || to != oldDelegate.to;
}
