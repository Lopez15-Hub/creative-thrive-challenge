import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/categories/categories.dart';
import 'package:shopping_app/createProductOrCategory/bloc/blocs.dart';
import 'package:shopping_app/createProductOrCategory/repository/products_repository.dart';

part 'form_validations_event.dart';
class FormValidationsBloc extends Bloc<FormValidationsEvent, bool> {

  final ProductsBloc productsBloc = ProductsBloc(productRepository: ProductsRepository());
  FormValidationsBloc() : super(false) {
    
    on<FormFieldsAreValidEvent>((event, emit) => emit(event.formIsValid));

    on<ValidateProductFormEvent>((event, emit) {
      if (event.dropdownCategory.toJson().isEmpty)return productsBloc.add(ProductFunctionHasErrorEvent(error: 'You must select a category', context: event.context));
      if (!state)return productsBloc.add(ProductFunctionHasErrorEvent( error: 'Fields can\'t be empty', context: event.context));
    });
    on<ValidateCategoryFormEvent>((event, emit) {
      if (event.categoryColor.isEmpty)return productsBloc.add(ProductFunctionHasErrorEvent(error: 'You must select a color', context: event.context));
      if (!state)return productsBloc.add(ProductFunctionHasErrorEvent( error: 'Fields can\'t be empty', context: event.context));
    });
  }
}
