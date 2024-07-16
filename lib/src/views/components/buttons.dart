import 'package:dsa_visualiser/src/utils/colours.dart';
import 'package:dsa_visualiser/src/utils/dimensions.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor, foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: backgroundColor ?? Colours.primary,
        foregroundColor: foregroundColor ?? Colours.white,
      ),
      child: Text(label),
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor, foregroundColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        side: BorderSide(
          color: backgroundColor ?? foregroundColor ?? Colours.black,
          width: 1.5,
        ),
        foregroundColor: foregroundColor,
      ),
      child: Text(label),
    );
  }
}

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.isLarge = false,
    this.colour,
  });
  final IconData icon;
  final VoidCallback? onTap;
  final bool isLarge;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(isLarge ? 50.0 : 30.0),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          shape: isLarge ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isLarge ? null : BorderRadius.circular(30.0),
          color: colour ?? Colours.primary,
        ),
        child: Icon(
          icon,
          size: isLarge ? dimension * 1.5 : null,
          color: Colours.white,
        ),
      ),
    );
  }
}
