import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginBackground extends CustomPainter {

  LoginBackground({@required this.isJoin});

  final bool isJoin;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = isJoin?Colors.lightGreen:Colors.blue;
    canvas.drawCircle(Offset(size.width*0.5,size.height*0.2), size.height*0.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
  
}