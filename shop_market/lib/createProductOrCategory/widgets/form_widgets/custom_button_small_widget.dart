import 'package:flutter/material.dart';
class CustomButtonSmallWidget extends StatelessWidget {
  const CustomButtonSmallWidget({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);
  final String label;
  final void Function () onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        width: 200,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              primary: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(label),
        ));
  }
}