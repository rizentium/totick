import 'package:flutter/material.dart';

class HomeWorkSection extends StatelessWidget {
  const HomeWorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Works',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8.0),
        _buildWorkItemList(),
      ],
    );
  }

  Widget _buildWorkItemList() {
    return Column(
      children: [1, 2, 3, 4, 5, 6, 7]
          .map((e) => ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                leading: const CircleAvatar(),
                title: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                  'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: const Text('20 Feb, 2021'),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
                onTap: () {},
              ))
          .toList(),
    );
  }
}
