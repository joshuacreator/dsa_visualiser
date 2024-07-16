import 'package:dsa_visualiser/src/utils/colours.dart';
import 'package:dsa_visualiser/src/utils/navigator.dart';
import 'package:dsa_visualiser/src/views/screens/merge_screen.dart';
import 'package:dsa_visualiser/src/views/screens/stack_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../components/item_list_tile.dart';

// Class for the home screen widget
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

// Class for the home screen state
class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Set the system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colours.transparent, // Transparent status bar
        systemNavigationBarColor: Colours.white, // White navigation bar
      ),
    );

    // Return a scaffold widget
    return Scaffold(
      appBar: AppBar(
        title: const Text("DSA VISUALIZER"), // App bar title
        centerTitle: true, // Center the title
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0), // Padding for the list view
        children: [
          ItemListTile(
            title: "Stack",
            subtitle:
                "The stack data structure is a linear data structure that accompanies a principle known as LIFO (Last In First Out) or FILO (First In Last Out)", // Subtitle
            tileColour: Colours.primary.withOpacity(0.3), // Tile color
            onTap: () {
              Navigate.to(
                context,
                const StackScreen(),
              );
            },
          ),
          const Gap(10.0),
          ItemListTile(
            title: "Merge sort algorithm", // Title
            subtitle:
                "Merge sort is one of the most efficient sorting algorithms. It works on the principle of Divide and Conquer based on the idea of breaking down a list into several sub-lists until each sublist consists of a single element and merging those sublists in a manner that results into a sorted list.", // Subtitle
            tileColour: Colours.secondary.withOpacity(0.3), // Tile color
            onTap: () {
              Navigate.to(
                context,
                const MergeScreen(),
              ); // Navigate to the merge screen
            },
          ),
        ],
      ),
    );
  }
}
