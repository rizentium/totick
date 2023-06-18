import 'package:flutter/material.dart';

import '../../../../config/environment.dart';
import '../section/task/home_task_section.dart';
import '../section/user/home_user_section.dart';
import '../section/work/home_work_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static Widget create({String? title}) {
    return HomeScreen(title: title ?? Environment.name);
  }
}

class _HomeScreenState extends State<HomeScreen> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    const items = [
      HomeUserSection(),
      SizedBox(height: 16),
      HomeTaskSection(),
      SizedBox(height: 32),
      HomeWorkSection(),
    ];

    return const SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
    );
  }
}
