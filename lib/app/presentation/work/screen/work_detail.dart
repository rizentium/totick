import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:totick/app/presentation/work/cubit/work_detail_cubit.dart';
import 'package:totick/app/presentation/work/cubit/work_detail_state.dart';
import 'package:totick/app/presentation/work/widget/task_tile.dart';
import 'package:totick/core/extensions/build_context.dart';
import 'package:totick/core/extensions/data_types.dart';

import '../../../entity/task_entity.dart';
import '../../../entity/work_entity.dart';
import '../section/create_task/create_task_section.dart';
import '../section/work_form/work_form_section.dart';
import '../widget/work_detail_shimmer.dart';

class WorkDetailScreen extends StatefulWidget {
  final String? workId;

  const WorkDetailScreen({super.key, this.workId});

  @override
  State<WorkDetailScreen> createState() => _WorkDetailScreenState();

  static Widget create(GetIt locator, {String? workId}) {
    return BlocProvider(
      create: (_) => WorkDetailCubit(
        id: workId,
        getWorksUseCase: locator(),
        createOrReplaceWorkUseCase: locator(),
        deleteWorkUseCase: locator(),
      )..initialize(),
      child: WorkDetailScreen(workId: workId),
    );
  }
}

class _WorkDetailScreenState extends State<WorkDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkDetailCubit, WorkDetailState>(
      builder: (context, state) {
        if (state.isLoading) return const WorkDetailShimmer();

        return Scaffold(
          appBar: AppBar(
            title: Text(state.work?.name ?? ''),
            actions: [
              IconButton(
                onPressed: () {
                  _showWorkFormDialog(
                    work: state.work,
                    title: 'Edit Work',
                    successDefaultMessage: 'Success to update work',
                    failedDefaultMessage: 'Failed to update work',
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => _onDeleteWorkPressed(
                  state.work,
                  onDeletePressed: () async {
                    await context.read<WorkDetailCubit>().deleteWork();
                    if (!mounted) return;
                    if (state.error.isNotNullOrEmpty) {
                      return context.showSnackBar(
                        state.error ?? 'Failed to delete work',
                      );
                    }
                    context.showSnackBar('Success to delete work');
                    context
                      ..pop()
                      ..pop();
                  },
                ),
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
              onCreatePressed: (title) async {
                await context.read<WorkDetailCubit>().createTask(title);
                if (!mounted) return;
                context.pop();
              },
            ),
            child: const Icon(Icons.add),
          ),
        );
      },
      listener: (context, state) {
        final error = state.error;
        if (error != null) {
          context.showSnackBar(error);
          context.read<WorkDetailCubit>().resetError();
        }
      },
    );
  }

  Widget _buildBody(
    String? description,
    List<TaskEntity> tasks,
  ) {
    return ListView(
      children: [
        if (description.isNotNullOrEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(description ?? ''),
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
        ...tasks.map(
          (task) {
            return TaskTile(
              task: task,
              onCheckPressed: (task) {
                context.read<WorkDetailCubit>().updateTask(task);
              },
            );
          },
        ).toList(),
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

  Future<void> _onDeleteWorkPressed(
    WorkEntity? work, {
    void Function()? onDeletePressed,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete ${work?.name}'),
          content: const Text(
            'Are you sure to delete this work?',
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: onDeletePressed,
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showWorkFormDialog({
    required String title,
    WorkEntity? work,
    required String successDefaultMessage,
    required String failedDefaultMessage,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: WorkFormSection(
          title: title,
          work: work,
          onSavePressed: (work) => _onSaveWorkPressed(
            work,
            successDefaultMessage: successDefaultMessage,
            failedDefaultMessage: failedDefaultMessage,
          ),
        ),
      ),
    );
  }

  Future<void> _onSaveWorkPressed(
    WorkEntity work, {
    required String successDefaultMessage,
    required String failedDefaultMessage,
  }) async {
    await context.read<WorkDetailCubit>().updateWork(work);
    if (!mounted) return;
    final state = context.read<WorkDetailCubit>().state;
    if (state.error.isNullOrEmpty) {
      context.showSnackBar(successDefaultMessage);
      context.pop();
    } else {
      context.showSnackBar(state.error ?? failedDefaultMessage);
    }
  }
}
