import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/routes/module_router.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/partner_service_dashboard_page_controller.dart';

class WeekCalendarView extends GetView<PartnerServiceDashboardPageController> {
  const WeekCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Lịch bận trong tuần',
                style: context.textTheme.titleLarge,
              ),
            ),
            TextButton(
              onPressed: () =>
                  Get.toNamed(ModuleRouter.weddingServiceCalendarRoute),
              child: const Text('Xem tất cả'),
            ),
          ],
        ),
        kGapH12,
        Obx(
          () => TableCalendar(
            locale: 'vi_VN',
            availableCalendarFormats: const {
              CalendarFormat.week: 'Tuần',
            },
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
            calendarFormat: CalendarFormat.week,
            focusedDay: controller.selectedDate.value,
            selectedDayPredicate: (day) =>
                isSameDay(controller.selectedDate.value, day),
            onDaySelected: (day, focusedDay) {
              controller.selectedDate.value = day;
            },
            currentDay: DateTime.now(),
            firstDay: DateTime(1900),
            lastDay: DateTime(2100),
          ),
        )
      ],
    );
  }
}
