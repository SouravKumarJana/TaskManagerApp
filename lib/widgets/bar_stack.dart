import 'package:flutter/material.dart';

class BarStack extends StatelessWidget {
  final Function(int) onIndexChanged;

  const BarStack({super.key, required this.onIndexChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () => onIndexChanged(0),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => onIndexChanged(1),
        ),
        IconButton(
          icon: const Icon(Icons.check_circle),
          onPressed: () => onIndexChanged(2),
        ),
        IconButton(
          icon: const Icon(Icons.bar_chart),
          onPressed: () => onIndexChanged(3),
        ),
      ],
    );
  }
}
