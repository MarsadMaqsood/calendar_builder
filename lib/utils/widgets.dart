import 'package:flutter/material.dart';

///easy Mod of [OutlinedButton]
class ModOutlineButton extends StatelessWidget {
  const ModOutlineButton({
    Key? key,
    required this.height,
    required this.width,
    this.onPressed,
    this.shape,
    this.borderSide,
    required this.child,
    this.overlayColor,
  }) : super(key: key);

  final double height;

  final double width;

  final VoidCallback? onPressed;

  final OutlinedBorder? shape;

  final BorderSide? borderSide;

  final Widget child;

  final Color? overlayColor;

  OutlinedBorder _handelButtonShape(Set<MaterialState> state) {
    return shape ?? const StadiumBorder();
  }

  BorderSide _handelBorderSide(Set<MaterialState> state) {
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
            shape: MaterialStateProperty.resolveWith(_handelButtonShape),
            overlayColor: MaterialStateProperty.all<Color>(
                overlayColor ?? Colors.blue[100]!),
            side: MaterialStateProperty.resolveWith(_handelBorderSide),
            
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
    final _paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = style;

    canvas.drawCircle(
        offset ?? Offset((size.width / 2), (size.height / 2)), radius, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
