import 'dart:ui';

import 'package:widget_tree_visualizer/package/widget_canvas_info.dart';
import 'package:widget_tree_visualizer/package/widget_info.dart';

class Calculator {
  double desiredCanvasWidth(
    WidgetInfo info, {
    required double margin,
    required double boxWidth,
  }) {
    final columns = info.extraBranches + 1;
    final requiredMargins = columns - 1;
    return (columns * boxWidth) + (requiredMargins * margin);
  }

  double desiredCanvasHeight(
    WidgetInfo info, {
    required double connectionHeight,
    required double boxHeight,
  }) {
    final requiredConnections = info.depth - 1;
    return (requiredConnections * connectionHeight) + (info.depth * boxHeight);
  }

  List<double> desiredSubtreeWidths(
    WidgetInfo info, {
    required double margin,
    required double boxWidth,
  }) {
    return info.children.map((child) {
      return desiredCanvasWidth(
        child,
        margin: margin,
        boxWidth: boxWidth,
      );
    }).toList();
  }

  List<WidgetCanvasInfo> canvasInfosOf(
    WidgetInfo root, {
    required double canvasWidth,
    required double offsetX,
    required int depth, // start from 0
    required double margin,
    required Size boxSize,
    required double connectionHeight,
  }) {
    WidgetCanvasInfo canvasInfoOf(
      WidgetInfo info,
    ) {
      final x = (canvasWidth / 2) - (boxSize.width / 2) + offsetX;
      final y = (depth * boxSize.height) + (depth * connectionHeight);
      return WidgetCanvasInfo(
        info: info,
        position: Offset(x, y),
      );
    }

    final subtreeWidths = desiredSubtreeWidths(
      root,
      margin: margin,
      boxWidth: boxSize.width,
    );
    return root.children.fold<List<WidgetCanvasInfo>>(
      [canvasInfoOf(root)],
      (all, subInfo) {
        final index = root.children.indexOf(subInfo);
        final subOffsetX = subtreeWidths.take(index).fold(0.0, (sum, width) {
              return sum + width + margin;
            }) +
            offsetX;
        return [
          ...all,
          ...canvasInfosOf(
            subInfo,
            canvasWidth: subtreeWidths[index],
            offsetX: subOffsetX,
            depth: depth + 1,
            margin: margin,
            boxSize: boxSize,
            connectionHeight: connectionHeight,
          ),
        ];
      },
    );
  }

  List<(Offset, Offset)> linesFrom(
    WidgetInfo root, {
    required Size boxSize,
    required List<WidgetCanvasInfo> allCanvasInfo,
  }) {
    final rootCanvasInfo = allCanvasInfo.firstWhere(
      (info) => info.info == root,
    );

    final childrenCanvasInfos = root.children.map(
      (child) => allCanvasInfo.firstWhere(
        (info) => info.info == child,
      ),
    );

    return childrenCanvasInfos.map(
      (childCanvasInfo) {
        final from = Rect.fromLTWH(
          rootCanvasInfo.position.dx,
          rootCanvasInfo.position.dy,
          boxSize.width,
          boxSize.height,
        ).bottomCenter;

        final to = Rect.fromLTWH(
          childCanvasInfo.position.dx,
          childCanvasInfo.position.dy,
          boxSize.width,
          boxSize.height,
        ).topCenter;
        return (from, to);
      },
    ).toList();
  }
}
