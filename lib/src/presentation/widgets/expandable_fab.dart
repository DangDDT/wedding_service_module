// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/utils/extensions/color_ext.dart';

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    required this.actions,
    this.directAction,
    this.scrollController,
  });

  ///Direct actions, this action will be shown even when the fab is closed
  final ActionButton? directAction;

  ///Actions for the fab, this action will be shown when the fab is opened
  ///
  ///If the direct actions is not null, the direct actions will be added to the start of the actions
  final List<ActionButton> actions;

  ///This is the scroll controller of the parent widget
  ///
  ///This is used to detect is the parent widget is scrolling to auto resize the widget
  final ScrollController? scrollController;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  bool _isOpened = false;
  // late final AnimationController _expandAnimationController;
  late final AnimationController _rotationAnimationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    _rotationAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(
      parent: _rotationAnimationController,
      curve: Curves.easeInOut,
    );
    if (widget.scrollController != null) {
      widget.scrollController!.addListener(_onScroll);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ExpandableFab oldWidget) {
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController?.removeListener(_onScroll);
      widget.scrollController?.addListener(_onScroll);
    }
    super.didUpdateWidget(oldWidget);
  }

  void toggle() {
    setState(() {
      _isOpened = !_isOpened;
      if (_isOpened) {
        _rotationAnimationController.forward();
      } else {
        _rotationAnimationController.reverse();
      }
    });
  }

  void _onScroll() {
    if (widget.scrollController == null) return;
    if (widget.scrollController!.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isOpened) {
        toggle();
      }
    }

    if (widget.scrollController!.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isOpened) {
        toggle();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final backDropColor = Get.theme.colorScheme.background;
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            right: -20,
            bottom: -20,
            child: IgnorePointer(
              ignoring: !_isOpened,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: 0.0,
                  end: _isOpened ? .7 : 0.0,
                ),
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                builder: (_, value, child) {
                  if (value < 0.001) {
                    return child!;
                  }
                  return ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
                      child: child,
                    ),
                  );
                },
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Positioned.fill(
            right: -20,
            bottom: -20,
            child: GestureDetector(
              onTap: toggle,
              child: IgnorePointer(
                ignoring: !_isOpened,
                child: AnimatedOpacity(
                  opacity: _isOpened ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: ColoredBox(
                    color: backDropColor.withOpacity(.95),
                  ),
                ),
              ),
            ),
          ),
          ..._buildActionButton(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            constraints: const BoxConstraints(
              minHeight: 48,
            ),
            decoration: BoxDecoration(
              color: _isOpened
                  ? Colors.black
                  : Get.theme.colorScheme.surfaceVariant,
              // foregroundColor:
              //     _isOpened ? Colors.white : Get.theme.colorScheme.onPrimary,
              // onPressed: toggle,
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: AnimatedSize(
              alignment: Alignment.centerRight,
              duration: const Duration(milliseconds: 210),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.directAction != null && !_isOpened) ...[
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: widget.directAction!.onPressed,
                      child: Row(
                        children: [
                          IconTheme(
                            data: const IconThemeData(
                              size: 24,
                            ),
                            child: widget.directAction!.icon,
                          ),
                          kGapW8,
                          DefaultTextStyle(
                            style: Get.textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            child: widget.directAction!.label,
                          ),
                          kGapW16,
                        ],
                      ),
                    ),
                    const ColoredBox(
                      color: Colors.black,
                      child: SizedBox(
                        height: 24,
                        width: 1,
                      ),
                    ),
                    kGapW12,
                  ],
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: toggle,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (_, child) {
                          return Transform.rotate(
                            angle: _animation.value * 1 * 3.14,
                            child: child,
                          );
                        },
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          size: 24,
                          color: _isOpened
                              ? Get.theme.colorScheme.onPrimary
                              : Get.theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Iterable<Widget> _buildActionButton() {
    final actions = [
      if (widget.directAction != null) widget.directAction!,
      ...widget.actions,
    ];
    return actions.asMap().map((index, action) {
      return MapEntry(
        index,
        _ExpandingActionBuilder(
          maxDistance: 60.0 * (index + 1),
          progress: _animation,
          child: _ExpandableButton(actionButton: action),
        ),
      );
    }).values;
  }
}

class _ExpandableButton extends StatelessWidget {
  const _ExpandableButton({
    Key? key,
    required this.actionButton,
  }) : super(key: key);

  final ActionButton actionButton;

  @override
  Widget build(BuildContext context) {
    final expandableState =
        context.findAncestorStateOfType<_ExpandableFabState>();
    final backgroundColor =
        actionButton.backgroundColor ?? Get.theme.colorScheme.primary;
    final foregroundColor = actionButton.foregroundColor ??
        actionButton.backgroundColor?.textColor ??
        Get.theme.colorScheme.onPrimary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DefaultTextStyle(
          style: Get.textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
          child: actionButton.label,
        ),
        kGapW24,
        Material(
          color: backgroundColor,
          shape: const CircleBorder(),
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              expandableState?.toggle();
              actionButton.onPressed();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: IconTheme(
                data: IconThemeData(color: foregroundColor),
                child: actionButton.icon,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

@immutable
class _ExpandingActionBuilder extends StatelessWidget {
  const _ExpandingActionBuilder({
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (ctx, child) {
        final dy = 8 * (1 - progress.value);
        return Positioned(
          right: 4,
          bottom: maxDistance - dy + 8,
          child: child!,
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

class ActionButton {
  const ActionButton({
    required this.onPressed,
    required this.label,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  final VoidCallback onPressed;
  final Widget label;
  final Widget icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  ActionButton copyWith({
    VoidCallback? onPressed,
    Widget? label,
    Widget? icon,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return ActionButton(
      onPressed: onPressed ?? this.onPressed,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }

  @override
  bool operator ==(covariant ActionButton other) {
    if (identical(this, other)) return true;

    return other.onPressed == onPressed &&
        other.label == label &&
        other.icon == icon &&
        other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor;
  }

  @override
  int get hashCode {
    return onPressed.hashCode ^
        label.hashCode ^
        icon.hashCode ^
        backgroundColor.hashCode ^
        foregroundColor.hashCode;
  }
}
