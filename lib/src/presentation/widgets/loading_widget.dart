import 'package:flutter/material.dart';
import 'package:wedding_service_module/core/constants/ui_constant.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.message = "Đang tải dữ liệu",
    this.isFullPage = false,
  }) : super(key: key);

  final String message;
  final bool isFullPage;

  @override
  Widget build(BuildContext context) {
    final view = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 100),
          CircularProgressIndicator(color: kTheme.colorScheme.primary),
          kGapH16,
          Text(message),
        ],
      ),
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
