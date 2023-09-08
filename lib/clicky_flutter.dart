library clicky_flutter;

import 'package:flutter/material.dart';

class TouchEffectWrapper extends StatefulWidget {
  final Widget child;
  final Color? $clickedColor;
  final double? $clickedRadius;
  final double? $clickedShrinkRatio;
  final Curve? $clickedCurveColorIn;
  final Curve? $clickedCurveColorOut;
  final Curve? $clickedCurveSizeIn;
  final Curve? $clickedCurveSizeOut;
  final Duration? $clickedDurationIn;
  final Duration? $clickedDurationOut;

  const TouchEffectWrapper({
    Key? key,
    required this.child,
    this.$clickedColor,
    this.$clickedRadius,
    this.$clickedShrinkRatio,
    this.$clickedCurveColorIn,
    this.$clickedCurveColorOut,
    this.$clickedCurveSizeIn,
    this.$clickedCurveSizeOut,
    this.$clickedDurationIn,
    this.$clickedDurationOut,
  }) : super(key: key);

  @override
  TouchEffectWrapperState createState() => TouchEffectWrapperState();
}

class TouchEffectWrapperState extends State<TouchEffectWrapper> with SingleTickerProviderStateMixin {
  double __scale = 1;
  bool __isClicked = false;
  Color? $clickedColor;
  double? $clickedRadius;
  double? $clickedShrinkRatio;
  Curve? $clickedCurveColorIn;
  Curve? $clickedCurveColorOut;
  Curve? $clickedCurveSizeIn;
  Curve? $clickedCurveSizeOut;
  Duration? $clickedDurationIn;
  Duration? $clickedDurationOut;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color $clickedColor = widget.$clickedColor ?? Colors.black.withOpacity(0.045);
    double $clickedRadius = widget.$clickedRadius ?? 0;
    double $clickedShrinkRatio = widget.$clickedShrinkRatio ?? 0.025;
    Curve $clickedCurveColorIn = widget.$clickedCurveColorIn ?? Curves.easeOutCirc;
    Curve $clickedCurveColorOut = widget.$clickedCurveColorOut ?? Curves.easeOutBack;
    Curve $clickedCurveSizeIn = widget.$clickedCurveSizeIn ?? Curves.linear;
    Curve $clickedCurveSizeOut = widget.$clickedCurveSizeOut ?? Curves.easeOutBack;
    Duration $clickedDurationIn = widget.$clickedDurationIn ?? Duration(milliseconds: 100);
    Duration $clickedDurationOut = widget.$clickedDurationOut ?? Duration(milliseconds: 300);

    return GestureDetector(
      onPanEnd: (details) {
        setState(() {
          __scale = 1;
          __isClicked = false;
        });
      },
      onPanDown: (details) {
        setState(() {
          __scale = 1 - $clickedShrinkRatio;
          __isClicked = true;
        });
      },
      onPanCancel: () {
        setState(() {
          __scale = 1;
          __isClicked = false;
        });
      },
      // also, if touch position is too far (1.5 times further than the size) from the widget, cancel the effect. However, if it comes back to the widget, the effect will be restored.
      onPanUpdate: (details) {
        if (
            // if touch position is too far (50 px) from the context size, cancel the effect.
            details.localPosition.dx < -50 ||
                details.localPosition.dx > context.size!.width + 50 ||
                details.localPosition.dy < -50 ||
                details.localPosition.dy > context.size!.height + 50) {
          setState(() {
            __scale = 1;
            __isClicked = false;
          });
        } else {
          setState(() {
            __scale = 1 - $clickedShrinkRatio;
            __isClicked = true;
          });
        }
      },
      child: AnimatedContainer(
        padding: EdgeInsets.all(0),
        duration: __isClicked ? $clickedDurationIn : $clickedDurationOut,
        curve: __isClicked ? $clickedCurveColorIn : $clickedCurveColorOut,
        decoration: BoxDecoration(
          color: __isClicked ? $clickedColor : $clickedColor.withAlpha(0),
          borderRadius: BorderRadius.circular($clickedRadius),
        ),
        child: AnimatedScale(
          scale: __scale,
          duration: __isClicked ? $clickedDurationIn : $clickedDurationOut,
          curve: __isClicked ? $clickedCurveSizeIn : $clickedCurveSizeOut,
          child: widget.child,
        ),
      ),
    );
  }
}

