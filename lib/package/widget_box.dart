import 'package:flutter/material.dart';

class WidgetBox extends StatelessWidget {
  const WidgetBox({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: FittedBox(
        child: Text(
          name,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
