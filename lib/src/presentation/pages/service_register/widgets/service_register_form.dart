import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/utils/extensions/num_ext.dart';
import 'package:wedding_service_module/src/domain/models/local_attachment_model.dart';
import 'package:wedding_service_module/src/presentation/pages/service_register/service_register_controller.dart';
import 'package:wedding_service_module/src/presentation/widgets/wrapped_inkwell.dart';

class RegisterForm extends GetView<ServiceRegisterPageController> {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const _ServiceCategory(),
            kGapH24,
            Text(
              'Thông tin dịch vụ',
              style: kTextTheme.titleLarge?.copyWith(
                color: kTheme.hintColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Các thông tin này sẽ được hiển thị cho khách hàng khi họ xem dịch vụ của bạn.',
              style: TextStyle(
                color: kTheme.hintColor,
              ),
            ),
            kGapH8,
            const _ServiceNameInput(),
            kGapH16,
            const _ServiceUnitInput(),
            kGapH16,
            const _ServicePriceInput(),
            kGapH16,
            const _ServiceDescriptionInput(),
            kGapH24,
            Text(
              'Hình ảnh dịch vụ',
              style: kTextTheme.titleMedium?.copyWith(
                color: kTheme.hintColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Chọn tối đa ${controller.attachmentPicker.maxAttachment} hình ảnh cho dịch vụ của bạn. Hình ảnh đầu tiên sẽ được sử dụng làm ảnh đại diện cho dịch vụ.',
              style: TextStyle(
                color: kTheme.hintColor,
              ),
            ),
            kGapH4,
            const _ServiceImageAttachments(),
            kGapH8,
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: controller.register,
                child: const Text('Đăng ký'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCategory extends GetView<ServiceRegisterPageController> {
  const _ServiceCategory();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.category.value.isError
          ? const SizedBox.shrink()
          : Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kTheme.hintColor.withOpacity(0.05),
                border: Border.all(
                  color: kTheme.hintColor.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: AnimatedSize(
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 300),
                child: controller.category.value.isSuccess
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Danh mục dịch vụ',
                            style: kTextTheme.bodyMedium?.copyWith(
                              color: kTheme.hintColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            controller.category.value.data!.name,
                            style: kTextTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Tỉ lệ chiết khấu: ${controller.category.value.data!.commissionRate}%',
                            style: kTextTheme.bodyMedium,
                          ),
                          Text(
                            controller.category.value.data!.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: kTextTheme.bodyMedium?.copyWith(
                              color: kTheme.hintColor,
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(),
                            ),
                            kGapW8,
                            Text('Đang tải danh mục dịch vụ...'),
                          ],
                        ),
                      ),
              ),
            ),
    );
  }
}

class _ServiceNameInput extends GetView<ServiceRegisterPageController> {
  const _ServiceNameInput();

  @override
  Widget build(BuildContext context) {
    return _LabelOnFieldWrapper(
      title: Text(
        'Tên dịch vụ *',
        style: kTextTheme.titleMedium?.copyWith(
          color: kTheme.hintColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập tên dịch vụ';
          }

          if (value.length < 6) {
            return 'Tên dịch vụ phải có ít nhất 6 ký tự';
          }
          return null;
        },
        onChanged: controller.serviceName,
        decoration: const InputDecoration(
          hintText: 'Ví dụ: Xe Vinfast Lux SA2.0, Ban nhạc khai tiệc, ...',
        ),
      ),
    );
  }
}

class _ServiceDescriptionInput extends GetView<ServiceRegisterPageController> {
  const _ServiceDescriptionInput();

  @override
  Widget build(BuildContext context) {
    return _LabelOnFieldWrapper(
      title: Text(
        'Mô tả dịch vụ *',
        style: kTextTheme.titleMedium?.copyWith(
          color: kTheme.hintColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: TextFormField(
        maxLines: 5,
        textInputAction: TextInputAction.newline,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập mô tả dịch vụ';
          }
          return null;
        },
        onChanged: controller.serviceDescription,
        decoration: const InputDecoration(
          hintText: 'Mô tả chi tiết về dịch vụ của bạn',
        ),
      ),
    );
  }
}

class _ServiceUnitInput extends GetView<ServiceRegisterPageController> {
  const _ServiceUnitInput();

  @override
  Widget build(BuildContext context) {
    return _LabelOnFieldWrapper(
      title: Text(
        'Đơn vị tính *',
        style: kTextTheme.titleMedium?.copyWith(
          color: kTheme.hintColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập đơn vị tính';
          }
          return null;
        },
        onChanged: controller.serviceUnit,
        decoration: const InputDecoration(
          hintText: 'Ví dụ: chiếc, bộ, ...',
        ),
      ),
    );
  }
}

