library clicky_flutter;

import 'package:clicky_flutter/styles.dart';
import 'package:flutter/material.dart';

bool _globalClickyInEffect = false;

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
  Widget build(BuildContext context) {
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
          _scale = 1 - style.shrinkScale.byRatio();
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
        //EFFECT DISABLING BOUND DEPENDS ON THE CONTEXT SIZE
        // if touch position is too far (50 px) from the context size, cancel the effect.
        if (style.touchBoundStyles == TouchBoundStyles.byContextSize) {
          if (details.localPosition.dx < -50 ||
              details.localPosition.dx > context.size!.width + 50 ||
              details.localPosition.dy < -50 ||
              details.localPosition.dy > context.size!.height + 50) {
            setState(() {
              _scale = 1;
              _isClicked = false;
            });
          }
          //EFFECT DISABLING BOUND DEPENDS ON THE TOUCHED POINT
          // if touch position is moved too far (80 px) from the initial touch point, cancel the effect.
        } else if (style.touchBoundStyles == TouchBoundStyles.byInitialTouchPoint) {
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
    );
  }
}
