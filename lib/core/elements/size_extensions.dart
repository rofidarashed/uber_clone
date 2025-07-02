import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:uber/core/elements/globals.dart';

const defaultHeight = 874;
const defaultWidth = 402;
double getHeight(BuildContext context, num height) {
  return MediaQuery.of(context).size.height * height / defaultHeight;
}

double getWidth(BuildContext context, num width) {
  return MediaQuery.of(context).size.width * width / defaultWidth;
}

double getHeightFraction(BuildContext context, num fraction) {
  return MediaQuery.of(context).size.height * fraction;
}

double getWidthFraction(BuildContext context, num fraction) {
  return MediaQuery.of(context).size.width * fraction;
}

extension SizeExtension on num {
  /// Relative Height
  /// Normalize the specified number by design [defaultHeight]
  double get rh =>navigatorKey.currentContext == null
      ? toDouble()
      : getHeight(navigatorKey.currentContext!, this);

  /// Relative Width
  /// Normalize the specified number by design [defaultWidth]
  double get rw => navigatorKey.currentContext == null
      ? toDouble()
      : getWidth(navigatorKey.currentContext!, this);

  /// Relative Radius
  /// Normalize the specified number by the minumum of design [defaultWidth] and [defaultHeight]
  double get rr =>
      navigatorKey.currentContext == null ? toDouble() : min(rh, rw);
}

extension ContextSizeExtension on BuildContext {
  /// Shortcut to Get MediaQuery Height
  double get height => MediaQuery.of(this).size.height;

  /// Shortcut to Get MediaQuery Width
  double get width => MediaQuery.of(this).size.width;

  /// Shortcut to Get MediaQuery Data
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}
