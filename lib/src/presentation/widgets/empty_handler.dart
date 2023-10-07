import 'package:flutter/material.dart';

class EmptyErrorHandler extends StatelessWidget {
  const EmptyErrorHandler({
    super.key,
    required this.title,
    this.isFullPage = false,
    this.banner,
    this.description,
    this.reloadCallback,
  });

  final bool isFullPage;

  final Widget? banner;
  final String title;
  final String? description;
  final VoidCallback? reloadCallback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final view = SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (banner != null)
              IconTheme(
                data: IconThemeData(
                  color: theme.disabledColor,
                  size: 60,
                ),
                child: banner!,
              ),
            const SizedBox(height: 12),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            if (description != null) const SizedBox(height: 8),
            if (description != null)
              SizedBox(
                width: 250,
                child: Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            if (reloadCallback != null) const SizedBox(height: 28),
          ],
        ),
      ),
    );

    if (isFullPage) {
      return Scaffold(
        body: view,
      );
    } else {
      return view;
    }
  }
}
