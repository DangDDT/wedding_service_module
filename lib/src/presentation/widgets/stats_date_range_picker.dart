import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/utils/extensions/build_context_ext.dart';
import 'package:wedding_service_module/core/utils/extensions/datetime_ext.dart';
import 'package:wedding_service_module/src/presentation/view_models/nullable_daterange.dart';
import 'package:wedding_service_module/src/presentation/widgets/auto_centerd_item_listview.dart';
import 'package:wedding_service_module/src/presentation/widgets/radio_filter_button.dart';
import 'package:wedding_service_module/src/presentation/widgets/selection_button.dart';

import '../../../core/constants/ui_constant.dart';
import '../../domain/enums/private/stats_time_range_type_enum.dart';

class StatsDateRangePicker extends StatefulWidget {
  const StatsDateRangePicker({
    super.key,
    required this.value,
    required this.onDateRangeChanged,
  });

  final NullableDateRange? value;
  final void Function(NullableDateRange) onDateRangeChanged;

  @override
  State<StatsDateRangePicker> createState() => _StatsDateRangePickerState();
}

class _StatsDateRangePickerState extends State<StatsDateRangePicker> {
  StatsTimeRangeType _selectedTimeRange = StatsTimeRangeType.values.first;

  void _pickDate(bool pickStartTime) {
    final now = DateTime.now();
    final initialDate =
        pickStartTime ? widget.value?.start ?? now : widget.value?.end ?? now;
    final firstDate =
        pickStartTime ? DateTime(2015) : widget.value?.start ?? DateTime(2015);
    final lastDate = pickStartTime ? widget.value?.end ?? now : now;

    showDatePicker(
      locale: const Locale('vi', 'VN'),
      context: Get.context!,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((value) {
      if (value == null) return;
      late final NullableDateRange timeRange;
      if (pickStartTime) {
        timeRange = NullableDateRange(
          start: value,
          end: widget.value?.end,
        );
      } else {
        timeRange = NullableDateRange(
          start: widget.value?.start,
          end: value,
        );
      }

      widget.onDateRangeChanged.call(timeRange);
    });
  }

  void _onChangeStatsTimeRangeType(int index) {
    final type = StatsTimeRangeType.values[index];
    if (type == _selectedTimeRange) return;

    setState(() {
      _selectedTimeRange = type;
    });

    if (type == StatsTimeRangeType.custom) return;

    final value = type.dateTimeRange;
    if (value == null) return;
    widget.onDateRangeChanged.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoCenteredItemListView(
            currentIndex: StatsTimeRangeType.values.indexOf(_selectedTimeRange),
            itemCount: StatsTimeRangeType.values.length,
            itemBuilder: (ctx, index) => UnconstrainedBox(
              child: RadioFilterButton(
                title: Text(StatsTimeRangeType.values[index].title),
                selected:
                    StatsTimeRangeType.values[index] == _selectedTimeRange,
                onTap: () => _onChangeStatsTimeRangeType(index),
              ),
            ),
          ),
          // DefaultTabController(
          //   length: StatsTimeRangeType.values.length,
          //   child: TabBar(
          //     isScrollable: true,
          //     onTap: (index) => _onChangeStatsTimeRangeType(
          //       StatsTimeRangeType.values[index],
          //     ),
          //     labelColor: context.theme.colorScheme.primary,
          //     unselectedLabelColor: context.theme.hintColor.withOpacity(.4),
          //     indicator: BoxDecoration(
          //       borderRadius: BorderRadius.circular(12.0),
          //       color: context.theme.colorScheme.primaryContainer,
          //     ),
          //     splashFactory: NoSplash.splashFactory,
          //     indicatorSize: TabBarIndicatorSize.tab,
          //     dividerColor: Colors.transparent,
          //     splashBorderRadius: BorderRadius.circular(12.0),
          //     labelPadding: const EdgeInsets.symmetric(horizontal: 24.0),
          //     indicatorPadding: const EdgeInsets.symmetric(vertical: 6.0),
          //     tabs: StatsTimeRangeType.values
          //         .map((e) => Tab(text: e.title))
          //         .toList(),
          //   ),
          // ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 210),
            reverseDuration: const Duration(milliseconds: 210),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -.05),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.decelerate,
                  ),
                ),
                child: child,
              ),
            ),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: (_selectedTimeRange != StatsTimeRangeType.custom)
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: context.isLightMode
                              ? Colors.white
                              : Colors.black87,
                          borderRadius: kDefaultRadius,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tùy Chọn',
                              style: Get.textTheme.bodyMedium?.copyWith(
                                color: context.theme.hintColor,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SelectionButton(
                                    icon: Icons.calendar_today_outlined,
                                    content: widget.value?.start?.toReadable(),
                                    isNull: widget.value?.start == null,
                                    onPressed: () => _pickDate(true),
                                  ),
                                ),
                                kGapW8,
                                Expanded(
                                  child: SelectionButton(
                                    icon: Icons.calendar_today_outlined,
                                    content: widget.value?.end?.toReadable(),
                                    isNull: widget.value?.end == null,
                                    onPressed: () => _pickDate(false),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
