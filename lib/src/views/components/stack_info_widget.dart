import 'package:dsa_visualiser/src/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StackInfoWidget extends StatelessWidget {
  const StackInfoWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        const Gap(20.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colours.primaryLight.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(value, style: const TextStyle(color: Colours.black)),
        )
      ],
    );
  }
}
