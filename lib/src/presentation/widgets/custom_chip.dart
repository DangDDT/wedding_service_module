import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.labelStyle,
    this.icon,
  });

  final Widget label;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        this.backgroundColor ?? context.theme.colorScheme.primaryContainer;
    final foregroundColor =
        this.foregroundColor ?? context.theme.colorScheme.primary;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(
                  color: foregroundColor,
                  size: 16,
                ),
                child: icon!,
              ),
              kGapW4,
            ],
            DefaultTextStyle(
              style: labelStyle ??
                  context.textTheme.bodySmall!.copyWith(
                    color: foregroundColor,
                  ),
              child: label,
            ),
          ],
        ),
      ),
    );
  }
}
