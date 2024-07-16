import 'package:dsa_visualiser/src/models/stack_model.dart';
import 'package:dsa_visualiser/src/utils/colours.dart';
import 'package:flutter/material.dart';

class StackWidget extends StatelessWidget {
  const StackWidget({
    super.key,
    required this.stack,
  });

  final List<StackItem>? stack;

  @override
  Widget build(BuildContext context) {
    const borderSide = BorderSide(width: 3.0, color: Colours.primary);

    const radius = Radius.circular(20.0);

    double height = MediaQuery.sizeOf(context).height / 2;
    double width = MediaQuery.sizeOf(context).width;

    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(
        border: Border(bottom: borderSide, right: borderSide, left: borderSide),
        borderRadius: BorderRadius.only(
          bottomRight: radius,
          bottomLeft: radius,
        ),
      ),
      child: (stack?.isEmpty ?? true)
          ? const Center(child: Text("The Stack is empty"))
          : Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(
                stack?.length ?? 0,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: StackItemWidget(
                    value: "${stack?[index].value}",
                    backgroungColour: Colours.primary,
                  ),
                ),
              ).reversed.toList(),
            ),
    );
  }
}

class StackItemWidget extends StatelessWidget {
  const StackItemWidget({
    super.key,
    required this.value,
    required this.backgroungColour,
  });

  final String value;
  final Color backgroungColour;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: backgroungColour,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(value, style: const TextStyle(color: Colors.white)),
    );
  }
}
