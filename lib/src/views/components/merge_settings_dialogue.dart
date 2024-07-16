import 'dart:math';

import 'package:dsa_visualiser/src/utils/dimensions.dart';
import 'package:dsa_visualiser/src/views/components/app_text_form_field.dart';
import 'package:dsa_visualiser/src/views/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MergeSortSettingsDialogue extends StatefulWidget {
  const MergeSortSettingsDialogue({super.key});

  @override
  State<MergeSortSettingsDialogue> createState() =>
      _MergeSortSettingsDialogueState();
}

class _MergeSortSettingsDialogueState extends State<MergeSortSettingsDialogue> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: dimension / 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Array size",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Row(children: [Text("Change the number of bars on-screen")]),
            Gap(dimension / 2),
            Form(
              key: _key,
              child: AppTextFormField(
                controller: controller,
                validator: (value) {
                  if (int.parse(value ?? "0") < 10) {
                    return "Value must not be less than 10";
                  }
                  if (int.parse(value ?? "0") > 1000) {
                    return "Value cannot be greater than 1000";
                  }
                  return null;
                },
                autofocus: true,
              ),
            ),
            Gap(dimension),
            SizedBox(
              width: double.infinity,
              child: AppElevatedButton(
                label: "Save",
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    Navigator.pop(
                      context,
                      List.generate(
                        int.parse(controller.text.trim()),
                        (index) => Random().nextInt(1000) + 10,
                      ),
                    );
                  }
                  // TODO: Update array size
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
