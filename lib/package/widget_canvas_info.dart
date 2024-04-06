import 'package:flutter/widgets.dart';
import 'package:widget_tree_visualizer/package/widget_info.dart';

class WidgetCanvasInfo {
  final key = GlobalKey();
  final WidgetInfo info;
  final Offset position;

  WidgetCanvasInfo({
    required this.info,
    required this.position,
  });
}
