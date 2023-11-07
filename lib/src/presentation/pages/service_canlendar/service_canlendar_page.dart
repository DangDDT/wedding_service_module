import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/utils/extensions/datetime_ext.dart';
import 'package:wedding_service_module/core/utils/extensions/objec_ext.dart';
import 'package:wedding_service_module/src/domain/models/day_off_info_model.dart.dart';
import 'package:wedding_service_module/src/presentation/pages/service_canlendar/service_calendar_page_controller.dart';
import 'package:wedding_service_module/src/presentation/view_models/nullable_daterange.dart';
import 'package:wedding_service_module/src/presentation/widgets/error_widget.dart';
import 'package:wedding_service_module/src/presentation/widgets/loading_widget.dart';

class ServiceCalendarPage extends GetView<ServiceCalendarPageController> {
  const ServiceCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch dịch vụ'),
        scrolledUnderElevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.addDayOffInfo,
        child: const Icon(Icons.add),
      ),
      body: const Column(
        children: [
          _CalendarView(),
          kGapH12,
          Expanded(
            child: _DayDetailInfo(),
          ),
        ],
      ),
    );
  }
}

class _CalendarView extends GetView<ServiceCalendarPageController> {
  const _CalendarView();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TableCalendar(
        locale: 'vi_VN',
        calendarFormat: CalendarFormat.month,
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: kTheme.colorScheme.primary,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: kTheme.colorScheme.primary.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(
            color: kTheme.colorScheme.primary,
          ),
        ),
        availableCalendarFormats: const {CalendarFormat.month: 'Tháng'},
        focusedDay: controller.selectedDateValue,
        selectedDayPredicate: (day) =>
            isSameDay(day, controller.selectedDateValue),
        onDaySelected: (selectedDay, focusedDay) {
          controller.selectedDate = selectedDay;
        },
        onPageChanged: (focusedDay) {
          final startOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
          final endOfMonth = DateTime(focusedDay.year, focusedDay.month + 1, 0);
          final range = NullableDateRange(start: startOfMonth, end: endOfMonth);
          controller.onViewingDateRangeChanged(range);
        },
        firstDay: DateTime(1900),
        lastDay: DateTime(2100),
      ),
    );
  }
}

class _DayDetailInfo extends GetView<ServiceCalendarPageController> {
  const _DayDetailInfo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text(
              'Ngày ${controller.selectedDateValue.toReadable()}',
              style: context.textTheme.titleMedium,
            ),
          ),
          kGapH12,
          Expanded(
            child: Obx(
              () {
                if (controller.selectedDayOffInfos.value.isLoading ||
                    controller.selectedDayOffInfos.value.isLoading) {
                  return const LoadingWidget();
                }

                if (controller.selectedDayOffInfos.value.isError) {
                  return Center(
                    child: ErrorOrEmptyWidget(
                      message: 'Có lỗi xảy ra, vui lòng thử lại sau.',
                      callBack: controller.loadDayOffInDay,
                    ),
                  );
                }

                if (controller.selectedDayOffInfos.value.data.isNullOrEmpty) {
                  return Center(
                    child: ErrorOrEmptyWidget(
                      message: 'Không có lịch bận nào trong ngày này.',
                      retryButtonTitle: 'Tải lại',
                      callBack: controller.loadDayOffInDay,
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 40),
                  itemCount: controller.selectedDayOffInfos.value.data!.length,
                  itemBuilder: (context, index) => _buildDayOffInfo(
                    controller.selectedDayOffInfos.value.data![index],
                  ),
                  separatorBuilder: (context, index) => kGapH12,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayOffInfo(DayOffInfoModel dayOffInfo) {
    return Card(
      elevation: 1,
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                  dayOffInfo.weddingService.listImage.firstOrNull?.imageUrl ??
                      '',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          kGapW12,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayOffInfo.weddingService.name,
                  style: kTextTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kGapH4,
                Text(
                  'Lý do bận: ${dayOffInfo.reason} ',
                  style: kTextTheme.bodyMedium,
                ),
                kGapH4,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
