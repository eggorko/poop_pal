import 'package:flutter/material.dart';

const ConfettiConfig appConfettiConfig = ConfettiConfig(
  enabled: true,
  duration: Duration(milliseconds: 3200),
  pieceCount: 42,
  colors: [
    Color(0xFF49C2B8),
    Color(0xFFFF765F),
    Color(0xFFFFC857),
    Color(0xFF2F9D5B),
    Color(0xFF8E6DD8),
  ],
  maxHorizontalDrift: 54,
  fallStartFraction: 0.12,
  fallDistanceFraction: 0.58,
  topStartOffset: 36,
  verticalStagger: 90,
  minPieceWidth: 7,
  widthStep: 2,
  minPieceHeight: 12,
  heightStep: 2,
  cornerRadius: 2,
);

class ConfettiConfig {
  const ConfettiConfig({
    required this.enabled,
    required this.duration,
    required this.pieceCount,
    required this.colors,
    required this.maxHorizontalDrift,
    required this.fallStartFraction,
    required this.fallDistanceFraction,
    required this.topStartOffset,
    required this.verticalStagger,
    required this.minPieceWidth,
    required this.widthStep,
    required this.minPieceHeight,
    required this.heightStep,
    required this.cornerRadius,
  }) : assert(pieceCount >= 0),
       assert(maxHorizontalDrift >= 0),
       assert(fallStartFraction >= 0),
       assert(fallDistanceFraction >= 0),
       assert(topStartOffset >= 0),
       assert(verticalStagger >= 0),
       assert(minPieceWidth > 0),
       assert(widthStep >= 0),
       assert(minPieceHeight > 0),
       assert(heightStep >= 0),
       assert(cornerRadius >= 0);

  final bool enabled;
  final Duration duration;
  final int pieceCount;
  final List<Color> colors;
  final double maxHorizontalDrift;
  final double fallStartFraction;
  final double fallDistanceFraction;
  final double topStartOffset;
  final double verticalStagger;
  final double minPieceWidth;
  final double widthStep;
  final double minPieceHeight;
  final double heightStep;
  final double cornerRadius;
}
