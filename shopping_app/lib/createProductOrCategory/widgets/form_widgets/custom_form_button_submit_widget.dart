import 'package:flutter/material.dart';

class CustomFormButtonSubmitWidget extends StatelessWidget {
  const CustomFormButtonSubmitWidget({Key? key, required this.onPressed, required this.buttonLabel}) : super(key: key);
  final void Function() onPressed;
  final String buttonLabel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            primary: Colors.deepOrange[800],
          ),
          child: Text(buttonLabel),
        ),
      ),
    );
  }
}
