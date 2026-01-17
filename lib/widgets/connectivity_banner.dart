import 'package:flutter/material.dart';
import '../controller/connectivity_controller.dart';

class ConnectivityBanner extends StatelessWidget {
  final ConnectivityController controller;

  const ConnectivityBanner({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        if (controller.isOnline) return const SizedBox();

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          color: Colors.red,
          child: const Text(
            "No Internet Connection",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
