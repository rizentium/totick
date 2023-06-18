import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:totick/core/extensions/build_context.dart';

import '../../../../../core/design/widget/totick_textfield.dart';

class HomeWorkCreateSection extends StatefulWidget {
  final void Function(String title, String description)? onCreatePressed;

  const HomeWorkCreateSection({super.key, this.onCreatePressed});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<HomeWorkCreateSection> createState() => _HomeWorkCreateSectionState();
}

class _HomeWorkCreateSectionState extends State<HomeWorkCreateSection> {
  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        key: HomeWorkCreateSection._formKey,
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
              controller: _titleController,
              validator: (value) {
                if (value?.isEmpty == true) return 'Please enter work name';
                return null;
              },
            ),
            const SizedBox(height: 16),
            ToTickTextField.filled(
              context,
              labelText: 'Description (Optional)',
              maxLines: 3,
              controller: _descriptionController,
            ),
            const SizedBox(height: 16),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: _onCreatePressed,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _onCreatePressed() {
    if (HomeWorkCreateSection._formKey.currentState?.validate() == true) {
      widget.onCreatePressed?.call(
        _titleController.text,
        _descriptionController.text,
      );
    } else {
      context.showSnackBar('Ops, please check your input');
    }
  }
}
