import 'package:flutter/material.dart';
import 'package:totick/core/design/widget/totick_shimmer.dart';

class WorkDetailShimmer extends StatelessWidget {
  const WorkDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ToTickShimmer(
          height: 24,
          width: 128,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToTickShimmer(
              height: 14,
              width: double.infinity,
              borderRadius: BorderRadius.circular(8.0),
            ),
            const SizedBox(height: 8.0),
            ToTickShimmer(
              height: 14,
              width: double.infinity,
              borderRadius: BorderRadius.circular(8.0),
            ),
            const SizedBox(height: 8.0),
            ToTickShimmer(
              height: 14,
              width: 256,
              borderRadius: BorderRadius.circular(8.0),
            ),
            const SizedBox(height: 18.0),
            ToTickShimmer(
              height: 24,
              width: 128,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 18.0),
            ToTickShimmer(
              height: 42,
              width: double.infinity,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 12.0),
            ToTickShimmer(
              height: 42,
              width: double.infinity,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 12.0),
            ToTickShimmer(
              height: 42,
              width: double.infinity,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 12.0),
            ToTickShimmer(
              height: 42,
              width: double.infinity,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 12.0),
            ToTickShimmer(
              height: 42,
              width: double.infinity,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
      ),
    );
  }
}
