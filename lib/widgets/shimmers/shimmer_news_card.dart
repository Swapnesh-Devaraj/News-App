import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNewsCard extends StatelessWidget {
  const ShimmerNewsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 100,
                    height: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
