import 'package:flutter/material.dart';

class ToTickButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool isSelected;

  const ToTickButton({
    super.key,
    required this.title,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
