import 'package:flutter/material.dart';

import '../../../../entity/work_entity.dart';

class HomeWorkSection extends StatelessWidget {
  final void Function()? onCreatePressed;
  final void Function(String? id)? onWorkTilePressed;
  final void Function(WorkEntity work)? onWorkDeletePressed;
  final void Function(WorkEntity work)? onWorkEditPressed;

  final List<WorkEntity> works;

  const HomeWorkSection({
    super.key,
    this.onCreatePressed,
    this.onWorkTilePressed,
    this.onWorkDeletePressed,
    this.onWorkEditPressed,
    this.works = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (works.isEmpty) return _buildNoWork(context);
    return _buildWorkItemList(context);
  }

  Widget _buildNoWork(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_off,
            size: 64.0,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
          ),
          const SizedBox(height: 12),
          const Text('Ops, you don\'t have any work yet'),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: onCreatePressed,
            child: const Text('Create Your First Work'),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkItemList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Works',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 8.0),
        Column(
          children: works
              .map((e) => ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    leading: const CircleAvatar(),
                    title: Text(
                      e.name ?? 'Unamed work',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: const Text('20 Feb, 2021'),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 'edit',
                            child: const Text('Edit'),
                            onTap: () => Future.delayed(
                              const Duration(seconds: 0),
                              () => onWorkEditPressed?.call(e),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: const Text('Delete'),
                            onTap: () => Future.delayed(
                              const Duration(seconds: 0),
                              () => onWorkDeletePressed?.call(e),
                            ),
                          ),
                        ];
                      },
                    ),
                    onTap: () => onWorkTilePressed?.call(e.id),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
