
import 'package:flutter/material.dart';

class CustomZShape extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color=Colors.black;
    paint.style=PaintingStyle.fill;
    var path = Path();
   // path.moveTo(size.width*0.3, size.height/2);
    path.lineTo(50, 0);//top
    path.lineTo(40, 25);//right
    path.lineTo(-10, 25);//bottom
    path.lineTo(0, 0);//left
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }



}