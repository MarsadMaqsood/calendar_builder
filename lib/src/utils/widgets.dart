import 'package:flutter/material.dart';

///easy Mod of [OutlinedButton]
class ModOutlineButton extends StatelessWidget {
  ///easy Mod of [OutlinedButton]
  const ModOutlineButton({
    super.key,
    required this.height,
    required this.width,
    this.onPressed,
    this.shape,
    this.borderSide,
    required this.child,
    this.overlayColor,
  });

  ///Height of button
  final double height;

  ///Width  of button
  final double width;

  ///Callback on button pressed
  final VoidCallback? onPressed;

  /// Shape of button
  final OutlinedBorder? shape;

  /// set border forbutton
  final BorderSide? borderSide;

  /// add Child widget
  final Widget child;

  /// Overlay color of button
  final Color? overlayColor;

  OutlinedBorder _handelButtonShape(Set<WidgetState> state) {
    return shape ?? const StadiumBorder();
  }

  BorderSide _handelBorderSide(Set<WidgetState> state) {
    return borderSide ??
        BorderSide(
          color: Colors.grey[300]!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: WidgetStateProperty.resolveWith(_handelButtonShape),
            overlayColor: WidgetStateProperty.all<Color>(
                overlayColor ?? Colors.blue[100]!),
            side: WidgetStateProperty.resolveWith(_handelBorderSide),
          ),
          child: child,
        ),
      ),
    );
  }
}

///for faster performance
///we can add
///-- borders
///-- colors
class CirclePainter extends CustomPainter {
  ///
  CirclePainter({
    required this.color,
    required this.style,
    required this.strokeWidth,
    required this.radius,
    this.offset,
  });

  ///add color
  final Color color;

  ///Painting style
  final PaintingStyle style;

  ///border width
  final double strokeWidth;

  ///radius of the circle
  final double radius;

  ///offset
  final Offset? offset;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = style;

    canvas.drawCircle(
        offset ?? Offset((size.width / 2), (size.height / 2)), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
