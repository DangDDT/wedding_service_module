import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/utils/extensions/datetime_ext.dart';
import 'package:wedding_service_module/core/utils/extensions/num_ext.dart';
import 'package:wedding_service_module/src/presentation/pages/wedding_services_page/widgets/services_list_filter/service_list_filter_controller.dart';
import 'package:wedding_service_module/src/presentation/view_models/services_list_filter_data.dart';
import 'package:wedding_service_module/src/presentation/widgets/selection_button.dart';

class ServicesListFilterBottomSheet extends StatelessWidget {
  const ServicesListFilterBottomSheet({
    super.key,
    this.initialData,
    required this.isShowClearButton,
    required this.registerDateRange,
    required this.registerRevenueRange,
  });

  final ServicesListFilterData? initialData;
  final bool isShowClearButton;
  final bool registerDateRange;
  final bool registerRevenueRange;

  static Future<ServicesListFilterData?> show({
    ServicesListFilterData? initialData,
    bool isShowClearButton = true,
    bool registerDateRange = true,
    bool registerRevenueRange = true,
  }) async {
    return Get.dialog(
      ServicesListFilterBottomSheet(
        initialData: initialData,
        isShowClearButton: isShowClearButton,
        registerDateRange: registerDateRange,
        registerRevenueRange: registerRevenueRange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicesListFilterController>(
      init: ServicesListFilterController()..initFilter(initialData),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            await controller.back();
            return false;
          },
          child: GestureDetector(
            onTap: controller.back,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: controller.slideUpAnimatedController.drive(
                    Tween<Offset>(
                      begin: const Offset(0, .8),
                      end: Offset.zero,
                    ),
                  ),
                  child: FadeTransition(
                    opacity: controller.slideUpAnimatedController,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: context.theme.dialogBackgroundColor,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: controller.back,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.close,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Lọc dịch vụ",
                                style:
                                    context.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            kGapH24,
                            if (registerDateRange) ...[
                              const _DateRangePicker(),
                              kGapH16,
                            ],
                            if (registerRevenueRange) ...[
                              const _PriceRangeSlider(),
                              kGapH16,
                            ],
                            Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: FilledButton(
                                    onPressed: () => controller.back(
                                      applyChanges: true,
                                    ),
                                    child: const Text("Áp dụng"),
                                  ),
                                ),
                                kGapW8,
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: FilledButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Colors.grey.shade200,
                                      ),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                        Colors.black,
                                      ),
                                    ),
                                    onPressed: controller.onClear,
                                    child: const Text("Đặt lại"),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DateRangePicker extends GetView<ServicesListFilterController> {
  const _DateRangePicker();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Ngày đăng ký',
          style: kTextTheme.titleMedium,
        ),
        kGapH12,
        Row(
          children: [
            Expanded(
              child: SelectionButton(
                // icon: Icons.calendar_today_outlined,
                label: 'Từ',
                content: controller.filterData.value.dateRange?.start
                    .toDateReadable(),
                onPressed: controller.pickRegisterStartDate,
              ),
            ),
            kGapW8,
            Expanded(
              child: SelectionButton(
                // icon: Icons.calendar_today_outlined,
                label: 'Đến',
                content:
                    controller.filterData.value.dateRange?.end.toDateReadable(),
                onPressed: controller.pickRegisterEndDate,
              ),
            ),
            //   (
            //     'Từ',
            //     controller.filterData.value.dateRange?.start.toDateReadable(),
            //     'Chọn ngày',
            //     controller.pickRegisterStartDate,
            //   ),
            //   (
            //     'Đến',
            //     controller.filterData.value.dateRange?.end.toDateReadable(),
            //     'Chọn ngày',
            //     controller.pickRegisterEndDate,
            //   ),
            // ]
            //     .map((e) => Expanded(
            //           child: SizedBox(
            //             width: double.infinity,
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.only(left: 8.0),
            //                   child: Text(
            //                     e.$1,
            //                     style: kTextTheme.labelMedium?.copyWith(
            //                       color: kTheme.hintColor,
            //                     ),
            //                   ),
            //                 ),
            //                 kGapH4,
            //                 WrappedInkWell(
            //                   onTap: e.$4,
            //                   child: SizedBox(
            //                     width: double.infinity,
            //                     child: DecoratedBox(
            //                       decoration: BoxDecoration(
            //                         color: kTheme.colorScheme.primaryContainer
            //                             .withOpacity(.5),
            //                         borderRadius: BorderRadius.circular(12),
            //                       ),
            //                       child: Padding(
            //                         padding: const EdgeInsets.symmetric(
            //                           horizontal: 12,
            //                           vertical: 12,
            //                         ),
            //                         child: Row(
            //                           children: [
            //                             Icon(
            //                               Icons.calendar_today_outlined,
            //                               color: kTheme.hintColor,
            //                             ),
            //                             kGapW8,
            //                             Text(
            //                               e.$2 ?? e.$3,
            //                               style:
            //                                   kTextTheme.bodyMedium?.copyWith(
            //                                 color: e.$2 != null
            //                                     ? null
            //                                     : kTheme.hintColor,
            //                                 fontWeight: FontWeight.bold,
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            // ))
            // .toList()
            // .joinWidget(kGapW8),
          ],
        ),
      ]),
    );
  }
}

