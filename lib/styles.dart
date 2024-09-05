import 'package:flutter/material.dart';

enum ClickyBoundaryStyle {
  fromInitialTouchPoint,
  fromWidgetOutline,
  both,
}

class ClickyStyle {
  const ClickyStyle({
    this.color = const Color.fromARGB(18, 0, 0, 0),
    this.borderRadius = 10,
    this.shrinkScale = const ShrinkScale.byRatio(0.05),
    this.curveColorIn = Curves.easeOut,
    this.curveColorOut = Curves.easeOut,
    this.curveSizeIn = Curves.easeOut,
    this.curveSizeOut = Curves.easeOut,
    this.durationIn = const Duration(milliseconds: 120),
    this.durationOut = const Duration(milliseconds: 120),
    this.boundaryFromInitialTouchPoint = 70,
    this.boundaryFromWidgetOutline = 0,
    this.boundaryStyle = ClickyBoundaryStyle.fromInitialTouchPoint,
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
  final double boundaryFromInitialTouchPoint;
  final double boundaryFromWidgetOutline;
  final ClickyBoundaryStyle boundaryStyle;
}

class ShrinkScale {
  final double? ratio;
  // final double? value;

  // make validator, ratio and value cannot be null at the same time
  double byRatio() {
    assert(ratio != null);
    return ratio!;
  }

  // double byValue() {
  //   assert(ratio != null || value != null);
  //   return value!;
  // }

  const ShrinkScale.byRatio(this.ratio);
  // const ShrinkScale.byValue(this.value) : ratio = null;
}
