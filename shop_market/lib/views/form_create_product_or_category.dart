import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

class FormCreateProductOrCategory extends StatefulWidget {
  const FormCreateProductOrCategory({Key? key}) : super(key: key);
  @override
  State<FormCreateProductOrCategory> createState() =>
      _FormCreateProductOrCategoryState();
}

class _FormCreateProductOrCategoryState
    extends State<FormCreateProductOrCategory> {
  bool formSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("Create Category"),
              Switch(
                activeColor: Colors.white,
                activeTrackColor: Colors.deepOrange[800],
                value: formSelected,
                onChanged: (value) {
                  setState(() {
                    formSelected = value;
                  });
                },
              ),
            ],
          ),
          formSelected ? createProductCategory() : createProductForm(),
        ],
      ),
    );
  }

  Widget customFormButtonSubmit(void Function() onPressed, String buttonLabel) {
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

  Widget createProductForm() => Form(
          child: Column(
        children: [
          const Text("Create Product"),
          const Text("Image product"),
          ElevatedButton(onPressed:()=> showGaleryToPickImage(), child: Text("Select image")),
          customFormField(
            TextInputType.text,
            false,
            'Name of product',
            const Icon(
              Icons.description,
              color: Color.fromRGBO(216, 67, 21, 1),
            ),
          ),
          customFormField(
            TextInputType.text,
            false,
            'Category',
            const Icon(
              Icons.category,
              color: Color.fromRGBO(216, 67, 21, 1),
            ),
          ),
          customFormButtonSubmit(
            () {},
            'Submit product',
          ),
        ],
      ));

  Widget createProductCategory() => Form(
          child: Column(
        children: [
          const Text("Create Category"),
          customFormField(
            TextInputType.text,
            false,
            'Category Name',
            const Icon(
              Icons.description,
              color: Color.fromRGBO(216, 67, 21, 1),
            ),
          ),
          const Text("Define color"),
          showColorPicker(),
          customFormButtonSubmit(
            () {},
            'Submit category',
          ),
        ],
      ));

  Widget customFormField(
          TextInputType type, bool hideText, String label, Icon icon) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          keyboardType: type,
          obscureText: hideText,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.black),
            icon: icon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color.fromRGBO(216, 67, 21, 1)),
            ),
          ),
        ),
      );

  ColorPicker showColorPicker() {
    return ColorPicker(
      pickerColor: Colors.deepPurple,
      onColorChanged: (color) => print(color),
    );
  }

  showGaleryToPickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // Capture a photo
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  }
}
