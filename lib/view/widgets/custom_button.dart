import 'package:flutter/material.dart';

import '../../constant.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;

  const CustomButton({
    this.text = "button Text",
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      child: CustomText(
        text: text!,
        alignment: Alignment.center,
        color: Colors.white,
      ),
      color: primaryColor,
      onPressed: onPressed!,
    );
  }
}
