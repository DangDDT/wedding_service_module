// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/utils/extensions/num_ext.dart';
import 'package:wedding_service_module/src/domain/enums/private/wedding_service_state.dart';
import 'package:wedding_service_module/src/presentation/pages/service_detail_page/service_detail_page_controller.dart';

class ServiceBusinessSituationView
    extends GetView<ServiceDetailPageController> {
  const ServiceBusinessSituationView({super.key});
  @override
  Widget build(BuildContext context) {
    // const status = WeddingServiceState.suspended;
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tình hình kinh doanh',
                style: kTextTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              kGapH4,
              if (controller.state.value.data?.profitStatement == null)
                const _NotRegistered()
              else
                switch (controller.state.value.data!.state) {
                  WeddingServiceState.registering =>
                    const _RequestingServiceView(),
                  WeddingServiceState.rejected => const _RejectedServiceBuild(),
                  WeddingServiceState.active => const _ActiveServiceView(),
                  WeddingServiceState.suspended =>
                    const _SuspendedServiceView(),
                }
            ],
          ),
        );
      },
    );
  }
}

class _NotRegistered extends GetView<ServiceDetailPageController> {
  const _NotRegistered();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Icon(
            Icons.app_registration_rounded,
            size: 48,
            color: kTheme.colorScheme.primary,
          ),
          kGapH12,
          Text(
            'Chưa đăng ký dịch vụ'.toUpperCase(),
            style: kTextTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: kTheme.colorScheme.primary,
            ),
          ),
          kGapH4,
          Text(
            'Bạn chưa đăng ký kinh doanh dịch vụ này. Bấm vào nút bên dưới để đăng ký hoặc liên hệ với chúng tôi nếu có bất kỳ thắc mắc nào cần giải đáp.',
            textAlign: TextAlign.center,
            style: kTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: kTheme.hintColor,
            ),
          ),
          kGapH24,
          const SizedBox(
            width: double.infinity,
            child: _RegisterButton(),
          ),
          const SizedBox(
            width: double.infinity,
            child: _ContactUsButton(),
          ),
        ],
      ),
    );
  }
}

class _RequestingServiceView extends GetView<ServiceDetailPageController> {
  const _RequestingServiceView();

  @override
  Widget build(BuildContext context) {
    final partnerService = controller.state.value.data;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Icon(
              Icons.pending_actions,
              size: 48,
              color: kTheme.colorScheme.primary,
            ),
            kGapH8,
            Text(
              'Đang Duyệt',
              style: kTextTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: kTheme.colorScheme.primary,
              ),
            ),
            Text.rich(
              TextSpan(
                style: kTextTheme.bodyMedium?.copyWith(
                  color: kTheme.hintColor,
                ),
                children: [
                  if (partnerService?.registeredAt != null)
                    TextSpan(
                      text:
                          'Yêu cầu đăng ký dịch vụ đã được gửi vào lúc ${DateFormat('HH:mm dd/MM/yyyy').format(partnerService!.registeredAt)}.',
                    ),
                  const TextSpan(
                    text: 'Vui lòng chờ duyệt.',
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            kGapH24,
            const SizedBox(
              width: double.infinity,
              child: _ContactUsButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RejectedServiceBuild extends GetView<ServiceDetailPageController> {
  const _RejectedServiceBuild();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Icon(
            Icons.cancel,
            size: 52,
            color: kTheme.colorScheme.error,
          ),
          kGapH12,
          Text(
            'Đăng ký dịch vụ bị từ chối'.toUpperCase(),
            style: kTextTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: kTheme.colorScheme.error,
            ),
          ),
          kGapH4,
          Text(
            'Vui lòng đăng ký lại hoặc liên hệ với chúng tôi để biết thêm chi tiết, xin cảm ơn!',
            textAlign: TextAlign.center,
            style: kTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: kTheme.hintColor,
            ),
          ),
          kGapH24,
          const SizedBox(
            width: double.infinity,
            child: _RegisterButton(isReRegister: true),
          ),
          const SizedBox(
            width: double.infinity,
            child: _ContactUsButton(),
          ),
        ],
      ),
    );
  }
}

