import 'package:flutter/material.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';

class ErrorOrEmptyWidget extends StatelessWidget {
  final String message;
  final String? content;
  final String? retryButtonTitle;
  final VoidCallback? callBack;
  final double height;
  const ErrorOrEmptyWidget({
    Key? key,
    this.message = "Không có dữ liệu",
    this.retryButtonTitle = "Thử lại",
    this.content,
    this.callBack,
    this.height = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (content != null) ...[
              kGapH12,
              Text(
                content!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            if (callBack != null) ...[
              kGapH12,
              FilledButton.tonal(
                onPressed: callBack,
                child: Text(
                  retryButtonTitle!,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
