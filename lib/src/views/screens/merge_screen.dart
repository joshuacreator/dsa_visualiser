import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:dsa_visualiser/src/helpers/snack_bar.dart';
import 'package:dsa_visualiser/src/utils/assets.dart';
import 'package:dsa_visualiser/src/utils/colours.dart';
import 'package:dsa_visualiser/src/views/components/buttons.dart';
import 'package:dsa_visualiser/src/views/components/merge_settings_dialogue.dart';

// Creating a provider for the array state
final arrayProvider = StateProvider.autoDispose<List<int>>((ref) {
  return []; // Initial value is an empty list
});

// Creating a widget for the merge sort screen
class MergeScreen extends ConsumerStatefulWidget {
  const MergeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MergeScreenState();
}

class _MergeScreenState extends ConsumerState<MergeScreen> {
  // Audio players for sound effects
  final ticPlayer1 = AudioPlayer();
  final ticPlayer2 = AudioPlayer();
  final ticPlayer3 = AudioPlayer();
  final ticPlayer4 = AudioPlayer();
  final ticPlayer5 = AudioPlayer();
  final ticPlayer6 = AudioPlayer();
  final bellaCiaoPlayer = AudioPlayer();

  // Speed of the sorting algorithm (lower values are faster)
  double speed = 0.55;

  // Flags for the sorting process
  bool complete = true; // Whether the sorting is complete
  bool stopSorting = false; // Whether to stop the sorting process
  bool mute = false; // Whether to mute the sound effects

  // Index of the current element being sorted
  int currentIndex = 0;

  // List of sorted elements
  List<int> sortedArr = [];

  // Original list of random integers
  List<int> arr = List.generate(
    Random().nextInt(1000) + 10, // Length of the list (between 10 and 1009)
    (index) =>
        Random().nextInt(1000) + 10, // Element value (between 10 and 1009)
  );

  // Timer for measuring the sorting time
  Stopwatch timer = Stopwatch();

  @override
  void initState() {
    super.initState();
    // Setting the "Bella Ciao" player to loop mode
    bellaCiaoPlayer.setReleaseMode(ReleaseMode.loop);
  }

