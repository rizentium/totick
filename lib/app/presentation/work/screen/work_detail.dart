import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:totick/app/presentation/work/cubit/work_detail_cubit.dart';
import 'package:totick/app/presentation/work/cubit/work_detail_state.dart';
import 'package:totick/app/presentation/work/widget/task_tile.dart';
import 'package:totick/core/extensions/build_context.dart';

import '../../../entity/task_entity.dart';
import '../section/create_task/create_task_section.dart';

class WorkDetailScreen extends StatefulWidget {
  final int? workId;

  const WorkDetailScreen({super.key, this.workId});

  @override
  State<WorkDetailScreen> createState() => _WorkDetailScreenState();

  static Widget create(GetIt locator, {int? workId}) {
    return BlocProvider(
      create: (_) => WorkDetailCubit(
        id: workId,
        getWorksUseCase: locator(),
        updateWorkUseCase: locator(),
      )..initialize(),
      child: WorkDetailScreen(workId: workId),
    );
  }
}

class _WorkDetailScreenState extends State<WorkDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkDetailCubit, WorkDetailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.work?.name ?? ''),
            actions: [
              IconButton(
                onPressed: () {
                  context.showSnackBar(
                    'Ops, edit feature is not implemented yet',
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  context.showSnackBar(
                    'Ops, delete feature is not implemented yet',
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: _buildBody(
            state.work?.description,
            state.work?.tasks ?? [],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showCreateWorkDialog(
              onCreatePressed: (title) {
                context.read<WorkDetailCubit>().createTask(title);
                context.pop();
              },
            ),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildBody(
    String? description,
    List<TaskEntity> tasks,
  ) {
    return ListView(
      children: [
        if (description != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(description),
          ),
        _buildTasks(tasks),
      ],
    );
  }

  Widget _buildTasks(List<TaskEntity> tasks) {
    if (tasks.isEmpty) {
      return _buildNoTask();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Tasks',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ...tasks
            .map(
              (e) => TaskTile(
                task: e,
                onCheckPressed: (task) {
                  context.read<WorkDetailCubit>().updateTask(task);
                },
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _buildNoTask() {
    return ListTile(
      title: Text(
        'No upcoming tasks',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildTask({bool isDone = false, bool isAlarm = false}) {
    return ListTile(
      leading: IconButton(
        onPressed: () {},
        icon: Icon(isDone ? Icons.circle : Icons.circle_outlined),
      ),
      title: Text(
        'Task 1',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: isDone ? FontStyle.italic : null,
          decoration: isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(
        'Due date: 2021-10-10',
        style: TextStyle(
          fontStyle: isDone ? FontStyle.italic : null,
          decoration: isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          isAlarm
              ? Icons.notifications_active
              : Icons.notifications_off_outlined,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
        ),
      ),
      onTap: () {},
    );
  }

  _showCreateWorkDialog({void Function(String title)? onCreatePressed}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: CreateTaskSection(onCreatePressed: onCreatePressed),
      ),
    );
  }
}
