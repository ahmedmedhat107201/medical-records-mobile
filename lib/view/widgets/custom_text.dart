import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color? color;
  final Alignment? alignment;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow overFlow;

  const CustomText({
    this.text = "",
    this.fontSize = 16,
    this.color = Colors.black,
    this.alignment = Alignment.topLeft,
    this.fontWeight,
    this.maxLines,
    this.overFlow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment!,
      child: Text(
        text!,
        style: TextStyle(
          color: color!,
          fontSize: fontSize!,
          fontWeight: fontWeight,
        ),
        maxLines: maxLines,
        // overflow: overFlow,
      ),
    );
  }
}
