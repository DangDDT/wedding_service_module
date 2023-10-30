// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/src/presentation/pages/service_register/service_register_controller.dart';
import 'package:wedding_service_module/src/presentation/pages/service_register/widgets/service_register_form.dart';

class ServiceRegisterPage extends StatelessWidget {
  // final WeddingServiceModel service;

  const ServiceRegisterPage({
    Key? key,
    // required this.service,
  }) : super(key: key);

  // static Future<T?> show<T>(WeddingServiceModel service) {
  //   return Get.dialog(
  //     ServiceRegisterPage(service: service),
  //     barrierColor: Colors.black.withOpacity(0.2),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: GetBuilder(
        init: ServiceRegisterPageController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              controller.handlePopData();
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
                title: const Text('Đăng ký dịch vụ'),
              ),
              body: Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 410),
                  reverseDuration: Duration.zero,
                  transitionBuilder: (child, animation) => SlideTransition(
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
                    initial: () => const RegisterForm(),
                    loading: (_) => const _Registering(),
                    success: (_) => const _RegisterSuccess(),
                    error: (_) => const _RegisterFailed(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Registering extends StatelessWidget {
  const _Registering();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
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
      ),
    );
  }
}

class _RegisterFailed extends GetView<ServiceRegisterPageController> {
  const _RegisterFailed();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
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
            kGapH24,
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
      ),
    );
  }
}

class _RegisterSuccess extends GetView<ServiceRegisterPageController> {
  const _RegisterSuccess();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.attachments.firstOrNull?.file != null)
              ExtendedImage.file(
                controller.attachments.first.file!,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.green.shade700,
                  width: 2,
                ),
              )
            else
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
            kGapH24,
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
      ),
    );
  }
}
