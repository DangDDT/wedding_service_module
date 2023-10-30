import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';

class RadioFilterButton extends StatelessWidget {
  const RadioFilterButton({
    Key? key,
    this.onTap,
    this.selected = false,
    required this.title,
    this.icon,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 8,
    ),
  }) : super(key: key);

  final VoidCallback? onTap;
  final bool selected;
  final String title;
  final IconData? icon;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final selectedForegroundColor = context.theme.colorScheme.onPrimary;
    const unSelectedForegroundColor = Colors.black87;

    final selectedBackgroundColor = context.theme.colorScheme.primary;
    final unSelectedBackgroundColor = Colors.grey.shade200;
    final splashColor = selected ? kTheme.splashColor : Colors.transparent;

    return InkWell(
      onTap: onTap,
      key: ValueKey(selected),
      splashColor: splashColor,
      borderRadius: BorderRadius.circular(80),
      child: Material(
        color: selected ? selectedBackgroundColor : unSelectedBackgroundColor,
        borderRadius: BorderRadius.circular(80),
        clipBehavior: Clip.hardEdge,
        textStyle: kTheme.textTheme.bodyLarge!.copyWith(
          color: selected
              ? (selectedForegroundColor)
              : (unSelectedForegroundColor),
          fontWeight: FontWeight.bold,
        ),
        type: MaterialType.card,
        child: IconTheme(
          data: IconThemeData(
            color: selected
                ? (selectedForegroundColor)
                : (unSelectedForegroundColor),
            size: 18,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 160),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: Padding(
              padding: padding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[Icon(icon), kGapW4],
                  Text(title),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
