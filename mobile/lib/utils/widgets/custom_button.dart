import 'dart:ui';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final bool isDashed;
  final double cornerLength;      // Насколько «далеко» заходит уголок
  final double cornerWidth;       // Толщина линии уголка
  final double dashWidth;
  final double dashGap;
  final Color? borderColor;       // Сделаем опциональным
  final double borderRadius;      // Радиус скругления общего прямоугольника (для пунктира)
  final double cornerRadius;      // Небольшое «внутреннее» скругление L-образного уголка

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.isDashed = false,
    this.cornerLength = 10.0,
    this.cornerWidth = 2.5,
    this.dashWidth = 10.0,
    this.dashGap = 8.0,
    this.borderColor,              // По умолчанию null
    this.borderRadius = 10.0,
    this.cornerRadius = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Получаем цвета из темы, если не заданы явно
    final Color effectiveBorderColor =
        borderColor ?? Theme.of(context).colorScheme.primary;

    final TextStyle effectiveTextStyle = textStyle?.copyWith(
          color: textStyle!.color ?? Theme.of(context).colorScheme.primary,
        ) ??
        TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.primary,
        );

    return GestureDetector(
      onTap: onPressed,
      child: CustomPaint(
        painter: ButtonPainter(
          isDashed: isDashed,
          cornerLength: cornerLength,
          cornerWidth: cornerWidth,
          dashWidth: dashWidth,
          dashGap: dashGap,
          borderColor: effectiveBorderColor, // Используем цвет из темы
          borderRadius: borderRadius,
          cornerRadius: cornerRadius,
        ),
        child: Padding(
          padding: padding,
          child: Text(
            text,
            style: effectiveTextStyle, // Используем стиль с цветом из темы
          ),
        ),
      ),
    );
  }
}

class ButtonPainter extends CustomPainter {
  final bool isDashed;
  final double cornerLength;
  final double cornerWidth;
  final double dashWidth;
  final double dashGap;
  final Color borderColor;
  final double borderRadius;
  final double cornerRadius;

  ButtonPainter({
    required this.isDashed,
    required this.cornerLength,
    required this.cornerWidth,
    required this.dashWidth,
    required this.dashGap,
    required this.borderColor,
    required this.borderRadius,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = borderColor
      ..strokeWidth = cornerWidth
      ..style = PaintingStyle.stroke;

    // Прямоугольник для пунктирной рамки
    final RRect outerRRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );

    if (isDashed) {
      _drawDashedBorder(canvas, outerRRect, paint);
    } else {
      _drawRoundedCorners(canvas, outerRRect, paint);
    }
  }

  /// Рисуем пунктир по периметру RRect
  void _drawDashedBorder(Canvas canvas, RRect rrect, Paint paint) {
    final Path path = Path()..addRRect(rrect);
    final PathMetrics pathMetrics = path.computeMetrics();
    final Path dashedPath = Path();

    for (final PathMetric metric in pathMetrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final Tangent? startTangent = metric.getTangentForOffset(distance);
        if (startTangent != null) {
          final Tangent? endTangent =
              metric.getTangentForOffset(distance + dashWidth);
          if (endTangent != null) {
            dashedPath.moveTo(startTangent.position.dx, startTangent.position.dy);
            dashedPath.lineTo(endTangent.position.dx, endTangent.position.dy);
          }
        }
        distance += dashWidth + dashGap;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  /// Рисуем L-образные уголки с небольшим внутренним скруглением
  void _drawRoundedCorners(Canvas canvas, RRect rrect, Paint paint) {
    final Path path = Path();

    // --- Левый верхний угол ---
    path.moveTo(rrect.left, rrect.top + cornerLength);
    // линия до точки, где начинается дуга
    final ltArcStart = Offset(rrect.left, rrect.top + cornerRadius);
    path.lineTo(ltArcStart.dx, ltArcStart.dy);
    // рисуем дугу к (rrect.left + cornerRadius, rrect.top)
    final ltArcEnd = Offset(rrect.left + cornerRadius, rrect.top);
    path.arcToPoint(
      ltArcEnd,
      radius: Radius.circular(cornerRadius),
      clockwise: true, // небольшая дуга наружу
    );
    // дальше тянем линию вправо
    path.lineTo(rrect.left + cornerLength, rrect.top);

    // --- Правый верхний угол ---
    path.moveTo(rrect.right - cornerLength, rrect.top);
    final rtArcStart = Offset(rrect.right - cornerRadius, rrect.top);
    path.lineTo(rtArcStart.dx, rtArcStart.dy);
    final rtArcEnd = Offset(rrect.right, rrect.top + cornerRadius);
    path.arcToPoint(
      rtArcEnd,
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );
    path.lineTo(rrect.right, rrect.top + cornerLength);

    // --- Правый нижний угол ---
    path.moveTo(rrect.right, rrect.bottom - cornerLength);
    final rbArcStart = Offset(rrect.right, rrect.bottom - cornerRadius);
    path.lineTo(rbArcStart.dx, rbArcStart.dy);
    final rbArcEnd = Offset(rrect.right - cornerRadius, rrect.bottom);
    path.arcToPoint(
      rbArcEnd,
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );
    path.lineTo(rrect.right - cornerLength, rrect.bottom);

    // --- Левый нижний угол ---
    path.moveTo(rrect.left + cornerLength, rrect.bottom);
    final lbArcStart = Offset(rrect.left + cornerRadius, rrect.bottom);
    path.lineTo(lbArcStart.dx, lbArcStart.dy);
    final lbArcEnd = Offset(rrect.left, rrect.bottom - cornerRadius);
    path.arcToPoint(
      lbArcEnd,
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );
    path.lineTo(rrect.left, rrect.bottom - cornerLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
