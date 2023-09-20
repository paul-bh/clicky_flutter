import 'package:flutter/material.dart';

enum TouchBoundStyles { byInitialTouchPoint, byContextSize }

class ClickyStyle {
  const ClickyStyle({
    this.color = const Color.fromARGB(18, 0, 0, 0),
    this.borderRadius = 10,
    this.shrinkScale = const ShrinkScale.byRatio(0.02),
    this.curveColorIn = Curves.easeOut,
    this.curveColorOut = Curves.easeOut,
    this.curveSizeIn = Curves.easeOut,
    this.curveSizeOut = Curves.easeOut,
    this.durationIn = const Duration(milliseconds: 70),
    this.durationOut = const Duration(milliseconds: 70),
    this.touchBoundStyles = TouchBoundStyles.byInitialTouchPoint,
  });

  /// the color of the clicky effect
  final Color color;
  final double borderRadius;
  final Curve curveColorIn;
  final Curve curveColorOut;
  final ShrinkScale shrinkScale;
  final Curve curveSizeIn;
  final Curve curveSizeOut;
  final Duration durationIn;
  final Duration durationOut;
  final TouchBoundStyles touchBoundStyles;
}

class ShrinkScale {
  final double ratio;
  final double value;

  const ShrinkScale.byRatio(this.ratio) : value = 0;
  const ShrinkScale.byValue(this.value) : ratio = 0;

  double byRatio() {
    return ratio;
  }

  double byValue() {
    return value;
  }
}
