import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:dsa_visualiser/src/helpers/snack_bar.dart';
import 'package:dsa_visualiser/src/models/stack_model.dart';
import 'package:dsa_visualiser/src/utils/assets.dart';
import 'package:dsa_visualiser/src/utils/colours.dart';
import 'package:dsa_visualiser/src/views/components/app_text_form_field.dart';
import 'package:dsa_visualiser/src/views/components/buttons.dart';
import 'package:dsa_visualiser/src/views/components/stack_info_widget.dart';
import 'package:dsa_visualiser/src/views/components/stack_widget.dart';

// Creating a stateful widget for the stack screen
class StackScreen extends ConsumerStatefulWidget {
  const StackScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StackScreenState();
}

// Creating a state class for the stack screen
class _StackScreenState extends ConsumerState<StackScreen> {
  final controller = TextEditingController(); // Controller for the text field
  final player = AudioPlayer(); // Audio player for sound effects

  @override
  Widget build(BuildContext context) {
    final stack = ref.watch(stackProvider); // Watching the stack provider
    final bottom =
        MediaQuery.viewInsetsOf(context).bottom; // Getting the bottom inset

    return Scaffold(
      backgroundColor: Colours.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Stack"),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       showModalBottomSheet(
        //         context: context,
        //         isScrollControlled: true,
        //         useSafeArea: true,
        //         builder: (context) => const StackInfoScreen(),
        //       );
        //     },
        //     icon: const Icon(Icons.info_outlined),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: StackWidget(stack: stack),
            ),
            const Gap(20.0),
            Container(
              color: Colours.white,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextFormField(
                    controller: controller, // Controller for the text field
                    onChanged: (_) {
                      setState(() {}); // Updating the state
                    },
                    readOnly: (stack?.length ?? 0) ==
                        10, // Disabling the text field if the stack is full
                    onTap: () {
                      if ((stack?.length ?? 0) == 10) {
                        showSnackbar(
                          context,
                          text:
                              "The stack is full oo.\nOya clap for yourself 😂",
                        );
                      }
                    },
                  ),
                  const Gap(10.0),
                  Row(
                    children: [
                      Expanded(
                        child: AppElevatedButton(
                          label: "Push", // Label of the push button
                          onPressed: controller.text.isEmpty ||
                                  (stack?.length ?? 0) == 10
                              ? null
                              : () {
                                  if (int.parse(controller.text.trim()) == 0) {
                                    showSnackbar(
                                      context,
                                      text:
                                          "0 cannot be added to the stack obviously 😒",
                                    );
                                    return;
                                  }
                                  if (int.parse(controller.text.trim()) >
                                      1000000) {
                                    showSnackbar(
                                      context,
                                      text:
                                          "That's too large 🧐 try a smaller number 🤷🏾",
                                    );
                                    return;
                                  }
                                  player.stop(); // Stopping the audio player
                                  player.play(AssetSource(Audios
                                      .swoosh)); // Playing the swoosh sound
                                  ref.read(stackProvider.notifier).push(StackItem(
                                      value: controller
                                          .text)); // Pushing the item to the stack
                                  controller.clear(); // Clearing the text field
                                },
                        ),
                      ),
                      const Gap(10.0),
                      Expanded(
                        child: AppElevatedButton(
                          label: "Pop", // Label of the "Pop" button
                          onPressed: (stack?.isEmpty ??
                                  true) // Checking if the stack is empty
                              ? null
                              : () {
                                  player.stop(); // Stopping the audio player
                                  player.play(AssetSource(
                                      Audios.pop)); // Playing the pop sound

                                  // Resetting the stack if there's only one item left
                                  // Otherwise, removing the last item
                                  if (stack!.length == 1) {
                                    ref.read(stackProvider.notifier).reset();
                                    return;
                                  }
                                  ref
                                      .read(stackProvider.notifier)
                                      .pop(stack.last.value);
                                },
                        ),
                      ),
                      const Gap(10.0),
                      Expanded(
                        child: AppElevatedButton(
                          label: "Reset", // Label of the "Reset" button
                          onPressed: (stack?.isEmpty ??
                                  true) // Checking if the stack is empty
                              ? null
                              : () {
                                  player.stop(); // Stopping the audio player
                                  player.play(AssetSource(Audios
                                      .swoosh)); // Playing the swoosh sound
                                  ref
                                      .read(stackProvider.notifier)
                                      .reset(); // Resetting the stack
                                },
                          backgroundColor: Colours
                              .red, // Background color of the "Reset" button
                        ),
                      ),
                    ],
                  ),
                  const Gap(10.0),
                  Visibility(
                    visible:
                        bottom == 0, // Checking if the keyboard is not visible
                    child: Column(
                      children: [
                        // Stack info widget for the top of the stack
                        StackInfoWidget(
                          title: "Top of Stack",
                          value: "${stack?.last.value}",
                        ),

                        // Gap between the stack info widgets
                        const Gap(10.0),

                        // Stack info widget for the isEmpty property
                        StackInfoWidget(
                          title: "isEmpty",
                          value: "${stack?.isEmpty ?? true}",
                        ),

                        // Gap between the stack info widgets
                        const Gap(10.0),

                        // Stack info widget for the length of the stack
                        StackInfoWidget(
                          title: "Length",
                          value: "${stack?.length ?? 0}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
