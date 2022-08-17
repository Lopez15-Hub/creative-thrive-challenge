import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/home/widgets/custom_popup_widget.dart';

import '../../../categories/models/category_model.dart';
part 'show_popup_event.dart';

class ShowPopupBloc extends Bloc<ShowPopupEvent, bool> {
  ShowPopupBloc() : super(false) {
    on<ShowPopupEvent>((event, emit) {
      emit(event.mustBeShowed);
      if (state) {
        customPopupWidget(
            event.context,
            'Are you sure?',
            'You must create the item later',
            event.categoryId,
            productId: event.productId,
            categories: event.categories,
            event.category);
      }
    });
  }
}
