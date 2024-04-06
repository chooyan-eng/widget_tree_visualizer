import 'package:flutter_test/flutter_test.dart';
import 'package:widget_tree_visualizer/package/widget_info.dart';

void main() {
  group('simple widget tree', () {
    final widgetInfo = WidgetInfo.single(
      name: 'MaterialApp',
      child: WidgetInfo.multiple(
        name: 'Scaffold',
        children: [
          WidgetInfo.multiple(name: 'AppBar', children: [
            WidgetInfo.leaf(name: 'IconButton'),
            WidgetInfo.leaf(name: 'Text'),
            WidgetInfo.leaf(name: 'IconButton'),
          ]),
          WidgetInfo.multiple(name: 'Column', children: [
            WidgetInfo.leaf(name: 'Text'),
            WidgetInfo.leaf(name: 'Text'),
            WidgetInfo.leaf(name: 'Text'),
          ]),
          WidgetInfo.leaf(name: 'FloatingActionButton'),
        ],
      ),
    );
    test('depth', () {
      expect(widgetInfo.depth, 4);
    });

    test('branch count', () {
      expect(widgetInfo.extraBranches, 6);
    });
  });
}
