import 'package:devfest_hackaton/utils/colors.dart';
import 'package:devfest_hackaton/utils/fontsize.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.color = AppColors.textColor,
    this.fontSize = AppFontSize.medium,
    this.isBold = false,
    this.textAlign = TextAlign.left,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
  });

  final String data;
  final Color color;
  final double fontSize;
  final bool isBold;
  final TextAlign textAlign;
  final bool softWrap;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
