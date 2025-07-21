import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final ImageProvider image;
  final Widget child;
  final Color overlayColor;
  final BoxFit fit;

  const BackgroundContainer({
    super.key,
    required this.image,
    required this.child,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 0.45),
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: fit,
          colorFilter: ColorFilter.mode(
            overlayColor,
            BlendMode.darken,
          ),
        ),
      ),
      child: child,
    );
  }
}
