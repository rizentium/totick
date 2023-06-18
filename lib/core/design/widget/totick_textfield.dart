import 'package:flutter/material.dart';

class ToTickTextField extends TextFormField {
  ToTickTextField({
    super.key,
    super.decoration,
    super.maxLines,
    super.controller,
    super.validator,
    super.onChanged,
    super.onSaved,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onTap,
    super.onTapOutside,
  });

  static filled(
    BuildContext context, {
    required String labelText,
    int maxLines = 1,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function(String?)? onSaved,
    void Function()? onEditingComplete,
    void Function(String)? onFieldSubmitted,
    void Function()? onTap,
    void Function(PointerDownEvent)? onTapOutside,
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
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      onTapOutside: onTapOutside,
    );
  }
}
