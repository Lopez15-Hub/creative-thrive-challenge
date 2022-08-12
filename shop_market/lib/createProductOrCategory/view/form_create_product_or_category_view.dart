import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/title_changer/title_changer_bloc.dart';
import 'package:shop_market/createProductOrCategory/widgets/widgets.dart';
import '../widgets/form_widgets/widgets.dart';
import 'package:shop_market/home/home.dart';

class FormCreateProductOrCategoryView extends StatelessWidget {
  const FormCreateProductOrCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKeyForm = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKeyForm,
      appBar: AppbarFormWidget(scaffoldKey: scaffoldKeyForm),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text("Create Category"),
              SwitchFormWidget(),
            ],
          ),

          BlocBuilder<TitleChangerBloc, bool>(
            builder: (context, currentForm) =>
                !currentForm ? const ProductFormWidget() : const CategoryFormWidget(),
          )
        ],
      ),
    );
  }

}
