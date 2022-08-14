import 'package:flutter/material.dart';

class CustomTitleWidget extends StatelessWidget {
  const CustomTitleWidget({Key? key, required this.title, required this.alignment}) : super(key: key);
  final String title;
  final TextAlign alignment;
  final Color? titleColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        textAlign: alignment,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: titleColor),
          
      ),
    );
  }
}
