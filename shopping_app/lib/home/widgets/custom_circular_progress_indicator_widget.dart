import 'package:flutter/material.dart';

class CustomCircularProgressIndicatorWidget extends StatelessWidget {
  const CustomCircularProgressIndicatorWidget({Key? key, this.text = ""})
      : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Color.fromRGBO(216, 67, 21, 1),
          ),
          Text(text)
        ],
      ),
    ));
  }
}
