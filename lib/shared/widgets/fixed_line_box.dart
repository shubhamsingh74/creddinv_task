import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reserves a fixed number of text lines so neighboring cards stay the same height.
class FixedLineBox extends StatelessWidget {
  const FixedLineBox({
    required this.lines,
    required this.style,
    required this.child,
    super.key,
  });

  final int lines;
  final TextStyle style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fontSize = style.fontSize ?? 14.sp;
    final height = style.height ?? 1.2;
    return SizedBox(height: fontSize * height * lines, child: child);
  }
}
