import 'package:flutter/material.dart';

extension BuildContextExtended on BuildContext {
  showSnackBar(String title) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(title)),
    );
  }
}
