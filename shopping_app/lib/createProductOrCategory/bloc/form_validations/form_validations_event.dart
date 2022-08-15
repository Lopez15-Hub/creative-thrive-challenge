part of 'form_validations_bloc.dart';

@immutable
abstract class FormValidationsEvent extends Equatable {}
class FormFieldsAreValidEvent extends FormValidationsEvent {
  final bool formIsValid;
  FormFieldsAreValidEvent(this.formIsValid);
  @override
  List<Object> get props => [formIsValid];
}
class ValidateProductFormEvent extends FormValidationsEvent {

  final CategoryModel dropdownCategory;
  final BuildContext context;
  ValidateProductFormEvent(
      {
      required this.dropdownCategory,
      required this.context
      });
  @override
  List<Object> get props => [dropdownCategory, context];
}

class ValidateCategoryFormEvent extends FormValidationsEvent {

  final BuildContext context;
  final String categoryColor;
  ValidateCategoryFormEvent({
    required this.context,
    required this.categoryColor,
  });
  @override
  List<Object> get props => [context, categoryColor];
}
