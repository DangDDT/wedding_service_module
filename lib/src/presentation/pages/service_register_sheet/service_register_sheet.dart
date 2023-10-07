// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_border/dotted_border.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/presentation/pages/service_register_sheet/service_register_sheet_controller.dart';
import 'package:wedding_service_module/src/presentation/widgets/wrapped_inkwell.dart';

class ServiceRegisterSheet extends StatelessWidget {
  final WeddingServiceModel service;

  const ServiceRegisterSheet({
    Key? key,
    required this.service,
  }) : super(key: key);

  static Future<T?> show<T>(WeddingServiceModel service) {
    return Get.dialog(
      ServiceRegisterSheet(service: service),
      barrierColor: Colors.black.withOpacity(0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ServiceRegisterSheetController(service),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            controller.handlePopData();
            return false;
          },
          child: GestureDetector(
            onTap: controller.handlePopData,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: GestureDetector(
                onTap: () {},
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FadeTransition(
                    opacity: controller.slideUpAnimatedController,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, .1),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: controller.slideUpAnimatedController,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: Container(
                        width: context.width * 0.95,
                        height: context.width * 1.1,
                        constraints: const BoxConstraints(
                          maxHeight: 500,
                          maxWidth: 350,
                        ),
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: context.theme.dialogBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Đăng ký dịch vụ',
                              style: kTextTheme.titleLarge,
                            ),
                            kGapH8,
                            Expanded(
                              child: Obx(
                                () => AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 410),
                                  reverseDuration: Duration.zero,
                                  transitionBuilder: (child, animation) =>
                                      SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, .05),
                                      end: Offset.zero,
                                    ).animate(
                                      CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.decelerate,
                                      ),
                                    ),
                                    child: FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  ),
                                  child: controller.state.value.when(
                                    initial: () => const _RegisterView(),
                                    loading: (_) => const _Registering(),
                                    success: (_) => const _RegisterSuccess(),
                                    error: (_) => const _RegisterFailed(),
                                  ),
                                ),
                              ),
                            ),
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

class _Registering extends StatelessWidget {
  const _Registering();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingAnimationWidget.fourRotatingDots(
            size: 48,
            color: kTheme.primaryColor,
          ),
          kGapH24,
          Text(
            'Đang gửi yêu cầu...',
            textAlign: TextAlign.center,
            style: kTextTheme.titleMedium,
          ),
          kGapH4,
          const Text(
            'Đơn yêu cầu đăng ký của bạn đang được gửi đi, vui lòng chờ trong giây lát.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _RegisterFailed extends GetView<ServiceRegisterSheetController> {
  const _RegisterFailed();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                kGapH24,
                Text(
                  'Có lỗi xảy ra',
                  textAlign: TextAlign.center,
                  style: kTextTheme.titleMedium,
                ),
                kGapH4,
                const Text(
                  'Đăng ký dịch vụ không thành công, vui lòng thử lại sau. Xin lỗi vì sự bất tiện này.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          kGapH8,
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: controller.register,
              child: const Text('Thử lại'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.grey.withOpacity(0.2),
                ),
              ),
              onPressed: controller.handlePopData,
              child: const Text('Đóng'),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterSuccess extends GetView<ServiceRegisterSheetController> {
  const _RegisterSuccess();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 64,
                  color: Colors.green.shade700,
                ),
                kGapH24,
                Text(
                  'Đăng ký dịch vụ thành công!',
                  textAlign: TextAlign.center,
                  style: kTextTheme.titleMedium,
                ),
                kGapH4,
                const Text(
                  'Cảm ơn đã đăng ký dịch vụ của bạn, chúng tôi sẽ thông báo cho bạn khi dịch vụ được duyệt.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonal(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.grey.withOpacity(0.2),
                ),
              ),
              onPressed: controller.handlePopData,
              child: const Text('Đóng'),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterView extends GetView<ServiceRegisterSheetController> {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          controller.service.name,
          style: kTextTheme.titleSmall?.copyWith(
            color: kTheme.primaryColor,
          ),
        ),
        kGapH4,
        const Text(
          'Vui lòng đính kèm 1 hình ảnh chứng minh về dịch vụ của bạn',
        ),
        kGapH8,
        const Expanded(
          child: _ServiceImageAttachment(),
        ),
        kGapH8,
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: controller.register,
            child: const Text('Đăng ký'),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: FilledButton.tonal(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.grey.withOpacity(0.2),
              ),
            ),
            onPressed: controller.handlePopData,
            child: const Text('Đóng'),
          ),
        ),
      ],
    );
  }
}

class _ServiceImageAttachment extends GetView<ServiceRegisterSheetController> {
  const _ServiceImageAttachment();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WrappedInkWell(
        onTap: controller.addAttachment,
        child: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: const [8, 4],
          color: (controller.attachment.value != null)
              ? Colors.transparent
              : kTheme.hintColor.withOpacity(0.2),
          radius: const Radius.circular(12),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: (controller.attachment.value != null)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ExtendedImage.file(
                        controller.attachmentFile.value!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.add_a_photo_outlined,
                      size: 40,
                      color: kTheme.hintColor.withOpacity(0.2),
                    ),
            ),
          ),
        ),
      );
    });
  }
}
