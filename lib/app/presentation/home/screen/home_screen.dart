import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:totick/core/extensions/data_types.dart';

import '../../../../config/environment.dart';
import '../../../../core/extensions/build_context.dart';
import '../../../entity/work_entity.dart';
import '../../work/route/work_route.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../section/task/home_task_section.dart';
import '../section/user/home_user_section.dart';
import '../section/work/home_work_section.dart';
import '../section/work_form/home_work_form_section.dart';
import '../section/work_form/home_work_form_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static Widget create(GetIt locator, {String? title}) {
    return BlocProvider(
      create: (context) => HomeCubit(
        createOrReplaceWorkUseCase: locator(),
        getWorksUseCase: locator(),
        deleteWorkUseCase: locator(),
      ),
      child: HomeScreen(title: title ?? Environment.name),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody() {
    final items = [
      const HomeUserSection(),
      const SizedBox(height: 16),
      _buildTaskSection(),
      _buildWorkSection(),
    ];

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
    );
  }

  Widget _buildTaskSection() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return previous.workState != current.workState;
      },
      builder: (context, state) {
        final isTaskAvailable = state.workState.works
                .firstWhereOrNull((work) => work.tasks?.isNotEmpty == true) !=
            null;
        if (isTaskAvailable) {
          return const Column(
            children: [HomeTaskSection(), SizedBox(height: 32)],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildWorkSection() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return previous.workState != current.workState;
      },
      builder: (context, state) {
        return HomeWorkSection(
          works: state.workState.works,
          onCreatePressed: _onCreatePressed,
          onWorkTilePressed: (id) {
            context.push(WorkRoute.workDetail, extra: {'workId': id});
          },
          onWorkEditPressed: _onEditPressed,
          onWorkDeletePressed: (work) => _onDeleteWorkPressed(
            work,
            onDeletePressed: () async {
              await context.read<HomeCubit>().deleteWork(work.id);
              if (!mounted) return;
              if (state.error.isNotNullOrEmpty) {
                return context.showSnackBar(
                  state.error ?? 'Failed to delete work',
                );
              }
              context.pop();
              context.showSnackBar('Success to delete work');
            },
          ),
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.workState.works.isEmpty) return const SizedBox();
        return FloatingActionButton(
          onPressed: _onCreatePressed,
          tooltip: 'Create',
          child: const Icon(Icons.add),
        );
      },
    );
  }

  _onEditPressed(WorkEntity entity) {
    _showWorkFormDialog(
      title: 'Edit Work',
      work: entity,
      onSavePressed: (work) async {},
    );
  }

  _onCreatePressed() {
    _showWorkFormDialog(
      title: 'Create Work',
      onSavePressed: (work) async {
        await context.read<HomeCubit>().createOrUpdateWork(work);
        if (!mounted) return;
        final state = context.read<HomeCubit>().state.workFormState;
        if (state.phase == HomeWorkCreatePhase.success) {
          context.showSnackBar('Success to create work');
          return context.pop();
        }
        context.showSnackBar(state.error ?? 'Failed to create work');
      },
    );
  }

  Future<void> _onDeleteWorkPressed(
    WorkEntity work, {
    void Function()? onDeletePressed,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete ${work.name}'),
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

  _showWorkFormDialog({
    required String title,
    WorkEntity? work,
    void Function(WorkEntity work)? onSavePressed,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: HomeWorkFormSection(
          title: title,
          work: work,
          onSavePressed: onSavePressed,
        ),
      ),
    );
  }
}
