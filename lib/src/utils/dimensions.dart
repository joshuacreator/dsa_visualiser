// Importing the necessary package
import 'package:flutter/material.dart';

// Creating a class called Dimensions
class Dimensions {
  // Declaring static variables
  static MediaQueryData? _mediaQuery; // To store the media query data
  static double? height; // To store the height of the screen
  static double? width; // To store the width of the screen
  static double? dimension; // To store a calculated dimension
  static Orientation? _orientation; // To store the orientation of the screen

  // A method to initialize the dimensions
  void init(BuildContext context) {
    // Getting the media query data
    _mediaQuery = MediaQuery.of(context);

    // Calculating the height and width of the screen
    height = _mediaQuery?.size.height;
    width = _mediaQuery?.size.width;

    // Calculating a dimension based on the orientation
    dimension = _orientation == Orientation.landscape
        ? height! * 0.1
        : width! * 0.1;
  }
}

// Declaring a variable to store a dimension
double dimension = 0;




// import 'package:flutter/material.dart';

// class Dimensions {
//   static MediaQueryData? _mediaQuery;
//   static double? height;
//   static double? width;
//   static double? dimension;
//   static Orientation? _orientation;

//   void init(BuildContext context) {
//     _mediaQuery = MediaQuery.of(context);

//     height = _mediaQuery?.size.height;
//     width = _mediaQuery?.size.width;
//     dimension =
//         _orientation == Orientation.landscape ? height! * 0.1 : width! * 0.1;
//   }
// }

// double dimension = 0;
