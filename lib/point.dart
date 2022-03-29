import 'package:flutter/material.dart';
import 'dart:math';

// 手势密码盘上的圆点
class GesturePoint {
  static final pointPainter = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.yellow;

  static final linePainter = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.2
    ..color = Colors.red;

  final int index;
  final double centerX;
  final double centerY;
  static const double radius = 4;
  final double padding;
  final double halfPadding;

  GesturePoint(this.index, this.centerX, this.centerY, this.padding)
      : halfPadding = padding / 2 - radius;

  // 绘制小圆点
  void drawCircle(Canvas canvas) {
    canvas.drawOval(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        pointPainter);

    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(centerX, centerY),
            height: padding - radius,
            width: padding - radius),
        linePainter);
  }

  // to suppose squares, change canvas.drawOval to drawRect and change
  // the algorithm below to be
  // return x >= centerX - halfPadding && x <= centerX + halfPadding &&
  //   y >= centerY - halfPadding && y <= centerY + halfPadding;
  // and the results will be ugly.  So, stick with circles.
  // 判断坐标是否在小圆内（padding为半径）
  bool checkInside(double x, double y) {
    var distance = sqrt(pow((x - centerX), 2) + pow((y - centerY), 2));
    return distance <= halfPadding;
  }

  @override
  bool operator ==(Object other) {
    if (other is GesturePoint) {
      return this.index == other.index &&
          this.centerX == other.centerX &&
          this.centerY == other.centerY;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode;
}
