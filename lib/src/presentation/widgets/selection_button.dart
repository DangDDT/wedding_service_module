import 'package:flutter/material.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';

class SelectionButton extends StatelessWidget {
  final IconData? icon;
  final String? content;
  final String? label;
  final VoidCallback onPressed;
  final bool isNull;
  final String? errorText;
  final VoidCallback? onClear;
  const SelectionButton({
    Key? key,
    this.label,
    this.icon,
    required this.content,
    required this.onPressed,
    this.isNull = true,
    this.errorText,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: kTheme.textTheme.titleSmall?.copyWith(
              color: kTheme.hintColor,
            ),
          ),
        ],
        kGapH8,
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: kTheme.colorScheme.primary.withOpacity(.1),
              borderRadius: kDefaultRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        color: kTheme.hintColor,
                        size: 18,
                      ),
                      kGapW8,
                    ],
                    Expanded(
                      child: Text(
                        content ?? 'Bấm để chọn',
                        style: kTheme.textTheme.bodyLarge?.copyWith(
                          color: isNull
                              ? kTheme.disabledColor.withOpacity(0.45)
                              : kTheme.colorScheme.onBackground,
                          fontWeight:
                              isNull ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ),
                    if (!isNull && onClear != null) ...[
                      kGapW12,
                      GestureDetector(
                        onTap: onClear,
                        child: Icon(
                          Icons.close,
                          color: kTheme.colorScheme.primary,
                          size: 18,
                        ),
                      ),
                    ],
                    kGapW12,
                    Icon(
                      Icons.unfold_more_rounded,
                      color: kTheme.colorScheme.primary.withOpacity(.4),
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        kGapH8,
        if (errorText != null)
          Text(
            errorText!,
            style: kTheme.textTheme.bodyMedium?.copyWith(
              color: kTheme.colorScheme.error,
            ),
          ),
      ],
    );
  }
}
