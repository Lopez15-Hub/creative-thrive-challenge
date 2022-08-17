import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/title_changer/title_changer_bloc.dart';
import 'package:shopping_app/createProductOrCategory/widgets/widgets.dart';
import '../widgets/form_widgets/widgets.dart';
import 'package:shopping_app/home/home.dart';

class FormCreateProductOrCategoryView extends StatelessWidget {
  const FormCreateProductOrCategoryView({Key? key, this.addCategory = false})
      : super(key: key);
  final bool addCategory;

  @override
  Widget build(BuildContext context) {
    final titleChangerBloc = BlocProvider.of<TitleChangerBloc>(context);
    titleChangerBloc.add(ChangeTitle(addCategory));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppbarFormWidget(),
      drawer: const CustomDrawerWidget(),
      body: FadeIn(
        animate: true,
        child: Column(
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
      ),
    );
  }
}
