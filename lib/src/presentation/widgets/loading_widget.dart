import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.message = "Đang tải dữ liệu",
    this.isFullPage = false,
    this.axis = Axis.vertical,
    this.indicatorSize = 24,
  }) : super(key: key);

  final String message;
  final bool isFullPage;
  final Axis axis;
  final double indicatorSize;

  @override
  Widget build(BuildContext context) {
    final indicator = SizedBox.square(
      dimension: indicatorSize,
      child: CircularProgressIndicator(
        color: kTheme.colorScheme.primary,
      ),
    );

    final loadingText = Text(
      message,
      style: context.textTheme.bodySmall,
    );

    Widget view = axis == Axis.horizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              indicator,
              kGapW16,
              Flexible(child: loadingText),
            ],
          )
        : Column(mainAxisSize: MainAxisSize.min, children: [
            indicator,
            kGapH16,
            loadingText,
          ]);

    view = Center(
      child: view,
    );

    if (isFullPage) {
      return Scaffold(
        appBar: AppBar(),
        body: view,
      );
    }

    return view;
  }
}
