import 'package:flutter/material.dart';

class HomeUserSection extends StatelessWidget {
  const HomeUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(
        'Hi, Guest!',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        'Welcome back',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
