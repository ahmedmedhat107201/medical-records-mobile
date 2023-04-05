// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../constant.dart';

class CustomDropDownFormField extends StatefulWidget {
  final itemList;
  final String? lable;
  final Icon? icon;

  CustomDropDownFormField({
    required this.itemList,
    required this.lable,
    required this.icon,
  });

  @override
  _CustomDropDownFormFieldState createState() =>
      _CustomDropDownFormFieldState();
}

class _CustomDropDownFormFieldState extends State<CustomDropDownFormField> {
  String? _selectedItem;

  final List<String> _items = <String>[
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: widget.lable,
        prefixIcon: widget.icon,
        labelStyle: TextStyle(
          color: primaryColor,
        ),
        fillColor: primaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      value: _selectedItem,
      onChanged: (String? newValue) {
        setState(() {
          _selectedItem = newValue;
        });
      },
      items: widget.itemList.map(
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
