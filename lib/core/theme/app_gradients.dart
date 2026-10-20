import 'package:flutter/material.dart';

/// Gradients for the shop. Warm neutrals, used on surfaces that should feel
/// finished rather than flat.
abstract final class AppGradients {
  static const canvas = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF8F1E8), Color(0xFFF4F4F2), Color(0xFFE9E1D8)],
  );

  static const ink = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3A2C26), Color(0xFF141414), Color(0xFF6B4E3D)],
  );

  static const scrim = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00000000), Color(0x73000000)],
    stops: [0.45, 1],
  );

  static const bronze = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8D6A4A), Color(0xFFD8BC9A)],
  );
}
