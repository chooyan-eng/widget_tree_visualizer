import 'dart:math';

class WidgetInfo {
  final String name;
  final List<WidgetInfo> children;

  WidgetInfo._({
    required this.name,
    required this.children,
  });

  factory WidgetInfo.single({
    required String name,
    required WidgetInfo child,
  }) =>
      WidgetInfo._(name: name, children: [child]);

  factory WidgetInfo.multiple({
    required String name,
    required List<WidgetInfo> children,
  }) =>
      WidgetInfo._(name: name, children: children);

  factory WidgetInfo.leaf({
    required String name,
  }) =>
      WidgetInfo._(name: name, children: []);

  int get extraBranches {
    if (children.isEmpty) return 0;
    return children.fold(
      children.length - 1,
      (total, child) => total + child.extraBranches,
    );
  }

  int get depth {
    if (children.isEmpty) return 1;
    return children.fold(
      1,
      (maxDepth, child) => max(maxDepth, child.depth + 1),
    );
  }
}
