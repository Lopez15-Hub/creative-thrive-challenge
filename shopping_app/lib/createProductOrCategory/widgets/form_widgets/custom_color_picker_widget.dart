import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({Key? key, required this.onChangeColorPicker}) : super(key: key);
  final void Function(Color) onChangeColorPicker;
  @override
  Widget build(BuildContext context) {
    return ColorPicker(
      pickerColor: Colors.deepPurple,
      onColorChanged: onChangeColorPicker,
    );
  }
}