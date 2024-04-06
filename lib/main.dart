import 'package:flutter/material.dart';
import 'package:widget_tree_visualizer/package/widget_info.dart';
import 'package:widget_tree_visualizer/package/widget_tree_canvas.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DefaultTextStyle(
          style: const TextStyle(fontSize: 24, color: Colors.black),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: WidgetTreeCanvas(
              root: WidgetInfo.single(
                name: 'MaterialApp',
                child: WidgetInfo.multiple(
                  name: 'Scaffold',
                  children: [
                    WidgetInfo.multiple(name: 'AppBar', children: [
                      WidgetInfo.single(
                        name: 'IconButton',
                        child: WidgetInfo.leaf(name: 'Icon'),
                      ),
                    ]),
                    WidgetInfo.multiple(name: 'Column', children: [
                      WidgetInfo.leaf(name: 'Text'),
                      WidgetInfo.leaf(name: 'Text'),
                    ]),
                    WidgetInfo.leaf(name: 'Floating\nActionButton'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