class _PriceRangeSlider extends GetView<ServicesListFilterController> {
  const _PriceRangeSlider();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mức giá',
          style: kTextTheme.titleMedium,
        ),
        kGapH12,
        // Row(
        //   children: [
        //     Expanded(
        //       child: TextFormField(
        //         keyboardType: TextInputType.number,
        //         inputFormatters: [
        //           CurrencyTextInputFormatter(
        //             locale: 'vi',
        //             symbol: 'đ',
        //             turnOffGrouping: false,
        //           )
        //         ],
        //         initialValue: '0 đ',
        //         decoration: const InputDecoration(
        //           hintText: 'Từ',
        //           contentPadding: EdgeInsets.symmetric(
        //             horizontal: 16,
        //             vertical: 12,
        //           ),
        //         ),
        //         onChanged: (value) {
        //           final valueStr = value.removeAllWhitespace
        //               .replaceAll(RegExp(r'[.|đ]'), '');
        //           final min = double.tryParse(valueStr);

        //           final values = RangeValues(
        //             min ?? 0,
        //             controller.filterData.value.revenueRange.end,
        //           );
        //           controller.onRevenueRangeChanged(values);
        //         },
        //       ),
        //     ),
        //     kGapW8,
        //     Expanded(
        //       child: TextFormField(
        //         keyboardType: TextInputType.number,
        //         inputFormatters: [
        //           CurrencyTextInputFormatter(
        //             locale: 'vi',
        //             symbol: 'đ',
        //             turnOffGrouping: false,
        //           )
        //         ],
        //         initialValue: '100.000.000 đ',
        //         decoration: const InputDecoration(
        //           hintText: 'Đến',
        //           contentPadding: EdgeInsets.symmetric(
        //             horizontal: 16,
        //             vertical: 12,
        //           ),
        //         ),
        //         onChanged: (value) {
        //           final valueStr = value.removeAllWhitespace
        //               .replaceAll(RegExp(r'[.|đ]'), '');
        //           final min = double.tryParse(valueStr);
        //           final values = RangeValues(
        //             min ?? 0,
        //             controller.filterData.value.revenueRange.end,
        //           );
        //           controller.onRevenueRangeChanged(values);
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        Obx(
          () => Row(
            children: [
              Text(
                'Từ: ',
                style: kTextTheme.bodyMedium?.copyWith(
                  color: kTheme.hintColor,
                ),
              ),
              Text(
                controller.filterData.value.revenueRange.start
                    .toVietNamCurrency(),
                textAlign: TextAlign.start,
                style: kTextTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' - ',
                style: kTextTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                controller.filterData.value.revenueRange.end
                    .toVietNamCurrency(),
                textAlign: TextAlign.end,
                style: kTextTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => SliderTheme(
            data: const SliderThemeData(
              trackHeight: 4,
              showValueIndicator: ShowValueIndicator.always,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
            ),
            child: RangeSlider(
              labels: RangeLabels(
                controller.filterData.value.revenueRange.start
                    .toVietNamCurrency(),
                controller.filterData.value.revenueRange.end
                    .toVietNamCurrency(),
              ),
              // divisions: controller.kRevenueRangeDivisions,
              values: controller.filterData.value.revenueRange,
              min: controller.kMinRevenue,
              max: controller.kMaxRevenue,
              onChanged: controller.onRevenueRangeChanged,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.kMinRevenue.toVietNamCurrency(),
                  textAlign: TextAlign.start,
                  style: kTextTheme.labelMedium?.copyWith(
                    color: kTheme.hintColor,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  controller.kMaxRevenue.toVietNamCurrency(),
                  textAlign: TextAlign.end,
                  style: kTextTheme.labelMedium?.copyWith(
                    color: kTheme.hintColor,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
