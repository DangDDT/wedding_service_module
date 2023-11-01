import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/src/presentation/widgets/scroll_physics/no_animate_scroll_physic.dart';

class AutoCenteredItemListView extends StatefulWidget {
  const AutoCenteredItemListView({
    super.key,
    required this.currentIndex,
    required this.itemCount,
    required this.itemBuilder,
    this.height = 48,
  });
  final double height;
  final int currentIndex;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  State<AutoCenteredItemListView> createState() =>
      _AutoCenteredItemListViewState();
}

class _AutoCenteredItemListViewState extends State<AutoCenteredItemListView> {
  late final ItemScrollController _itemScrollController;
  late final ItemPositionsListener _itemPositionsListener;

  final List<ItemPosition> _visibleIndexes = [];
  @override
  void initState() {
    _itemScrollController = ItemScrollController();
    _itemPositionsListener = ItemPositionsListener.create();
    _itemPositionsListener.itemPositions.addListener(() {
      _visibleIndexes.clear();
      _visibleIndexes.addAll(_itemPositionsListener.itemPositions.value
          .where((element) => element.itemTrailingEdge > 0)
          .toList());
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AutoCenteredItemListView oldWidget) {
    if (oldWidget.currentIndex != widget.currentIndex) {
      _scrollToSelected(widget.currentIndex);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _scrollToSelected(int index) async {
    final visibleItem = _visibleIndexes.firstWhere(
      (element) => element.index == index,
    );

    final leadingEdge = visibleItem.itemLeadingEdge;
    final trailingEdge = visibleItem.itemTrailingEdge;
    final offSetWidth = (trailingEdge - leadingEdge) / 2;
    final alignment = .5 - offSetWidth;

    await _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 210),
      curve: Curves.easeInOut,
      alignment: alignment,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ScrollConfiguration(
        behavior: NoGlowingOnOverScrollBehavior(),
        child: ScrollablePositionedList.separated(
          itemScrollController: _itemScrollController,
          itemPositionsListener: _itemPositionsListener,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => kGapW12,
          shrinkWrap: true,
          itemCount: widget.itemCount,
          itemBuilder: widget.itemBuilder,
        ),
      ),
    );
  }
}
