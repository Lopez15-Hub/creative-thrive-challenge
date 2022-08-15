part of 'show_popup_bloc.dart';

class ShowPopupEvent extends Equatable {
  final bool mustBeShowed;
  final BuildContext context;
  final String categoryId;
  const ShowPopupEvent(
      {required this.mustBeShowed,
      required this.context,
      required this.categoryId});

  @override
  List<Object?> get props => [mustBeShowed, context, categoryId];
}
