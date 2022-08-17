import 'package:flutter/material.dart';
class CustomButtonSmallWidget extends StatelessWidget {
  const CustomButtonSmallWidget({
    Key? key,
    required this.label,
    required this.onPressed,
             this.iconButton
  }) : super(key: key);
  final String label;
  final IconData? iconButton;
  final void Function () onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.6,
        child: ElevatedButton.icon(
          icon:  Icon(iconButton),
          label: Text(label),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            
              primary: Colors.amber[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
        ));
  }
}