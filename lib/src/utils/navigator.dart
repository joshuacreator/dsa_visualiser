import 'package:flutter/cupertino.dart';

class Navigate {
  static void to(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => screen),
    );
  }

  static void replaceWith(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => screen),
    );
  }
}
