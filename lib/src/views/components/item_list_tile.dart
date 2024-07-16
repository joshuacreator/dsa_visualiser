import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';

import '../../utils/dimensions.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.tileColour,
  });
  final String title, subtitle;
  final VoidCallback onTap;
  final Color tileColour;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.0),
      child: Ink(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: tileColour,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.keyboard_arrow_right_rounded, size: dimension),
              ],
            ),
            const Gap(5.0),
            ReadMoreText(
              subtitle,
              trimMode: TrimMode.Line,
              trimLines: 7,
              trimExpandedText: "less",
              trimCollapsedText: "more",
              colorClickableText: Colors.red,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black87,
              ),
            ),
            const Gap(5.0),
          ],
        ),
      ),
    );
  }
}
