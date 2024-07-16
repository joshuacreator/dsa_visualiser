import 'package:dsa_visualiser/src/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.controller,
    this.onChanged,
    this.readOnly = false,
    this.autofocus = false,
    this.validator,
    this.onTap,
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;
  final bool readOnly, autofocus;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      readOnly: readOnly,
      autofocus: autofocus,
      validator: validator,
      decoration: InputDecoration(
        hintText: "Enter a value",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colours.primary, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colours.primary, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colours.primary, width: 1.2),
        ),
        filled: true,
        fillColor: Colours.primaryLight.withOpacity(0.1),
        contentPadding: const EdgeInsets.all(12.0),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: onChanged,
      onTap: onTap,
      // onTapOutside: (event) {
      //   FocusManager.instance.primaryFocus!.unfocus();
      // },
    );
  }
}
