import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/title_changer/title_changer_bloc.dart';
import 'package:shopping_app/createProductOrCategory/widgets/widgets.dart';
import '../widgets/form_widgets/widgets.dart';
import 'package:shopping_app/home/home.dart';

class FormCreateProductOrCategoryView extends StatelessWidget {
  const FormCreateProductOrCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppbarFormWidget(),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "Add Category",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              SwitchFormWidget(),
            ],
          ),
          BlocBuilder<TitleChangerBloc, bool>(
            builder: (context, currentForm) => !currentForm
                ? const ProductFormWidget()
                : const CategoryFormWidget(),
          )
        ],
      ),
    );
  }
}
