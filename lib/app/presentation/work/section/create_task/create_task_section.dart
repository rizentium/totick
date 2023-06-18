import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:totick/core/extensions/build_context.dart';

import '../../../../../core/design/widget/totick_textfield.dart';

class CreateTaskSection extends StatefulWidget {
  final void Function(String title)? onCreatePressed;

  const CreateTaskSection({super.key, this.onCreatePressed});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<CreateTaskSection> createState() => _CreateTaskSectionState();
}

class _CreateTaskSectionState extends State<CreateTaskSection> {
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        key: CreateTaskSection._formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Task',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ToTickTextField.filled(
              context,
              labelText: 'Task name',
              controller: _titleController,
              validator: (value) {
                if (value?.isEmpty == true) return 'Please enter task name';
                return null;
              },
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

  void _onCreatePressed() {
    if (CreateTaskSection._formKey.currentState?.validate() == true) {
      widget.onCreatePressed?.call(_titleController.text);
    } else {
      context.showSnackBar('Ops, please check your input');
    }
  }
}
