// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:wedding_service_module/core/constants/ui_constant.dart';
import 'package:wedding_service_module/core/utils/extensions/num_ext.dart';
import 'package:wedding_service_module/src/domain/models/wedding_service_model.dart';
import 'package:wedding_service_module/src/presentation/widgets/wrapped_inkwell.dart';

class ServiceItemWidget extends StatelessWidget {
  const ServiceItemWidget({
    super.key,
    required this.service,
    required this.onTap,
  }) : _isGridView = false;

  const ServiceItemWidget.listView({
    super.key,
    required this.service,
    required this.onTap,
  }) : _isGridView = false;

  const ServiceItemWidget.gridView({
    super.key,
    required this.service,
    required this.onTap,
  }) : _isGridView = true;

  final WeddingServiceModel service;
  final VoidCallback onTap;
  final bool _isGridView;

  @override
  Widget build(BuildContext context) {
    if (_isGridView) {
      return WrappedInkWell(
        onTap: onTap,
        child: _GridView(service: service),
      );
    }

    return Card(
      elevation: 1,
      child: WrappedInkWell(
        onTap: onTap,
        child: _CardView(service: service),
      ),
    );
  }
}

class _GridView extends StatelessWidget {
  const _GridView({required this.service});

  final WeddingServiceModel service;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: _ServiceImage(
                service: service,
              ),
            ),
          ),
          kGapH8,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _ServiceInfos(service: service),
          ),
        ],
      ),
    );
  }
}

class _CardView extends StatelessWidget {
  const _CardView({
    required this.service,
  });

  final WeddingServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox.square(
                dimension: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _ServiceImage(service: service),
                ),
              ),
              kGapW24,
              Expanded(
                child: _ServiceInfos(service: service),
              ),
            ],
          ),
        ],
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
  const _ServiceInfos({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          service.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: kTextTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          service.description,
          maxLines: 1,
          style: kTextTheme.labelMedium?.copyWith(
            color: kTheme.hintColor,
          ),
        ),
        kGapH20,
        if (service.price != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    service.price!.toVietNamCurrency(),
                    style: kTextTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kTheme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
