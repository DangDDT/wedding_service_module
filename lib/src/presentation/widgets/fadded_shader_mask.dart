// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FadedShaderMask extends StatelessWidget {
  const FadedShaderMask({
    Key? key,
    required this.child,
    this.stops = const [0.3, 1],
  }) : super(key: key);

  final Widget child;
  final List<double> stops;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: stops,
          colors: const [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
