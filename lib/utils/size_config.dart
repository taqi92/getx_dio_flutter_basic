import 'package:flutter/widgets.dart';

class SizeConfig {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  static Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }
}
