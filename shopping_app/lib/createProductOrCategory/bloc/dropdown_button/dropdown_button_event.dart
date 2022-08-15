part of 'dropdown_button_bloc.dart';


abstract class DropdownButtonEvent {}

class SelectCategory extends DropdownButtonEvent {
  final CategoryModel selectedCategory;
  SelectCategory({required this.selectedCategory});
}