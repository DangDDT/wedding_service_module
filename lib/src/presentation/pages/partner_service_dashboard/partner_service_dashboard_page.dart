import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/partner_service_dashboard_page_controller.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/widgets/recent_added_service.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/widgets/revenue_stats.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/widgets/week_service_calendar_view.dart';

import 'widgets/recent_transactions_view.dart';

class PartnerServiceDashboardPageViewConfig {
  final bool isShowRecentAddedService;
  final bool isShowRevenueStats;
  final bool isShowWeekCalendar;
  final bool isShowRecentTransactions;

  const PartnerServiceDashboardPageViewConfig({
    this.isShowRecentAddedService = false,
    this.isShowRevenueStats = false,
    this.isShowWeekCalendar = false,
    this.isShowRecentTransactions = false,
  });
}

class PartnerServiceDashboardPage extends StatelessWidget {
  const PartnerServiceDashboardPage({
    super.key,
    this.controller,
    this.viewConfig = const PartnerServiceDashboardPageViewConfig(),
  });
  final PartnerServiceDashboardPageViewConfig viewConfig;
  final PartnerServiceDashboardPageController? controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller ?? PartnerServiceDashboardPageController(),
      builder: (controller) => Scaffold(
        body: RefreshIndicator(
          onRefresh: controller.refresh,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (viewConfig.isShowRecentAddedService) ...[
                  const RecentAddedServiceSection(),
                  kGapH24,
                ],
                if (viewConfig.isShowRevenueStats) ...[
                  const RevenueStats(),
                  kGapH24,
                ],
                if (viewConfig.isShowWeekCalendar) ...[
                  const WeekCalendarView(),
                  kGapH24,
                ],
                if (viewConfig.isShowRecentTransactions) ...[
                  const RecentTransactionsView(),
                  kGapH24,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