class TouchEffectListTile extends ListTile {
  /// Highlight color when tapped.
  final Color? $clickedColor;
  final double? $clickedRadius;
  final double? $clickedShrinkRatio;
  final Curve? $clickedCurveColorIn;
  final Curve? $clickedCurveColorOut;
  final Curve? $clickedCurveSizeIn;
  final Curve? $clickedCurveSizeOut;
  final Duration? $clickedDurationIn;
  final Duration? $clickedDurationOut;
  const TouchEffectListTile({
    Key? key,
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    Widget? trailing,
    bool isThreeLine = false,
    bool enabled = true,
    GestureTapCallback? onTap,
    GestureLongPressCallback? onLongPress,
    MouseCursor? mouseCursor,
    bool selected = false,
    Color? tileColor,
    Color? focusColor,
    Color? hoverColor,
    Color? selectedTileColor,
    ShapeBorder? shape,
    Clip clipBehavior = Clip.none,
    FocusNode? focusNode,
    bool autofocus = false,
    MaterialTapTargetSize? materialTapTargetSize,
    double? minVerticalPadding,
    bool? enableFeedback,
    EdgeInsetsGeometry? contentPadding,
    this.$clickedColor,
    this.$clickedRadius,
    this.$clickedShrinkRatio,
    this.$clickedCurveColorIn,
    this.$clickedCurveColorOut,
    this.$clickedCurveSizeIn,
    this.$clickedCurveSizeOut,
    this.$clickedDurationIn,
    this.$clickedDurationOut,
  }) : super(
          key: key,
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          isThreeLine: isThreeLine,
          enabled: enabled,
          onTap: onTap,
          onLongPress: onLongPress,
          mouseCursor: mouseCursor,
          selected: selected,
          tileColor: tileColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          selectedTileColor: selectedTileColor,
          shape: shape,
          focusNode: focusNode,
          autofocus: autofocus,
          minVerticalPadding: minVerticalPadding,
          enableFeedback: enableFeedback,
          contentPadding: contentPadding,
        );

  @override
  Widget build(BuildContext context) {
    return TouchEffectWrapper(
      $clickedColor: $clickedColor,
      $clickedRadius: $clickedRadius,
      $clickedShrinkRatio: $clickedShrinkRatio,
      $clickedCurveColorIn: $clickedCurveColorIn,
      $clickedCurveColorOut: $clickedCurveColorOut,
      $clickedCurveSizeIn: $clickedCurveSizeIn,
      $clickedCurveSizeOut: $clickedCurveSizeOut,
      $clickedDurationIn: $clickedDurationIn,
      $clickedDurationOut: $clickedDurationOut,
      child: super.build(context),
    );
  }
}

class TouchEffectInkWell extends InkWell {
  /// Highlight color when tapped.
  final Color? $clickedColor;
  final double? $clickedRadius;
  final double? $clickedShrinkRatio;
  final Curve? $clickedCurveColorIn;
  final Curve? $clickedCurveColorOut;
  final Curve? $clickedCurveSizeIn;
  final Curve? $clickedCurveSizeOut;
  final Duration? $clickedDurationIn;
  final Duration? $clickedDurationOut;
  const TouchEffectInkWell({
    Widget? child,
    Key? key,
    GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    GestureLongPressStartCallback? onLongPressStart,
    GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate,
    GestureLongPressUpCallback? onLongPressUp,
    GestureLongPressEndCallback? onLongPressEnd,
    GestureTapDownCallback? onTapDown,
    GestureTapCancelCallback? onTapCancel,
    ValueChanged<bool>? onHighlightChanged,
    ValueChanged<bool>? onHover,
    MouseCursor? mouseCursor,
    InteractiveInkFeatureFactory? splashFactory,
    double? radius,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    bool enableFeedback = true,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    Brightness? splashFactoryBrightness,
    InteractiveInkFeatureFactory? highlightFactory,
    bool excludeFromSemantics = false,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    VoidCallback? onFocusChange,
    bool autofocus = false,
    MaterialStatesController? statesController,
    this.$clickedColor,
    this.$clickedRadius,
    this.$clickedShrinkRatio,
    this.$clickedCurveColorIn,
    this.$clickedCurveColorOut,
    this.$clickedCurveSizeIn,
    this.$clickedCurveSizeOut,
    this.$clickedDurationIn,
    this.$clickedDurationOut,
  }) : super(
          key: key,
          child: child,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          onTapDown: onTapDown,
          onTapCancel: onTapCancel,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          mouseCursor: mouseCursor,
          splashFactory: splashFactory,
          radius: radius,
          borderRadius: borderRadius,
          customBorder: customBorder,
          enableFeedback: enableFeedback,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          excludeFromSemantics: excludeFromSemantics,
          focusNode: focusNode,
          canRequestFocus: canRequestFocus,
          autofocus: autofocus,
          statesController: statesController,
        );

  @override
  Widget build(BuildContext context) {
    return TouchEffectWrapper(
      $clickedColor: $clickedColor,
      $clickedRadius: $clickedRadius,
      $clickedShrinkRatio: $clickedShrinkRatio,
      $clickedCurveColorIn: $clickedCurveColorIn,
      $clickedCurveColorOut: $clickedCurveColorOut,
      $clickedCurveSizeIn: $clickedCurveSizeIn,
      $clickedCurveSizeOut: $clickedCurveSizeOut,
      $clickedDurationIn: $clickedDurationIn,
      $clickedDurationOut: $clickedDurationOut,
      child: super.build(context),
    );
  }
}
