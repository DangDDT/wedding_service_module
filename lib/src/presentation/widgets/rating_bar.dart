import 'package:flutter/material.dart';

class StarRatingBar extends StatelessWidget {
  const StarRatingBar({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.color = Colors.amber,
    this.iconSize = 16,
  });
  final int starCount;
  final double rating;
  final Color color;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(
        color: color,
        size: iconSize,
      ),
      child: Row(
        children: List.generate(
          starCount,
          (index) => buildStar(context, index),
        ),
      ),
    );
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(Icons.star_border);
    } else if (index > rating - 1 && index < rating) {
      icon = const Icon(Icons.star_half);
    } else {
      icon = const Icon(Icons.star);
    }
    return icon;
  }
}
