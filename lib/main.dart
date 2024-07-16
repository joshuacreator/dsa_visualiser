import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dsa_visualiser/src/utils/colours.dart';
import 'package:dsa_visualiser/src/utils/dimensions.dart';
import 'package:dsa_visualiser/src/views/screens/splash_screen.dart';

// Main function where the app starts
void main() {
  // Ensuring Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Setting the device orientation to portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Running the app with Riverpod's ProviderScope
  runApp(
    ProviderScope(
      child: Builder(
        builder: (context) {
          // Initializing the Dimensions class
          Dimensions().init(context);

          // Getting the dimension from the Dimensions class
          dimension = Dimensions.dimension!;

          // Returning the MyApp widget
          return const MyApp();
        },
      ),
    ),
  );
}

// MyApp widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Returning a MaterialApp widget
    return MaterialApp(
      title: 'DSA VISUALIZER', // App title
      theme: ThemeData(
        // Setting the color scheme and theme data
        colorScheme: ColorScheme.fromSeed(seedColor: Colours.primary),
        useMaterial3: true,
        scaffoldBackgroundColor: Colours.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
      ),
      home: const SplashScreen(), // Home screen is the splash screen
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:dsa_visualiser/src/utils/colours.dart';
// import 'package:dsa_visualiser/src/utils/dimensions.dart';
// import 'package:dsa_visualiser/src/views/screens/splash_screen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
//   runApp(
//     ProviderScope(
//       child: Builder(
//         builder: (context) {
//           Dimensions().init(context);
//           dimension = Dimensions.dimension!;
//           return const MyApp();
//         },
//       ),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'DSA VISUALIZER',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colours.primary),
//         useMaterial3: true,
//         scaffoldBackgroundColor: Colours.white,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           surfaceTintColor: Colors.white,
//         ),
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }
