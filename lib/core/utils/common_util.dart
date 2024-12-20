// ignore: avoid_web_libraries_in_flutter
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import "package:path/path.dart" as p;

dynamic choose({
  required bool condition,
  required dynamic vt,
  required dynamic vf,
}) {
  switch (condition) {
    case true:
      return vf;
    case false:
      return vt;
    default:
      return vf;
  }
}

String formatDate(String? date, {String of = "d MMMM yyyy"}) {
  return date != null ? DateFormat(of).format(DateTime.parse(date)) : "";
}

Widget loadAssetPic(
  String asset, {
  double? width,
  double? height,
  BoxFit? fit,
  Color? color,
  BlendMode? mode,
  double? padding,
  double? vPadding,
  double? hPadding,
  double? tPadding,
  double? bPadding,
  double? sPadding,
  double? ePadding,
}) =>
    Container(
      width: width,
      height: height,
      padding: padding != null
          ? EdgeInsetsDirectional.all(padding)
          : vPadding != null || hPadding != null
              ? EdgeInsetsDirectional.symmetric(
                  vertical: vPadding ?? 0,
                  horizontal: hPadding ?? 0,
                )
              : EdgeInsetsDirectional.only(
                  start: sPadding ?? 0,
                  top: tPadding ?? 0,
                  end: ePadding ?? 0,
                  bottom: bPadding ?? 0,
                ),
      child: p.extension(asset) == ".svg"
          ? SvgPicture.asset(
              asset,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null
                  ? ColorFilter.mode(color, mode ?? BlendMode.srcIn)
                  : null,
            )
          : Image.asset(
              asset,
              width: width,
              height: height,
              fit: fit ?? BoxFit.contain,
              color: color,
            ),
    );

// TO DRAW DOTTED BORDERS //
class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final BorderRadius borderRadius;

  DottedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    BorderRadius? borderRadius,
  }) : borderRadius = borderRadius ?? BorderRadius.zero;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      ));

    // Create a path effect for dotted line
    final dashPath = _createDashPath(path, dashArray: [2.0, 1.0]);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashPath(Path source,
      {List<double> dashArray = const <double>[5.0, 3.0]}) {
    final dashPath = Path();
    for (PathMetric pathMetric in source.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < pathMetric.length) {
        final double length = dashArray[0];
        if (draw) {
          dashPath.addPath(
            pathMetric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;

        // Add space between dashes
        if (draw) {
          distance += dashArray[1];
        }
      }
    }
    return dashPath;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
