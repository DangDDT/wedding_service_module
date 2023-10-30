// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/utils/extensions/num_ext.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/presentation/widgets/rating_bar.dart';
import 'package:wedding_service_module/src/presentation/widgets/wrapped_inkwell.dart';

class ServiceGridItemWidget extends StatelessWidget {
  const ServiceGridItemWidget({
    super.key,
    required this.service,
    required this.onTap,
  });

  final WeddingServiceModel service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WrappedInkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: kTheme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: kTheme.colorScheme.onSurface.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _ServiceImage(
                  service: service,
                ),
              ),
            ),
            kGapH8,
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                  child: _ServiceInfos(service: service),
                ),
              ),
            )
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
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: 0.1,
        sigmaY: .2,
      ),
      child: ExtendedImage.network(
        service.coverImage,
        fit: BoxFit.cover,
        loadStateChanged: _loadErrorHandler,
      ),
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
  const _ServiceInfos({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          service.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        kGapH12,
        // Text(
        //   service.description,
        //   maxLines: 1,
        //   style: context.textTheme.labelMedium?.copyWith(
        //     color: Colors.white70,
        //   ),
        // ),
        if (service.rating != null)
          Row(
            children: [
              StarRatingBar(
                rating: service.rating!,
                color: Colors.yellow.shade700,
              ),
              kGapW4,
              Text(
                service.rating!.toStringAsFixed(1),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        if (service.price != null) ...[
          kGapH8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    service.price!.toVietNamCurrency(),
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ],
    );
  }
}
