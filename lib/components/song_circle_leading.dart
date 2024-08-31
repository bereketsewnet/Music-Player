import 'package:flutter/material.dart';

class SongCircleLeading extends StatelessWidget {
  final imagePath;

  const SongCircleLeading({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.asset(
        imagePath,
      ),
    );
  }
}
