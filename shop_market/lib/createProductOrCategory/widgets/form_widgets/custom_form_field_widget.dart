import 'package:flutter/material.dart';

class CustomFormFieldWidget extends StatelessWidget {
  const CustomFormFieldWidget(
      {Key? key,
      required this.keyboardType,
      required this.obscureText,
      required this.label,
      required this.icon,
      required this.onChanged,
      required this.fieldController})
      : super(key: key);
  final TextInputType keyboardType;
  final bool obscureText;
  final String label;
  final Icon icon;
  final Function onChanged;
  final TextEditingController fieldController;
  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    );
    const edgeInsets = EdgeInsets.all(20.0);
    var inputDecoration = InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          icon: icon,
          border: outlineInputBorder,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color.fromRGBO(216, 67, 21, 1)),
          ),
        );
    var cursorColor = Colors.black;
    return Padding(
      padding: edgeInsets,
      child: TextField(
        controller: fieldController,
        keyboardType: keyboardType,
        obscureText: obscureText,
        cursorColor: cursorColor,
        decoration: inputDecoration,
      ),
    );
  }
}
