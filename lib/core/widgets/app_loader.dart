import 'package:flutter/material.dart';

class AppLoader extends StatefulWidget {
  final double size;
  final Color color;

  const AppLoader({super.key, this.size = 50.0, this.color = Colors.blueAccent});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 1. Define the controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(); // 2. Make it loop indefinitely
  }

  @override
  void dispose() {
    _controller.dispose(); // Always clean up!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _controller,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.color.withOpacity(0.2), // The faint background ring
              width: 4,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CircularProgressIndicator(
                  value: 0.25, // Only shows a quarter of the circle
                  strokeWidth: 4,
                  color: widget.color,
                  strokeCap: StrokeCap.round, // Makes the ends look soft
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}