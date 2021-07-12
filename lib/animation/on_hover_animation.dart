import 'package:flutter/material.dart';

class OnHoverAnimation extends StatefulWidget {
  final Widget child;
  const OnHoverAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _OnHoverAnimationState createState() => _OnHoverAnimationState();
}

class _OnHoverAnimationState extends State<OnHoverAnimation> {
  late bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1.1);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();

    return MouseRegion(
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: transform,
          transformAlignment: FractionalOffset.center,
          child: widget.child),
    );
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}
