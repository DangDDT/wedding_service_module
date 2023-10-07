// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';

class WrappedInkWell extends StatelessWidget {
  const WrappedInkWell({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              splashColor: kTheme.colorScheme.primary.withOpacity(0.1),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
