import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/design/widget/totick_textfield.dart';

class HomeWorkCreateSection extends StatelessWidget {
  const HomeWorkCreateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create New Work',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ToTickTextField.filled(
            context,
            labelText: 'Work Name',
          ),
          const SizedBox(height: 16),
          ToTickTextField.filled(
            context,
            labelText: 'Description (Optional)',
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          ButtonBar(
            children: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
