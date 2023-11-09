import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/routes/module_router.dart';
import 'package:wedding_service_module/core/utils/extensions/objec_ext.dart';
import 'package:wedding_service_module/src/domain/models/day_off_info_model.dart.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/partner_service_dashboard_page_controller.dart';
import 'package:wedding_service_module/src/presentation/pages/service_canlendar/service_calendar_page_controller.dart';
import 'package:wedding_service_module/src/presentation/widgets/error_widget.dart';
import 'package:wedding_service_module/src/presentation/widgets/loading_widget.dart';

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
                'Lịch bận',
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
            focusedDay:
                controller.dayOffCalendarDashboardController.selectedDateValue,
            selectedDayPredicate: (day) => isSameDay(
              controller.dayOffCalendarDashboardController.selectedDateValue,
              day,
            ),
            onDaySelected: (day, focusedDay) {
              controller.dayOffCalendarDashboardController.selectedDate =
                  focusedDay;
            },
            eventLoader: (day) {
              return controller
                  .dayOffCalendarDashboardController.dayOffInMonth.value
                  .where((element) => isSameDay(element.date, day))
                  .toList();
            },
            currentDay: DateTime.now(),
            firstDay: DateTime(1900),
            lastDay: DateTime(2100),
          ),
        ),
        _DayDetailInfo(
          controller: controller.dayOffCalendarDashboardController,
        ),
      ],
    );
  }
}

class _DayDetailInfo extends StatelessWidget {
  const _DayDetailInfo({
    required this.controller,
  });

  final ServiceCalendarPageController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Obx(
        () {
          if (controller.selectedDayOffInfos.value.isLoading ||
              controller.selectedDayOffInfos.value.isLoading) {
            return const SizedBox(
              height: 120,
              child: Center(child: LoadingWidget()),
            );
          }

          if (controller.selectedDayOffInfos.value.isError) {
            return ErrorOrEmptyWidget(
              message: 'Có lỗi xảy ra, vui lòng thử lại sau.',
              callBack: controller.loadDayOffInDay,
              height: 120,
            );
          }

          if (controller.selectedDayOffInfos.value.data.isNullOrEmpty) {
            return const ErrorOrEmptyWidget(
              message: 'Không có lịch bận nào trong ngày này.',
              retryButtonTitle: 'Tải lại',
              height: 120,
            );
          }
          final isMoreThan3 =
              controller.selectedDayOffInfos.value.data!.length > 3;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Có ${controller.selectedDayOffInfos.value.data!.length} lịch bận',
                style: context.textTheme.bodyMedium,
              ),
              kGapH12,
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: isMoreThan3
                    ? 4
                    : controller.selectedDayOffInfos.value.data!.length,
                itemBuilder: (context, index) {
                  if (isMoreThan3 && index == 3) {
                    return Center(
                      child: TextButton(
                        onPressed: () => Get.toNamed(
                          ModuleRouter.weddingServiceCalendarRoute,
                        ),
                        child: const Text('Xem tất cả'),
                      ),
                    );
                  }
                  return _buildDayOffInfo(
                    controller.selectedDayOffInfos.value.data![index],
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDayOffInfo(DayOffInfoModel dayOffInfo) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: ExtendedNetworkImageProvider(
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
                  style: kTextTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                kGapH4,
                Text(
                  'Lý do bận: ${dayOffInfo.reason} ',
                  maxLines: 2,
                  style: kTextTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
