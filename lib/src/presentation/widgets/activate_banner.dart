import 'package:flutter/cupertino.dart';

class ActivateBanner extends StatelessWidget {
  const ActivateBanner({
    super.key,
    required this.enabled,
    required this.message,
    required this.child,
    this.color = const Color(0xFF00FF00),
    this.textStyle = const TextStyle(color: Color(0xFF000000)),
  });

  final bool enabled;
  final String message;
  final Widget child;
  final Color color;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: color,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
