library clicky_flutter;

import 'package:clicky_flutter/styles.dart';
import 'package:flutter/material.dart';

bool _globalClickyInEffect = false;

class Clicky extends StatefulWidget {
  /// the widget that will be wrapped by the clicky effect
  final Widget child;

  /// This defines the color of the clicky effect,
  ///
  /// which is the color of the container that will fade in and out when the widget is clicked.
  final Color clickyColor;

  /// This defines the border radius of the clicky effect,
  ///
  /// which is the border radius of the container that will fade in and out when the widget is clicked.
  final double clickyBorderRadius;

  /// This defines the shrink ratio of the clicky effect.
  ///
  /// The clicky effect will shrink by this ratio when the widget is clicked. (eg. 0.05 means 5% shrink)
  final double clickyShrinkRatio;

  /// This defines the curve of the color fade in effect of the clicky effect.
  /// The default value is [Curves.easeOut].
  /// See [Curves] for more details.
  final Curve clickyCurveColorIn;
  final Curve clickyCurveColorOut;
  final Curve clickyCurveSizeIn;
  final Curve clickyCurveSizeOut;
  final Duration clickyDurationIn;
  final Duration clickyDurationOut;
  final TouchBoundStyles clickyTouchBoundStyles;

  const Clicky({
    Key? key,
    required this.child,
    this.clickyColor = const Color.fromARGB(18, 0, 0, 0),
    this.clickyBorderRadius = 0,
    this.clickyShrinkRatio = 0.05,
    this.clickyCurveColorIn = Curves.easeOut,
    this.clickyCurveColorOut = Curves.easeOut,
    this.clickyCurveSizeIn = Curves.easeOut,
    this.clickyCurveSizeOut = Curves.easeOut,
    this.clickyDurationIn = const Duration(milliseconds: 70),
    this.clickyDurationOut = const Duration(milliseconds: 70),
    this.clickyTouchBoundStyles = TouchBoundStyles.byInitialTouchPoint,
  }) : super(key: key);

  @override
  ClickyState createState() => ClickyState();
}

class ClickyState extends State<Clicky> with SingleTickerProviderStateMixin {
  double _scale = 1;
  bool _isClicked = false;
  Color? clickyColor;
  double? clickyBorderRadius;
  double? clickyShrinkRatio;
  Curve? clickyCurveColorIn;
  Curve? clickyCurveColorOut;
  Curve? clickyCurveSizeIn;
  Curve? clickyCurveSizeOut;
  Duration? clickyDurationIn;
  Duration? clickyDurationOut;
  TouchBoundStyles? touchBoundStyles;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color clickyColor = widget.clickyColor;
    double clickyBorderRadius = widget.clickyBorderRadius;
    double clickyShrinkRatio = widget.clickyShrinkRatio;
    Curve clickyCurveColorIn = widget.clickyCurveColorIn;
    Curve clickyCurveColorOut = widget.clickyCurveColorOut;
    Curve clickyCurveSizeIn = widget.clickyCurveSizeIn;
    Curve clickyCurveSizeOut = widget.clickyCurveSizeOut;
    Duration clickyDurationIn = widget.clickyDurationIn;
    Duration clickyDurationOut = widget.clickyDurationOut;
    TouchBoundStyles touchBoundStyles = widget.clickyTouchBoundStyles;

    List<double> _initialTouchPoint = [0, 0];

    return GestureDetector(
      // disable multi-touch
      behavior: HitTestBehavior.opaque,

      onPanEnd: (details) {
        setState(() {
          _scale = 1;
          _isClicked = false;
        });
        _globalClickyInEffect = false;
      },
      onPanDown: (details) {
        if (_globalClickyInEffect) {
          return;
        }
        setState(() {
          _scale = 1 - clickyShrinkRatio;
          _isClicked = true;
        });
        _globalClickyInEffect = true;
      },
      onPanStart: (details) {
        // save the initial touch point
        _initialTouchPoint = [details.globalPosition.dx, details.globalPosition.dy];
      },
      onPanCancel: () {
        setState(() {
          _scale = 1;
          _isClicked = false;
        });
        _globalClickyInEffect = false;
      },
      onPanUpdate: (details) {
        // if (_globalClickyInEffect) {
        //   return;
        // }
        //! EFFECT DISABLING BOUND DEPENDS ON THE CONTEXT SIZE
        // if touch position is too far (50 px) from the context size, cancel the effect.
        if (touchBoundStyles == TouchBoundStyles.byContextSize) {
          if (details.localPosition.dx < -50 ||
              details.localPosition.dx > context.size!.width + 50 ||
              details.localPosition.dy < -50 ||
              details.localPosition.dy > context.size!.height + 50) {
            setState(() {
              _scale = 1;
              _isClicked = false;
            });
          }
          //! EFFECT DISABLING BOUND DEPENDS ON THE TOUCHED POINT
          // if touch position is moved too far (80 px) from the initial touch point, cancel the effect.
        } else if (touchBoundStyles == TouchBoundStyles.byInitialTouchPoint) {
          if ((details.globalPosition.dx - _initialTouchPoint[0]).abs() > 80 ||
              (details.globalPosition.dy - _initialTouchPoint[1]).abs() > 80) {
            setState(() {
              _scale = 1;
              _isClicked = false;
            });
          }
        }
      },
      child: AnimatedContainer(
        padding: EdgeInsets.all(0),
        duration: _isClicked ? clickyDurationIn : clickyDurationOut,
        curve: _isClicked ? clickyCurveColorIn : clickyCurveColorOut,
        decoration: BoxDecoration(
          color: _isClicked ? clickyColor : clickyColor.withAlpha(0),
          borderRadius: BorderRadius.circular(clickyBorderRadius),
        ),
        child: AnimatedScale(
          scale: _scale,
          duration: _isClicked ? clickyDurationIn : clickyDurationOut,
          curve: _isClicked ? clickyCurveSizeIn : clickyCurveSizeOut,
          child: widget.child,
        ),
      ),
    );
  }
}
