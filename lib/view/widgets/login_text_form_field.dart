import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatefulWidget {
  final String? text;
  final String? hint;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool? isHiden;
  final TextInputType? keyboardType;

  CustomTextFormField({
    this.text = "Text",
    this.hint = "Hent",
    this.isHiden = false,
    required this.onSaved,
    required this.validator,
    required this.onChanged,
    this.keyboardType,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool hidePass = false;
  @override
  void initState() {
    hidePass = widget.isHiden!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomText(
          text: widget.text!,
          fontSize: 16,
          color: Colors.grey[700],
        ),
        SizedBox(height: 10),
        TextFormField(
          obscureText: hidePass,
          keyboardType: widget.keyboardType,
          onSaved: widget.onSaved!,
          validator: widget.validator!,
          onChanged: widget.onChanged!,
          decoration: InputDecoration(
            suffixIcon: widget.isHiden!
                ? GestureDetector(
                    child: Icon(
                        hidePass ? Icons.visibility : Icons.visibility_off),
                    onTap: () {
                      setState(() {
                        hidePass = !hidePass;
                      });
                    },
                  )
                : null,
            hintText: widget.hint!,
            hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
