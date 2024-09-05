library clicky_flutter;

import 'styles.dart';
import 'package:flutter/material.dart';

bool _globalClickyInEffect = false;
bool _ignoring = true;

class Clicky extends StatefulWidget {
  /// the widget that will be wrapped by the clicky effect
  final Widget child;
  final ClickyStyle style;

  const Clicky({
    Key? key,
    required this.child,
    this.style = const ClickyStyle(),
  }) : super(key: key);

  @override
  ClickyState createState() => ClickyState();
}

class ClickyState extends State<Clicky> with SingleTickerProviderStateMixin {
  double _scale = 1;
  bool _isClicked = false;
  ClickyStyle get style => widget.style;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _turnOffClicky() {
    setState(() {
      _scale = 1;
      _isClicked = false;
    });
    _globalClickyInEffect = false;
    // dispose();
    _ignoring = true;
  }

  @override
  Widget build(BuildContext context) {
    List<double> initialTouchPoint = [0, 0];

    return GestureDetector(
      behavior: HitTestBehavior.translucent,

      // excludeFromSemantics: true,
      // onTapEnd: (details) {
      //   _turnOffClicky();
      // },

      // onTapDown: (details) {
      //   if (_globalClickyInEffect) {
      //     return;
      //   }
      //   setState(() {
      //     _scale = 1 - style.shrinkScale.byRatio();
      //     _isClicked = true;
      //   });
      //   _globalClickyInEffect = true;
      // },
      // onTapCancel: () {
      //   _turnOffClicky();
      // },

      child: Listener(
        onPointerCancel: (details) {
          _turnOffClicky();
        },
        onPointerDown: (details) {
          if (_globalClickyInEffect) {
            return;
          }
          setState(() {
            _scale = 1 - style.shrinkScale.byRatio();
            _isClicked = true;
          });
          _globalClickyInEffect = true;
        },
        onPointerUp: (details) {
          _turnOffClicky();
        },
        onPointerMove: (details) {
          // if (_globalClickyInEffect) {
          //   return;
          // }
          //EFFECT DISABLING BOUND DEPENDS ON THE CONTEXT SIZE
          // if touch position is too far from the context size, cancel the effect.

          double padding = style.boundaryFromWidgetOutline;
          double radius = style.boundaryFromInitialTouchPoint;

          /* Here is the explanation for the code below:
        1. The first if statement checks if the touch point is outside the widget's boundary and if it is,
        it checks if the touch point is outside the minimum radius.
        2. The second if statement checks if the touch point is outside the minimum radius and if it is,
        it checks if the touch point is outside the widget's boundary. */
          if (((details.localPosition.dx < -padding ||
                      details.localPosition.dx > context.size!.width + padding ||
                      details.localPosition.dy < -padding ||
                      details.localPosition.dy > context.size!.height + padding) &&
                  (style.boundaryStyle == ClickyBoundaryStyle.both ||
                      style.boundaryStyle == ClickyBoundaryStyle.fromWidgetOutline)) ||
              (((details.delta.dx).abs() > radius || (details.delta.dy).abs() > radius) &&
                  (style.boundaryStyle == ClickyBoundaryStyle.both ||
                      style.boundaryStyle == ClickyBoundaryStyle.fromInitialTouchPoint))) {
            _turnOffClicky();
          }
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.all(0),
          duration: _isClicked ? style.durationIn : style.durationOut,
          curve: _isClicked ? style.curveColorIn : style.curveColorOut,
          decoration: BoxDecoration(
            color: _isClicked ? style.color : style.color.withAlpha(0),
            borderRadius: BorderRadius.circular(style.borderRadius),
          ),
          child: AnimatedScale(
            scale: _scale,
            duration: _isClicked ? style.durationIn : style.durationOut,
            curve: _isClicked ? style.curveSizeIn : style.curveSizeOut,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
