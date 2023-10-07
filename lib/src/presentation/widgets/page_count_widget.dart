// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';

class PageCountWidget extends StatelessWidget {
  const PageCountWidget({
    Key? key,
    required this.count,
    required this.currentIndex,
  }) : super(key: key);

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '${currentIndex + 1}/$count',
        style: kTextTheme.labelLarge?.copyWith(
          color: Colors.black,
        ),
      ),
    );
  }
}
