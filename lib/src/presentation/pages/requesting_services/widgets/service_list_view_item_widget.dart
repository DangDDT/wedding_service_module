import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/utils/extensions/datetime_ext.dart';
import 'package:wedding_service_module/core/utils/extensions/num_ext.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/presentation/widgets/wrapped_inkwell.dart';

class ServiceListItemWidget extends StatelessWidget {
  const ServiceListItemWidget({
    super.key,
    required this.service,
    required this.onTap,
    this.backgroundColor,
  });

  final WeddingServiceModel service;
  final VoidCallback onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return WrappedInkWell(
      onTap: onTap,
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: backgroundColor ?? kTheme.colorScheme.surface,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: .7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _ServiceImage(service: service),
              ),
            ),
            kGapW24,
            Expanded(
              child: _ServiceInfos(service: service, onPressed: onTap),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceImage extends StatelessWidget {
  final WeddingServiceModel service;
  const _ServiceImage({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      service.coverImage,
      fit: BoxFit.cover,
      loadStateChanged: _loadErrorHandler,
    );
  }

  Widget? _loadErrorHandler(ExtendedImageState state) {
    if (state.extendedImageLoadState != LoadState.failed) {
      return null;
    }
    return Center(
      child: Icon(
        Icons.image_outlined,
        color: kTheme.colorScheme.primary,
        size: 40,
      ),
    );
  }
}

class _ServiceInfos extends StatelessWidget {
  final WeddingServiceModel service;
  final VoidCallback onPressed;
  const _ServiceInfos({
    Key? key,
    required this.service,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          service.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AutoSizeText(
          'Đăng ký ngày ${service.registeredAt.toReadable()}',
          maxLines: 1,
          style: context.textTheme.labelMedium?.copyWith(
            color: kTheme.hintColor,
          ),
        ),
        kGapH12,
        Text(
          service.description,
          maxLines: 2,
          style: context.textTheme.labelMedium?.copyWith(
            color: kTheme.hintColor,
          ),
        ),
        if (service.price != null) ...[
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    service.price!.toVietNamCurrency(),
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              kGapW8,
              FilledButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kTheme.colorScheme.primary,
                  visualDensity: VisualDensity.compact,
                ),
                onPressed: onPressed,
                child: const Text('Chi tiết'),
              ),
            ],
          )
        ],
      ],
    );
  }
}
