import 'package:flutter/material.dart';

class ToTickTextField extends TextField {
  const ToTickTextField({super.key, super.decoration, super.maxLines});

  static filled(
    BuildContext context, {
    required String labelText,
    int maxLines = 1,
  }) {
    final decoration = InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      isDense: true,
      labelText: labelText,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 16.0,
      ),
      filled: true,
      fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
    );
    return ToTickTextField(
      decoration: decoration,
      maxLines: maxLines,
    );
  }
}
