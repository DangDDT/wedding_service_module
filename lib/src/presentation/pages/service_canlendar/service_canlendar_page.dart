import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/routes/arguments/service_calendar_args.dart';
import 'package:wedding_service_module/core/utils/extensions/datetime_ext.dart';
import 'package:wedding_service_module/core/utils/extensions/objec_ext.dart';
import 'package:wedding_service_module/src/domain/models/day_off_info_model.dart.dart';
import 'package:wedding_service_module/src/presentation/pages/service_canlendar/service_calendar_page_controller.dart';
import 'package:wedding_service_module/src/presentation/widgets/error_widget.dart';
import 'package:wedding_service_module/src/presentation/widgets/loading_widget.dart';

class ServiceCalendarPage extends StatelessWidget {
  const ServiceCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as ServiceCalendarArgs?;
    final service = args?.service;
    return GetBuilder<ServiceCalendarPageController>(
      init: ServiceCalendarPageController(currentService: service),
      global: false,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Lịch dịch vụ'),
            scrolledUnderElevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: controller.addDayOffInfo,
            child: const Icon(Icons.add),
          ),
          body: Column(
            children: [
              _CalendarView(controller),
              kGapH12,
              Expanded(
                child: _DayDetailInfo(controller),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CalendarView extends StatelessWidget {
  const _CalendarView(this.controller);

  final ServiceCalendarPageController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.dayOffInMonth.stream,
      builder: (context, snapshot) => Obx(() {
        return TableCalendar(
          // currentDay: DateTime.now(),
          daysOfWeekHeight: 32,
          eventLoader: _getDayOffInMonth,
          firstDay: DateTime(1900),
          lastDay: DateTime(2100),
          startingDayOfWeek: StartingDayOfWeek.monday,
          locale: 'vi_VN',
          calendarFormat: CalendarFormat.month,
          calendarStyle: CalendarStyle(
            markerDecoration: BoxDecoration(
              color: kTheme.colorScheme.secondary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            selectedTextStyle: TextStyle(
              color: kTheme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
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
              fontWeight: FontWeight.bold,
            ),
          ),
          availableCalendarFormats: const {CalendarFormat.month: 'Tháng'},
          focusedDay: controller.focusDate.value,
          selectedDayPredicate: (day) =>
              isSameDay(day, controller.selectedDateValue),
          onDaySelected: (selectedDay, focusedDay) {
            controller.focusDate.value = focusedDay;
            controller.selectedDate = selectedDay;
          },
          onPageChanged: controller.onFocusDateChanged,
        );
      }),
    );
  }

  List<DayOffInfoModel> _getDayOffInMonth(DateTime day) {
    return controller.dayOffInMonth
        .where((element) => isSameDay(element.date, day))
        .toList();
  }
}

class _DayDetailInfo extends StatelessWidget {
  const _DayDetailInfo(this.controller);

  final ServiceCalendarPageController controller;

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
