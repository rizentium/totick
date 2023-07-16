import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:totick/core/extensions/build_context.dart';

import '../../../../../core/design/widget/totick_textfield.dart';
import '../../../../entity/work_entity.dart';

class WorkFormSection extends StatefulWidget {
  final String title;
  final WorkEntity? work;
  final void Function(WorkEntity)? onSavePressed;

  const WorkFormSection({
    super.key,
    required this.title,
    this.work,
    this.onSavePressed,
  });

  @override
  State<WorkFormSection> createState() => _WorkFormSectionState();
}

class _WorkFormSectionState extends State<WorkFormSection> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final workName = widget.work?.name;
    final workDescription = widget.work?.description;

    if (workName != null) _titleController.text = workName;
    if (workDescription != null) _descriptionController.text = workDescription;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
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
    if (_formKey.currentState?.validate() == true) {
      final currentWork = widget.work ?? const WorkEntity();
      widget.onSavePressed?.call(
        currentWork.copyWith(
          name: _titleController.text,
          description: _descriptionController.text,
          createdAt: currentWork.createdAt ?? DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    } else {
      context.showSnackBar('Ops, please check your input');
    }
  }
}
