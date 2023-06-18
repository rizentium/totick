import 'package:flutter/material.dart';
import 'package:totick/app/entity/task_entity.dart';

class TaskTile extends StatelessWidget {
  final TaskEntity task;
  final void Function(TaskEntity task)? onCheckPressed;
  const TaskTile({
    super.key,
    required this.task,
    this.onCheckPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () => onCheckPressed?.call(task),
        icon: Icon(task.hasDone ? Icons.circle : Icons.circle_outlined),
      ),
      title: Text(
        task.name ?? 'Unnamed',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: task.hasDone ? FontStyle.italic : null,
          decoration: task.hasDone ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: task.dueDate != null
          ? Text(
              'Due date: 2021-10-10',
              style: TextStyle(
                fontStyle: task.hasDone ? FontStyle.italic : null,
                decoration: task.hasDone ? TextDecoration.lineThrough : null,
              ),
            )
          : null,
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          task.reminder != null
              ? Icons.notifications_active
              : Icons.notifications_off_outlined,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
        ),
      ),
      onTap: () {},
    );
  }
}
