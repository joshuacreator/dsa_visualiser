// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dsa_visualiser/src/utils/assets.dart';
import 'package:dsa_visualiser/src/utils/colours.dart';
import 'package:dsa_visualiser/src/utils/dimensions.dart';
import 'package:dsa_visualiser/src/utils/navigator.dart';
import 'package:dsa_visualiser/src/views/components/buttons.dart';
import 'package:dsa_visualiser/src/views/screens/home_screen.dart';

// Creating a stateful widget for the splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Creating a state class for the splash screen
class _SplashScreenState extends State<SplashScreen> {
  bool animate = false; // Variable to control the animation

  @override
  void initState() {
    super.initState();
    startAnimation(); // Starting the animation when the widget is initialized
  }

  // Function to start the animation
  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Delaying the animation by 500 milliseconds
    setState(() {
      animate = true; // Setting the animation variable to true
    });
  }

  @override
  Widget build(BuildContext context) {
    // Setting the system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colours.transparent,
        systemNavigationBarColor: Colours.primary,
      ),
    );

    // Defining the curve and duration for the animation
    const curve = Curves.linear;
    const duration = Duration(milliseconds: 1600);

    // Returning a scaffold widget
    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: Stack(
          children: [
            // Animated positioned widget for the girl image
            AnimatedPositioned(
              duration: duration,
              curve: curve,
              bottom: animate ? 0.0 : -100.0,
              right: animate ? 0.0 : -100.0,
              child: Image.asset(
                Images.girlPng,
                height: dimension * 12,
              ),
            ),
            // Animated positioned widget for the text
            AnimatedPositioned(
              duration: duration,
              curve: curve,
              bottom: Dimensions.height! / 3,
              left: animate ? 15.0 : -100.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "GROUP 8",
                    style: TextStyle(
                      fontSize: dimension / 1.5,
                      fontWeight: FontWeight.w700,
                      color: Colours.white,
                    ),
                  ),
                  Text(
                    "STACK\nAND\nMERGE\nSORT",
                    style: TextStyle(
                      fontSize: dimension * 1.6,
                      fontWeight: FontWeight.w900,
                      color: Colours.white,
                    ),
                  ),
                ],
              ),
            ),
            // Animated positioned widget for the continue button
            AnimatedPositioned(
              duration: duration,
              curve: curve,
              bottom: animate ? dimension / 1.2 : -100.0,
              left: 10.0,
              right: 10.0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  10.0,
                  0.0,
                  10.0,
                  dimension / 3,
                ),
                child: AppElevatedButton(
                  label: "Continue",
                  onPressed: () =>
                      Navigate.replaceWith(context, const HomeScreen()),
                  backgroundColor: Colours.white,
                  foregroundColor: Colours.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:dsa_visualiser/src/utils/assets.dart';
// import 'package:dsa_visualiser/src/utils/colours.dart';
// import 'package:dsa_visualiser/src/utils/dimensions.dart';
// import 'package:dsa_visualiser/src/utils/navigator.dart';
// import 'package:dsa_visualiser/src/views/components/buttons.dart';
// import 'package:dsa_visualiser/src/views/screens/home_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   bool animate = false;

//   @override
//   void initState() {
//     super.initState();
//     startAnimation();
//   }

//   Future startAnimation() async {
//     await Future.delayed(const Duration(milliseconds: 500));

//     setState(() {
//       animate = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colours.transparent,
//         systemNavigationBarColor: Colours.primary,
//       ),
//     );

//     const curve = Curves.linear;

//     const duration = Duration(milliseconds: 1600);

//     return Scaffold(
//       backgroundColor: Colours.primary,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             AnimatedPositioned(
//               duration: duration,
//               curve: curve,
//               bottom: animate ? 0.0 : -100.0,
//               right: animate ? 0.0 : -100.0,
//               child: Image.asset(Images.girlPng, height: dimension * 12),
//             ),
//             AnimatedPositioned(
//               duration: duration,
//               curve: curve,
//               bottom: Dimensions.height! / 3,
//               left: animate ? 15.0 : -100.0,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     "GROUP 8",
//                     style: TextStyle(
//                       fontSize: dimension / 1.5,
//                       fontWeight: FontWeight.w700,
//                       color: Colours.white,
//                     ),
//                   ),
//                   Text(
//                     "STACK\nAND\nMERGE\nSORT",
//                     style: TextStyle(
//                       fontSize: dimension * 1.6,
//                       fontWeight: FontWeight.w900,
//                       color: Colours.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             AnimatedPositioned(
//               duration: duration,
//               curve: curve,
//               bottom: animate ? dimension / 1.2 : -100.0,
//               left: 10.0,
//               right: 10.0,
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, dimension / 3),
//                 child: AppElevatedButton(
//                   label: "Continue",
//                   onPressed: () =>
//                       Navigate.replaceWith(context, const HomeScreen()),
//                   backgroundColor: Colours.white,
//                   foregroundColor: Colours.primary,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
