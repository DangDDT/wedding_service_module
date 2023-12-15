import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/src/domain/enums/private/loading_enum.dart';
import 'package:wedding_service_module/src/presentation/pages/service_detail_page/widgets/suspended_service/suspend_service_bottomsheet_controller.dart';

class SuspendServiceBottomSheet extends StatelessWidget {
  const SuspendServiceBottomSheet({super.key, required this.serviceId});

  final String serviceId;

  Future<bool?> show() async {
    return Get.dialog(
      this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuspendServiceBottomSheetController>(
      init: SuspendServiceBottomSheetController(serviceId),
      builder: (controller) => GestureDetector(
        onTap: controller.onBack,
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
                  child: KeyboardDismisser(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.theme.dialogBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
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
                              onTap: controller.onBack,
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
                              "Ngừng kinh doanh dịch vụ",
                              style: context.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          kGapH16,
                          const Text(
                            'Lưu ý rằng, sau khi ngừng kinh doanh, các đơn hàng đang chờ xử lý vẫn sẽ phải được xử lý bình thường. Bạn vẫn phải hoàn thành các đơn hàng này.',
                          ),
                          kGapH8,
                          const Text(
                            'Vui lòng nhập lý do ngừng cung cấp dịch vụ vào ô bên dưới và nhấn nút "Ngừng cung cấp dịch vụ" để hoàn tất.',
                          ),
                          kGapH16,
                          TextFormField(
                            controller: controller.reasonController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập lý do ngừng cung cấp dịch vụ';
                              }

                              if (value.length < 10) {
                                return 'Lý do ngừng cung cấp dịch vụ phải có ít nhất 10 ký tự';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Lý do ngừng cung cấp dịch vụ',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                          ),
                          kGapH8,
                          const Text(
                            '* Lý do ngừng cung cấp dịch vụ phải có ít nhất 10 ký tự',
                          ),
                          kGapH16,
                          SizedBox(
                            width: double.infinity,
                            child: Obx(
                              () {
                                late final String buttonText;
                                switch (controller.loadingState.value) {
                                  case LoadingState.error:
                                    buttonText = 'Thử lại';
                                    break;
                                  case LoadingState.loading:
                                    buttonText = 'Đang thực hiện ...';
                                    break;
                                  default:
                                    buttonText = 'Ngừng cung cấp dịch vụ';
                                }
                                return FilledButton(
                                  onPressed: (controller.isActive.value &&
                                          !controller
                                              .loadingState.value.isLoading)
                                      ? controller.suspendService
                                      : null,
                                  child: Text(buttonText),
                                );
                              },
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
      ),
    );
  }
}