class _ServicePriceInput extends GetView<ServiceRegisterPageController> {
  const _ServicePriceInput();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabelOnFieldWrapper(
          title: Text(
            'Giá dịch vụ *',
            style: kTextTheme.titleMedium?.copyWith(
              color: kTheme.hintColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              controller.servicePrice.value =
                  value.replaceAll(RegExp(r'[.|đ]'), '').removeAllWhitespace;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập giá dịch vụ';
              }
              return null;
            },
            inputFormatters: [
              CurrencyTextInputFormatter(
                locale: 'vi',
                symbol: 'đ',
                enableNegative: false,
                decimalDigits: 0,
              )
            ],
            decoration: const InputDecoration(
              hintText: 'Ví dụ: 100.000 đ',
            ),
          ),
        ),
        kGapH4,
        Obx(
          () {
            final price = int.tryParse(controller.servicePrice.value);
            String text = price.toVietnameseWords();
            return Text(
              'Thành chữ: $text đồng',
            );
          },
        ),
        kGapH4,
        Obx(
          () {
            if (controller.category.value.data?.commissionRate == null ||
                controller.servicePrice.value.isEmpty) {
              return const SizedBox.shrink();
            }
            final price = int.tryParse(controller.servicePrice.value);
            final revenue =
                (controller.category.value.data?.commissionRate != null &&
                        price != null)
                    ? price -
                        (price *
                            controller.category.value.data!.commissionRate! /
                            100)
                    : null;
            return Text(
              revenue == null
                  ? 'Có lỗi khi tính lợi nhuận, xin lỗi vì sự bất tiện này.'
                  : 'Lợi nhuận thực tế: ${revenue.toVietNamCurrency()}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        Text(
          '* Lợi nhuận thực tế = Giá dịch vụ - (Giá dịch vụ * Tỉ lệ chiết khấu)',
          style: TextStyle(
            color: kTheme.hintColor,
          ),
        )
      ],
    );
  }
}

class _ServiceImageAttachments extends GetView<ServiceRegisterPageController> {
  const _ServiceImageAttachments();

  @override
  Widget build(BuildContext context) {
    return FormField<List<LocalAttachmentModel>>(
      key: controller.attachmentPicker.formFieldKey,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng chọn ít nhất 1 hình ảnh';
        }
        return null;
      },
      builder: (formFieldState) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Obx(() {
          return AnimatedSize(
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.attachments.isNotEmpty)
                  Text(
                      'Đã chọn ${controller.attachments.length}/${controller.attachmentPicker.maxAttachment} hình ảnh'),
                SizedBox(
                  height: 130,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    separatorBuilder: (_, __) => kGapW8,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.attachments.length >=
                            controller.attachmentPicker.maxAttachment
                        ? controller.attachmentPicker.maxAttachment
                        : controller.attachments.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.attachments.length &&
                          controller.attachments.length <
                              controller.attachmentPicker.maxAttachment) {
                        return AspectRatio(
                          aspectRatio: 1,
                          child: WrappedInkWell(
                            onTap: controller.attachmentPicker.pickAttachment,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              dashPattern: const [8, 4],
                              color: kTheme.hintColor.withOpacity(0.2),
                              radius: const Radius.circular(12),
                              child: Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 34,
                                    color: kTheme.hintColor.withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      final attachment = controller.attachmentPicker
                          .attachments[index]; // -1 because of the add button
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(attachment.localPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: -4,
                            right: -1,
                            child: GestureDetector(
                              onTap: () {
                                controller.attachmentPicker.attachments
                                    .removeAt(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                if (formFieldState.hasError)
                  Text(
                    formFieldState.errorText!,
                    style: TextStyle(
                      color: kTheme.colorScheme.error,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _LabelOnFieldWrapper extends StatelessWidget {
  const _LabelOnFieldWrapper({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);
  final Widget child;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: DefaultTextStyle(
            style: kTextTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: kTheme.hintColor,
            ),
            child: title,
          ),
        ),
        kGapH8,
        // if (subtitle2 != null) ...[
        //   Padding(
        //     padding: const EdgeInsets.only(left: 4),
        //     child: DefaultTextStyle(
        //       style: kTextTheme.labelMedium!.copyWith(
        //         color: kTheme.hintColor,
        //       ),
        //       child: subtitle2!,
        //     ),
        //   ),
        //   kGapH4,
        // ],
        child,
      ],
    );
  }
}
