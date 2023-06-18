import 'package:flutter/material.dart';

import '../../../../../core/design/widget/totick_button.dart';
import '../../widget/task_tile.dart';

class HomeTaskSection extends StatelessWidget {
  const HomeTaskSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'My Tasks',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ToTickButton(
                onTap: () {},
                title: 'Recently',
                isSelected: true,
              ),
              ToTickButton(
                title: 'Today',
                onTap: () {},
              ),
              ToTickButton(
                title: 'Upcoming',
                onTap: () {},
              ),
              ToTickButton(
                title: 'Later',
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 165.0,
          child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Row(
                  children: [
                    const SizedBox(width: 16.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.75,
                      child: const TaskTile(),
                    ),
                  ],
                );
              }
              return SizedBox(
                width: MediaQuery.of(context).size.width / 2.75,
                child: const TaskTile(),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          ),
        ),
      ],
    );
  }
}
