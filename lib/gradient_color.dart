import 'package:flutter/material.dart';

BoxDecoration GetGradientBackgroundScreen() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.purple.withOpacity(0.7),
        Colors.blue.withOpacity(0.7),
      ],
    ),
  );
}

Shader GetGradientText(Rect bounds) {
  return LinearGradient(
    colors: [
      Colors.purple.withOpacity(1),
      Colors.blue.withOpacity(1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ).createShader(bounds);
}
