import '../../home/bloc/blocs.dart';
import '../bloc/categories_bloc.dart';
import 'category_model.dart';

class CategoryListViewOptionsModel{
  final List<CategoryModel> categories, categoriesToShow;
  final ShowPopupBloc showPopupBloc;
  final CategoriesBloc categoriesBloc;
  final Function(int oldIndex,int newIndex) onReorder;

  CategoryListViewOptionsModel({
    required this.categories,
    required this.categoriesToShow,
    required this.onReorder,
    required this.showPopupBloc,
    required this.categoriesBloc,
  
  });
}