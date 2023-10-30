import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/src/presentation/pages/partner_service_dashboard/partner_service_dashboard_page_controller.dart';
import 'package:wedding_service_module/src/presentation/widgets/stats_date_range_picker.dart';

class RevenueStats extends GetView<PartnerServiceDashboardPageController> {
  const RevenueStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Doanh thu',
          style: Get.textTheme.titleLarge,
        ),
        kGapH8,
        Obx(
          () => StatsDateRangePicker(
            value: controller.dateRange.value,
            onDateRangeChanged: controller.dateRange,
          ),
        ),
        kGapH24,
        const _TotalRevenueStat(),
        kGapH32,
        const _RevenueColChart(),
      ],
    );
  }
}

class _TotalRevenueStat extends StatelessWidget {
  const _TotalRevenueStat();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            'Tổng doanh thu',
            '1.000.000đ',
          ),
        ),
        kGapW12,
        Expanded(
          child: _buildStatItem(
            'Tổng số lượt đặt',
            '10',
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: Get.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: kTheme.hintColor,
          ),
        ),
        kGapH12,
        Text(
          value,
          style: Get.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: kTheme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _RevenueColChart extends GetView<PartnerServiceDashboardPageController> {
  const _RevenueColChart();

  @override
  Widget build(BuildContext context) {
    final data = _makeChartData();
    return AspectRatio(
      aspectRatio: 1.1,
      child: BarChart(
        BarChartData(
          barGroups: data,
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: _bottomTitles,
                reservedSize: 42,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: 1,
                getTitlesWidget: _leftTitles,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  List<BarChartGroupData> _makeChartData() {
    return List.generate(7, (index) {
      final randomY = math.Random().nextDouble() * 100;
      return _makeGroupData(index, randomY);
    });
  }

  BarChartGroupData _makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: kTheme.colorScheme.primary,
          width: 16,
        ),
      ],
    );
  }
}
