import 'package:flutter/material.dart';

class ActionBottomSheet<T> extends StatelessWidget {
  const ActionBottomSheet({
    super.key,
    this.title,
    this.titleTextStyle,
    this.titleAlignment = Alignment.centerLeft,
    this.titlePadding,
    required this.items,
    this.draggerHeight,
    this.draggerWidth,
    this.draggerColor,
    this.showDragger = true,
    this.subTitle,
    this.subTitleTextStyle,
    this.subTitlePadding,
  });
  final String? title;
  final TextStyle? titleTextStyle;
  final Alignment titleAlignment;
  final EdgeInsets? titlePadding;
  final String? subTitle;
  final TextStyle? subTitleTextStyle;
  final EdgeInsets? subTitlePadding;
  final List<ActionBottomSheetItem<T>> items;
  final bool showDragger;
  final double? draggerHeight;
  final double? draggerWidth;
  final Color? draggerColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showDragger)
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: draggerHeight ?? 5,
                    width: draggerWidth ?? 45,
                    decoration: BoxDecoration(
                      color: draggerColor ?? Colors.grey[400],
                      borderRadius: BorderRadius.circular(
                        draggerHeight != null ? draggerHeight! / 2 : 12,
                      ),
                    ),
                  ),
                ),
              if (title != null || subTitle != null)
                Align(
                  alignment: titleAlignment,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title != null)
                        Padding(
                          padding: titlePadding ??
                              EdgeInsets.only(
                                left: 10,
                                bottom: subTitle != null ? 5 : 20,
                              ),
                          child: Text(
                            title!,
                            style: titleTextStyle ??
                                Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      if (subTitle != null)
                        Padding(
                          padding: subTitlePadding ??
                              const EdgeInsets.only(
                                left: 10,
                                bottom: 10,
                              ),
                          child: Text(
                            subTitle!,
                            style: subTitleTextStyle ??
                                Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                    ],
                  ),
                ),
              ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  height: 0,
                  indent: 18,
                  thickness: .5,
                  color: Theme.of(context).disabledColor,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) => items[index],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionBottomSheetItem<T> extends StatelessWidget {
  const ActionBottomSheetItem({
    super.key,
    this.value,
    required this.title,
    this.icon,
    this.trailing,
    this.titleTextStyle,
    this.subTitle,
    this.subTittleTextStyle,
    this.color,
    this.enabled = true,
  });

  ///Action's label
  ///
  ///If [value] is not specified, when action tap, the bottom sheet will
  ///be pop and return this title as value.
  final String title;

  final String? subTitle;

  ///Define tittle text style
  final TextStyle? titleTextStyle;

  ///Define subTittle text style
  final TextStyle? subTittleTextStyle;

  ///A widget stand before item label.
  ///It's should be a [Icon]
  final Widget? icon;

  final Widget? trailing;

  ///Return value on tap action item.
  ///
  ///If [value] is null return [label]
  final T? value;

  ///Define then action item's color.
  final Color? color;

  ///Weather action item is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Opacity(
      opacity: enabled ? 1 : .3,
      child: InkWell(
        onTap: enabled
            ? () {
                Navigator.of(context).pop(value ?? title);
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: DefaultTextStyle(
            style: theme.textTheme.titleSmall!.copyWith(color: color),
            child: IconTheme(
              data: IconThemeData(size: 18, color: color),
              child: Row(
                children: [
                  icon ?? const SizedBox.shrink(),
                  (icon != null)
                      ? const SizedBox(
                          width: 20,
                        )
                      : const SizedBox.shrink(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: titleTextStyle,
                      ),
                      if (subTitle != null)
                        Text(
                          subTitle!,
                          style: subTittleTextStyle ??
                              theme.textTheme.bodySmall
                                  ?.copyWith(color: theme.hintColor),
                        ),
                    ],
                  ),
                  const Spacer(),
                  trailing ?? const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
