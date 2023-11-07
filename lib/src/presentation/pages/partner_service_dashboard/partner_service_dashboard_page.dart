import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/partner_service_dashboard_page_controller.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/widgets/recent_added_service.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/widgets/recent_transactions_view.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/widgets/revenue_stats.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/widgets/week_service_calendar_view.dart';

class PartnerServiceDashboardPage extends StatelessWidget {
  const PartnerServiceDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PartnerServiceDashboardPageController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Thống kê dịch vụ'),
        ),
        body: RefreshIndicator(
          onRefresh: controller.refresh,
          child: const SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecentAddedServiceSection(),
                kGapH24,
                RevenueStats(),
                kGapH24,
                WeekCalendarView(),
                kGapH24,
                RecentTransactionsView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