class _ActiveServiceView extends GetView<ServiceDetailPageController> {
  const _ActiveServiceView();

  @override
  Widget build(BuildContext context) {
    final partnerService = controller.state.value.data;
    final profitStatement = partnerService?.profitStatement;
    final data = [
      ('Số Lượt Đặt', profitStatement?.totalOrder ?? 0, 'lượt'),
      ('Đã cung cấp', profitStatement?.totalProductProvided ?? 0, 'sp'),
    ];
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            TextSpan(
              style: kTextTheme.bodyMedium,
              children: [
                const TextSpan(
                  text: 'Bắt đầu kinh doanh từ ',
                ),
                TextSpan(
                  text: DateFormat('EEEE, HH:mm dd/MM/yyyy', 'vi')
                      .format(partnerService!.registeredAt),
                  style: kTextTheme.bodyMedium,
                ),
                const TextSpan(
                  text: '.',
                ),
              ],
            ),
            style: kTextTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: kTheme.hintColor,
            ),
          ),
        ),
        kGapH12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: data
              .map(
                (e) => Column(
                  children: [
                    Text(
                      e.$1,
                      style: kTextTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: kTheme.hintColor,
                      ),
                    ),
                    kGapH8,
                    Text(
                      e.$2.toString(),
                      style: kTextTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: kTheme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      e.$3,
                      style: kTextTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: kTheme.hintColor,
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
        kGapH8,
        Text(
          'Tổng doanh thu:',
          style: kTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: kTheme.hintColor,
          ),
        ),
        kGapH8,
        Text(
          (profitStatement?.totalRevenue ?? 0).toVietNamCurrency(),
          style: kTextTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: kTheme.colorScheme.primary,
          ),
        ),
        kGapH28,
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: controller.pushToSalesHistoryPage,
            child: const Text('Xem lịch sử giao dịch'),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: FilledButton.tonal(
            onPressed: controller.suspendService,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                kTheme.hintColor.withOpacity(0.2),
              ),
            ),
            child: const Text('Ngưng kinh doanh'),
          ),
        ),
      ],
    );
  }
}

class _SuspendedServiceView extends GetView<ServiceDetailPageController> {
  const _SuspendedServiceView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Icon(
            Icons.cancel,
            size: 52,
            color: kTheme.hintColor,
          ),
          kGapH12,
          Text(
            'Tạm ngưng kinh doanh'.toUpperCase(),
            style: kTextTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: kTheme.hintColor,
            ),
          ),
          kGapH8,
          Text(
            'Dịch vụ này đang tạm ngưng kinh doanh. Bấm vào nút bên dưới để tiếp tục kinh doanh dịch vụ này.',
            textAlign: TextAlign.center,
            style: kTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: kTheme.hintColor,
            ),
          ),
          kGapH24,
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: controller.reActive,
              icon: const Icon(Icons.refresh),
              label: const Text('Tiếp tục kinh doanh'),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterButton extends GetView<ServiceDetailPageController> {
  const _RegisterButton({
    Key? key,
    this.isReRegister = false,
  }) : super(key: key);

  /// Whether the service is being registered for the first time or not.
  final bool isReRegister;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: controller.register,
      icon: Icon(
        isReRegister ? Icons.refresh : Icons.app_registration_rounded,
      ),
      label: isReRegister ? const Text('Đăng ký lại') : const Text('Đăng ký'),
    );
  }
}

class _ContactUsButton extends GetView<ServiceDetailPageController> {
  const _ContactUsButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: controller.contactUs,
      icon: const Icon(Icons.phone),
      label: const Text('Liên hệ với chúng tôi'),
    );
  }
}