  @override
  void dispose() {
    // Disposing the audio players to free up resources
    ticPlayer1.dispose();
    ticPlayer2.dispose();
    ticPlayer3.dispose();
    ticPlayer4.dispose();
    ticPlayer5.dispose();
    ticPlayer6.dispose();
    bellaCiaoPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return PopScope(
      onPopInvoked: (didPop) {
        stopSorting = true;
        timer.stop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Merge Sort"),
          centerTitle: true,
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       showModalBottomSheet(
          //         context: context,
          //         isScrollControlled: true,
          //         useSafeArea: true,
          //         builder: (context) => const MergeInfoScreen(),
          //       );
          //     },
          //     icon: const Icon(Icons.info_outlined),
          //   ),
          // ],
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    timer.elapsed.inMilliseconds == 0
                        ? "Ready to sort"
                        : "${complete ? "Sort completed in" : "Sorting:"} ${timer.elapsed.toString()}",
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      arr.length,
                      (index) => Container(
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colours.red
                              : Colours.primary,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: (arr[index] / 2).toDouble(),
                        width: width / arr.length,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        persistentFooterButtons: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text(
                    "Speed",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  // Expanded widget to take up the remaining space
                  Expanded(
                    child: Slider(
                      value: speed, // Initial value of the slider
                      label:
                          "${(speed * 10).floor()}x", // Label to display the speed value
                      divisions: 10, // Number of divisions on the slider
                      min: 0.1, // Minimum value of the slider
                      onChanged: (value) {
                        // Callback when the slider value changes
                        setState(() {
                          speed = value; // Update the speed value
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CircularButton(
                      // Icon to display based on the mute state
                      icon: mute
                          ? Icons
                              .volume_off_rounded // Display volume off icon if mute is true
                          : Icons
                              .volume_up_rounded, // Display volume up icon if mute is false
                      onTap: () {
                        setState(() {
                          // Toggle the mute state
                          if (mute) {
                            mute = !mute;
                            // Unmute the players
                            ticPlayer1.setVolume(1);
                            ticPlayer2.setVolume(1);
                            ticPlayer3.setVolume(1);
                            ticPlayer4.setVolume(1);
                            ticPlayer5.setVolume(1);
                            ticPlayer6.setVolume(1);
                            bellaCiaoPlayer.setVolume(1);
                          } else {
                            mute = !mute;
                            // Mute the players
                            ticPlayer1.setVolume(0);
                            ticPlayer2.setVolume(0);
                            ticPlayer3.setVolume(0);
                            ticPlayer4.setVolume(0);
                            ticPlayer5.setVolume(0);
                            ticPlayer6.setVolume(0);
                            bellaCiaoPlayer.setVolume(0);
                          }
                        });
                      },
                    ),
                  ),
                  const Gap(10.0),
                  Expanded(
                    child: CircularButton(
                      // Icon for the button
                      icon: Icons.shuffle_rounded, // Shuffle icon
                      onTap: () {
                        // Callback for when the button is tapped
                        reset(); // Call the reset function
                      },
                    ),
                  ),
                  const Gap(10.0),
                  Expanded(
                    child: CircularButton(
                      // Icon for the button
                      icon: Icons.tune_rounded, // Tune icon
                      onTap: !complete
                          ? null // If the sorting is not complete, disable the button
                          : () async {
                              // Callback for when the button is tapped
                              // Show a dialog to adjust merge sort settings
                              arr = await showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const MergeSortSettingsDialogue(),
                                  ) ??
                                  arr;
                              setState(() {}); // Update the state
                              // Update the array provider with the new array
                              ref
                                  .read(arrayProvider.notifier)
                                  .update((_) => arr);
                            },
                      colour: !complete
                          ? Colours
                              .secondary // If the sorting is not complete, use secondary color
                          : null, // Otherwise, use the default color
                    ),
                  ),
                  const Gap(10.0),
                  CircularButton(
                    // Icon for the button
                    icon: Icons.play_arrow_rounded, // Play icon
                    onTap: !complete
                        ? null // If the sorting is not complete, disable the button
                        : arr == sortedArr
                            ? () => showSnackbar(
                                  context,
                                  text: "Array sorted! Reset to sort again",
                                ) // If the array is already sorted, show a snackbar
                            : () async {
                                // Callback for when the button is tapped
                                // Update the array provider with the current array
                                ref
                                    .read(arrayProvider.notifier)
                                    .update((_) => arr);
                                // Call the mergeSort function to start the sorting process
                                await mergeSort();
                              },
                    colour: !complete
                        ? Colours
                            .secondary // If the sorting is not complete, use secondary color
                        : null, // Otherwise, use the default color
                    isLarge: true, // Make the button larger
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  // Function to perform the merge sort algorithm
  Future<void> mergeSort() async {
    // Playing the "Bella Ciao" sound effect
    bellaCiaoPlayer.play(AssetSource(Audios.bellaCiao));

    // Updating the state to start the timer and reset flags
    setState(() {
      timer.start(); // Starting the timer
      stopSorting = false; // Allowing the sorting process to continue
      complete = false; // Setting the complete flag to false
    });

    // Calling the helper function to perform the merge sort
    await _mergeSortHelper(0, arr.length - 1);

    // Updating the state to indicate completion and reset speed
    setState(() {
      complete = true; // Setting the complete flag to true
      speed = 0.55; // Resetting the speed
    });

    // Stopping all the sound effects
    ticPlayer1.stop();
    ticPlayer2.stop();
    ticPlayer3.stop();
    ticPlayer4.stop();
    ticPlayer5.stop();
    ticPlayer6.stop();
    bellaCiaoPlayer.stop();
  }

  // Reset function to reset the state of the sorting algorithm
  void reset() async {
    setState(() {
      // Resetting the timer
      timer = Stopwatch();

      // Stopping the sorting process
      stopSorting = true;

      // Setting the complete flag to true
      complete = true;

      // Generating a new list of random integers
      arr = List.generate(
        Random().nextInt(1000) + 10, // Length of the list (between 10 and 1009)
        (index) =>
            Random().nextInt(1000) + 10, // Element value (between 10 and 1009)
      );

      // Resetting the current index
      currentIndex = 0;

      // Resetting the speed
      speed = 0.55;

      // Resetting the sorted array
      sortedArr = [];
    });
  }

  // Helper function for the merge sort algorithm
  Future<void> _mergeSortHelper(int startIndex, int endIndex) async {
    if (stopSorting) {
      return;
    } // Checking if the sorting process should be stopped

    if (startIndex < endIndex) {
      // Checking if the start index is less than the end index
      int midIndex = (startIndex + endIndex) ~/ 2; // Calculating the mid index

      // Recursively sorting the left subarray
      await _mergeSortHelper(startIndex, midIndex);

      // Recursively sorting the right subarray
      await _mergeSortHelper(midIndex + 1, endIndex);

      // Merging the sorted subarrays
      await _merge(startIndex, midIndex, endIndex);
    }
  }

  // Merging two sorted subarrays
  Future<void> _merge(int startIndex, int midIndex, int endIndex) async {
    if (stopSorting) {
      return;
    } // Checking if the sorting process should be stopped

    int leftSubarrayLength =
        (midIndex - startIndex) + 1; // Length of the left subarray
    int rightSubarrayLength =
        (endIndex - midIndex); // Length of the right subarray

    List<int> leftSubarray =
        List<int>.filled(leftSubarrayLength, 0); // Left subarray
    List<int> rightSubarray =
        List<int>.filled(rightSubarrayLength, 0); // Right subarray

    int leftIndex,
        rightIndex,
        mergedIndex =
            startIndex; // Indexes for the subarrays and the merged array

    // Copying elements from the main array to the left subarray
    for (leftIndex = 0; leftIndex < leftSubarrayLength; ++leftIndex) {
      leftSubarray[leftIndex] = arr[mergedIndex++]; // Copying element
      ticPlayer1.stop(); // Stopping the audio player
      ticPlayer1.play(AssetSource(Audios.tic)); // Playing a sound effect
    }

    // Copying elements from the main array to the right subarray
    for (rightIndex = 0; rightIndex < rightSubarrayLength; ++rightIndex) {
      rightSubarray[rightIndex] = arr[mergedIndex++]; // Copying element
      ticPlayer2.stop(); // Stopping the audio player
      ticPlayer2.play(AssetSource(Audios.tic)); // Playing a sound effect
    }

    leftIndex = rightIndex = 0; // Resetting the indexes
    mergedIndex = startIndex; // Resetting the merged index

    // Merging the subarrays
    while (
        leftIndex != leftSubarrayLength && rightIndex != rightSubarrayLength) {
      if (stopSorting) {
        return;
      } // Checking if the sorting process should be stopped

      if (leftSubarray[leftIndex] < rightSubarray[rightIndex]) {
        setState(() {
          arr[mergedIndex] =
              leftSubarray[leftIndex]; // Copying element from the left subarray
          currentIndex = mergedIndex; // Updating the current index
        });
        ticPlayer3.stop(); // Stopping the audio player
        ticPlayer3.play(AssetSource(Audios.tic)); // Playing a sound effect
        leftIndex++; // Incrementing the left index
      } else {
        setState(() {
          arr[mergedIndex] = rightSubarray[
              rightIndex]; // Copying element from the right subarray
          currentIndex = mergedIndex; // Updating the current index
        });
        ticPlayer4.stop(); // Stopping the audio player
        ticPlayer4.play(AssetSource(Audios.tic)); // Playing a sound effect
        rightIndex++; // Incrementing the right index
      }
      mergedIndex++; // Incrementing the merged index

      // Delaying the execution for a short period
      await Future.delayed(Duration(
          milliseconds: (speed > 0.5 ? (50 / speed) : (100 / speed)).round()));
    }

    // Copying any remaining elements from the left subarray
    while (leftIndex != leftSubarrayLength) {
      if (stopSorting) {
        return;
      } // Checking if the sorting process should be stopped

      setState(() {
        arr[mergedIndex] =
            leftSubarray[leftIndex]; // Copying element from the left subarray
        currentIndex = mergedIndex; // Updating the current index
      });
      ticPlayer5.stop(); // Stopping the audio player
      ticPlayer5.play(AssetSource(Audios.tic)); // Playing a sound effect
      leftIndex++; // Incrementing the left index
      mergedIndex++; // Incrementing the merged index

      // Delaying the execution for a short period
      await Future.delayed(Duration(
          milliseconds: (speed > 0.5 ? (50 / speed) : (100 / speed)).round()));
    }

    // Copying any remaining elements from the right subarray
    while (rightIndex != rightSubarrayLength) {
      if (stopSorting) {
        return;
      } // Checking if the sorting process should be stopped

      setState(() {
        arr[mergedIndex] = rightSubarray[
            rightIndex]; // Copying element from the right subarray
        currentIndex = mergedIndex; // Updating the current index
      });
      ticPlayer6.stop(); // Stopping the audio player
      ticPlayer6.play(AssetSource(Audios.tic)); // Playing a sound effect
      rightIndex++; // Incrementing the right index
      mergedIndex++; // Incrementing the merged index

      // Delaying the execution for a short period
      await Future.delayed(
        Duration(
          milliseconds: (speed > 0.5 ? (50 / speed) : (100 / speed)).round(),
        ),
      );
    }
  }
}
