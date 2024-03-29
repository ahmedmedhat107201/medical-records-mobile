import 'package:flutter/material.dart';

import '../../constant.dart';

class CustomDropDownFormField extends StatefulWidget {
  final List<String>? itemList;
  final String? lable;
  final Icon? icon;
  final String? startValue;
  final Function(String?)? onChanged;
  final validator;
  final Function(String?)? onSaved;
  final Color? menuColor;

  CustomDropDownFormField({
    required this.itemList,
    required this.lable,
    required this.icon,
    required this.onChanged,
    required this.startValue,
    this.validator,
    this.onSaved,
    this.menuColor,
  });

  @override
  _CustomDropDownFormFieldState createState() =>
      _CustomDropDownFormFieldState();
}

class _CustomDropDownFormFieldState extends State<CustomDropDownFormField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      onSaved: widget.onSaved,
      validator: widget.validator,
      hint: Text(
        '${widget.lable}',
        style: TextStyle(color: primaryColor),
      ),
      dropdownColor: widget.menuColor,
      decoration: InputDecoration(
        labelText: widget.lable,
        prefixIcon: widget.icon,
        labelStyle: TextStyle(color: primaryColor),
        fillColor: primaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: widget.onChanged,
      value: widget.startValue,
      items: widget.itemList!.map(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
    );
  }
}
